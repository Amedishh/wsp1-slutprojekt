require_relative 'base'

class Blogg < Base

  def self.all()
    sql_bloggs = 'SELECT bloggs.*, categories.category_title
      FROM bloggs
        INNER JOIN categories
          ON category_id = categories.id'

    bloggs = db.execute(sql_bloggs)

    return bloggs
  end

  

  def self.create(rubrik, beskrivning, category_id)
    db.execute("INSERT INTO bloggs (heading, description, category_id) VALUES (?,?,?)", [rubrik, beskrivning, category_id])
  end

  def self.find(id)
    sql_bloggs = 'SELECT bloggs.*, categories.category_title
      FROM bloggs
        INNER JOIN categories
          ON bloggs.category_id = categories.id
        WHERE bloggs.id = ?'

    blogg = db.execute(sql_bloggs, id).first

    return blogg
  end

  def self.delete(id)
    db.execute('DELETE FROM bloggs WHERE id=?', id)
  end

  def self.update(id, rubrik, beskrivning, category_id)
    sql_save_blogg = 'UPDATE bloggs SET heading =?, description =?, category_id =? WHERE id =?'
    p rubrik
    p beskrivning
    db.execute(sql_save_blogg, [rubrik, beskrivning, category_id, id])
  end

  def self.all_by_category_id(category_id)
    sql_bloggs = 'SELECT bloggs.*, categories.category_title
    FROM bloggs
      INNER JOIN categories
        ON bloggs.category_id = categories.id
      WHERE bloggs.id = ?'

    bloggs = db.execute(sql_bloggs, category_id)
    return bloggs
  end

end