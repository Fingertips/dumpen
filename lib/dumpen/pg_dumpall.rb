class Dumpen
  class PgDumpall < Dumper
    def prefix
      'postgres'
    end

    def command
      "pg_dumpall > #{filename}"
    end
  end
end