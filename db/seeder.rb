require 'sqlite3'
require_relative '../config'

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
    db.execute('DROP TABLE IF EXISTS bloggs')
  end

  def self.create_tables
    db.execute('CREATE TABLE bloggs (
                id INTEGER PRIMARY KEY AUTOINCREMENT,
                heading TEXT NOT NULL,
                category_id INTEGER, 
                description TEXT)')
  end

  def self.populate_tables
    db.execute('INSERT INTO bloggs (heading, description) VALUES ("Mina hobbyn", "Mi bomb")')
    db.execute('INSERT INTO bloggs (heading, description) VALUES ("Mitt arbete", "mi boommbaaa")')
    db.execute('INSERT INTO bloggs (heading, description) VALUES ("Mina äventyr", "MI BOMBAAA")')
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
