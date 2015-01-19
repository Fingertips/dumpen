class Dumpen
  class Mysqldump < Dumper
    def prefix
      'mysql'
    end

    def command
      "mysqldump --user=root --all-databases > #{filename}"
    end
  end
end
