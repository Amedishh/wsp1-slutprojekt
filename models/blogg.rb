require_relative 'base'

class Blogg < Base

  def self.all()
    sql_bloggs = 'SELECT * FROM bloggs'

    bloggs = db.execute(sql_bloggs)

    return bloggs
  end

  def self.create(rubrik, beskrivning)
    db.execute("INSERT INTO bloggs (heading, description) VALUES (?,?)", [rubrik, beskrivning])
  end

  def self.find(id)
    sql_bloggs = 'SELECT * FROM bloggs where id=?'

    blogg = db.execute(sql_bloggs, id).first

    return blogg
  end

  def self.delete(id)
    db.execute('DELETE FROM bloggs WHERE id=?', id)
  end

end