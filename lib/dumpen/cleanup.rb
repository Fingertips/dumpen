require 'date'
require 'find'

class Dumpen
  class Cleanup < Dumper
    KEEP_DAYS = 14

    def initialize(path)
      @path = path
    end

    def run
      Find.find(path) do |filename|
        if File.file?(filename)
          basename = File.basename(filename, '.sql')
          date = Date.parse(basename)
          age_in_days = (Date.today - date).to_i
          if age_in_days > KEEP_DAYS
            Dumpen.logger.info("Cleaning up `#{filename}' because it's #{age_in_days} days old")
            FileUtils.rm_f(filename)
          end
        end
      end
    end

    def self.run(path)
      new(path).run
    end
  end
end
