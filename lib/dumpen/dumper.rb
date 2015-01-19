require 'fileutils'

class Dumpen
  class Dumper
    attr_reader :path

    def initialize(path)
      @path = path
    end

    def prefix
      raise NoMethodError, "Not implemented by dumper subclass."
    end

    def command
      raise NoMethodError, "Not implemented by dumper subclass."
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
    end

    def self.run(path)
      new(path).run
    end
  end
end
