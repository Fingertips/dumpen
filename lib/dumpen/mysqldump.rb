class Dumpen
  class Mysqldump
    def self.run
      "mysqldump --user=root --all-databases > filename"
    end
  end
end
