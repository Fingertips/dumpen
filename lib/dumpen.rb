require 'logger'
require 'fileutils'

require 'dumpen/mysqldump'
require 'dumpen/pg_dumpall'

class Dumpen
  LOG_FILENAME = '/var/log/dumpen.log'

  def self.log_filename
    LOG_FILENAME
  end

  def self.logger
    FileUtils.mkdir_p(File.dirname(log_filename))
    File.open(log_filename, 'a') {}
    # Logger.new(open(log_filename, 'a'))
  rescue Errno::EACCES => exception
    STDERR.puts("[!] Unable to open log file at `#{log_filename}' (#{exception.message})")
    exit -1
  end

  class CLI
    def self.run(argv)
      Dumpen.logger.info("Started dumpen")
      Mysqldump.run
      PgDumpall.run
    end
  end
end