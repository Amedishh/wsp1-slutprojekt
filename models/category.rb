require_relative 'base'

class Category < Base

  def self.all
    db.execute('SELECT * FROM categories')
  end

  def self.find(id)
    db.execute('SELECT * FROM categories WHERE id = ?', id).first
  end

  def self.create(title)
    db.execute('INSERT INTO categories (category_title) VALUES (?)', [title])
  end

  def self.update(id,title)
    db.execute('UPDATE categories SET category_title = ? WHERE id = ?', [title. id])
  end

  def self.destroy(id)
    db.execute('DELETE FROM categories WHERE id = ?', id)
  end
end