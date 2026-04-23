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
    db.execute('DROP TABLE IF EXISTS categories')
  end

  def self.create_tables
    db.execute('CREATE TABLE "bloggs" (
                id INTEGER PRIMARY KEY AUTOINCREMENT,
                heading TEXT NOT NULL,
                category_id INTEGER, 
                description TEXT)')

    db.execute('CREATE TABLE "categories" (
               id INTEGER PRIMARY KEY AUTOINCREMENT,
               category_title TEXT
               )')
  end


  def self.populate_tables
    db.execute('INSERT INTO bloggs (heading, description, category_id) VALUES ("Mina hobbyn", "Jag gillar nämligen att...", 1)')
    db.execute('INSERT INTO bloggs (heading, description, category_id) VALUES ("Mitt arbete", "Idag så jobbar jag med...", 2)')
    db.execute('INSERT INTO bloggs (heading, description, category_id) VALUES ("Mina äventyr", "Mina resor kring världen...", 3)')

    db.execute('INSERT INTO categories (category_title) VALUES ("Nature")')
    db.execute('INSERT INTO categories (category_title) VALUES ("Technology")')
    db.execute('INSERT INTO categories (category_title) VALUES ("Adventure")')
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
