# frozen_string_literal: true

require 'logger'
require 'fileutils'

require 'dumpen/dumper'
require 'dumpen/cleanup'
require 'dumpen/mysqldump'
require 'dumpen/pg_dumpall'

# Dumps the full database from all available database servers to disk.
class Dumpen
  LOG_FILENAMES = [
    '/var/log/dumpen.log',
    '~/dumpen.log'
  ].freeze

  def self.log_filename
    @log_filename ||= begin
      LOG_FILENAMES.select do |path|
        expanded_path = File.expand_path(path)
        begin
          File.open(expanded_path, 'a').close
          return expanded_path
        rescue Errno::EACCES
        end
      end; nil
    end
  end

  def self.logger
    if (filename = log_filename)
      FileUtils.mkdir_p(File.dirname(filename))
      Logger.new(open(filename, 'a'))
    else
      Logger.new($stderr)
    end
  rescue Errno::EACCES => e
    warn("[!] Unable to open log file at `#{log_filename}' (#{e.message})")
    exit(-1)
  end

  # Implements command-line interaction for dumpen.
  class CLI
    def initialize(argv)
      @argv = argv
    end

    def path
      @argv[0]
    end

    def run
      Dumpen.logger.info('Started dumpen')
      Dumpen::Mysqldump.run(path)
      Dumpen::PgDumpall.run(path)
      Dumpen::Cleanup.run(path)
      Dumpen.logger.info('Done!')
    end

    def self.run(argv)
      new(argv).run
    end
  end
end
