# frozen_string_literal: true

require 'fileutils'

class Dumpen
  # Superclass for a server specific class that writes SQL dumps to disk.
  class Dumper
    attr_reader :path

    def initialize(path)
      @path = path
    end

    def prefix
      raise NoMethodError, 'Not implemented by dumper subclass.'
    end

    def command
      raise NoMethodError, 'Not implemented by dumper subclass.'
    end

    def basename
      Time.now.strftime('%Y%m%d.sql')
    end

    def filepath
      File.join(path, prefix)
    end

    def filename
      File.join(filepath, basename)
    end

    def run
      Dumpen.logger.info("Dumping `#{filename}'")
      FileUtils.mkdir_p(filepath)
      system(command)
    rescue Exception => e
      warn "Failed to dump: #{e.message}"
    end

    def self.run(path)
      new(path).run
    end
  end
end
