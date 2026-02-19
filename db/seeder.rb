require 'sqlite3'

class Seeder

  def self.seed!
    puts "Using db file: #{DB_PATH}"
    puts "🧹 Dropping old tables..."
    drop_tables
    puts "🧱 Creating tables..."
    create_tables
    puts "🍎 Populating tables..."
    populate_tables
    puts "✅ Done seeding the database!"
  end

  def self.drop_tables
    db.execute('DROP TABLE IF EXISTS accounts')
  end

  def self.create_tables
    db.execute('CREATE TABLE accounts (
                id INTEGER PRIMARY KEY AUTOINCREMENT,
                name TEXT NOT NULL,
                category_id INTEGER, 
                description TEXT,
                done INTEGER)')
  end

  def self.populate_tables
    db.execute('INSERT INTO accounts (name, description, done) VALUES ("Köp mjölk", "3 lite mellanmjölk, eko,", 1)')
    db.execute('INSERT INTO accounts (name, description, done) VALUES ("Köp julgran", "En rödgran", 0)')
    db.execute('INSERT INTO accounts (name, description, done) VALUES ("Pynta gran", "Glöm inte lamporna i granen och tomten", 0)')
  end

  private

  def self.db
    @db ||= begin
      db = SQLite3::Database.new(DB_PATH)
      db.results_as_hash = true
      db
    end
  end

end

Seeder.seed!
