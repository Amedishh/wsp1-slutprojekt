require_relative 'base'
require 'bcrypt'

class User < Base

  def self.find_by_username(username)
    db.execute(
      "SELECT * FROM users WHERE username = ?",
      username
    ).first
  end

  def self.find(id)
    db.execute(
      "SELECT * FROM users WHERE id = ?",
      id
    ).first
  end

end