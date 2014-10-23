class Dumpen
  class PgDumpall
    def self.run
      "pg_dumpall --username=root > filename"
    end
  end
end