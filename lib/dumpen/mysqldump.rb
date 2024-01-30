# frozen_string_literal: true

class Dumpen
  # Runs mysqldump to export all databases.
  class Mysqldump < Dumper
    def prefix
      'mysql'
    end

    def command
      "mysqldump --user=root --all-databases > #{filename}"
    end
  end
end
