# frozen_string_literal: true

class Dumpen
  # Runs pg_dumpall to export all databases.
  class PgDumpall < Dumper
    def prefix
      'postgres'
    end

    def command
      "pg_dumpall > #{filename}"
    end
  end
end
