require_relative 'base'

class Blogg < Base

  def self.create(rubrik, beskrivning)
    db.execute("INSERT INTO bloggs (heading, description) VALUES (?,?)", [rubrik, beskrivning])
  end

end