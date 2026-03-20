#Denna rb filen är för att kunna sätta ihop vår blogg och app för att kommunicera med db.

class Base

  def self.db
    return @db if @db

    @db = SQLite3::Database.new(DB_PATH)
    @db.results_as_hash = true

    @db
  end
end