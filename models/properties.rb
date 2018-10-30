require('pg')
require('pry-byebug')

class Property

  attr_accessor :id, :address, :value, :num_bed, :build

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @address = options['address']
    @value = options['value'].to_i
    @num_bed = options['num_bed'].to_i
    @build = options['build']
  end

  def save()
    db = PG.connect({dbname: 'properties', host: 'localhost'})
    sql = "INSERT INTO properties (address, value, num_bed, build) VALUES ($1, $2, $3, $4) RETURNING *;"
    values = [@address, @value, @num_bed, @build]
    db.prepare("save", sql)
    results = db.exec_prepared("save", values)
    @id = results[0]['id'].to_i
    db.close()
  end

  def update()
    db = PG.connect({dbname: 'properties', host: 'localhost'})
    sql = "UPDATE properties SET (address, value, num_bed, build) = ($1, $2, $3, $4) WHERE id = $5;"
    values = [@address, @value, @num_bed, @build, @id]
    db.prepare("update", sql)
    db.exec_prepared("update", values)
    db.close()
  end

  def Property.delete_all()
    db = PG.connect({dbname: 'properties', host: 'localhost'})
    sql = "DELETE FROM properties;"
    db.prepare("delete_all",sql)
    db.exec_prepared("delete_all")
    db.close()
  end

  def delete()
    db = PG.connect({dbname: 'properties', host: 'localhost'})
    sql = "DELETE FROM properties WHERE id = $1;"
    values = [@id]
    db.prepare("delete",sql)
    db.exec_prepared("delete",values)
    db.close()
  end

  def Property.find_by_id(id)
    db = PG.connect({dbname: 'properties', host: 'localhost'})
    sql = "SELECT * FROM properties WHERE id = $1;"
    values = [id]
    db.prepare("find_by_id",sql)
    results = db.exec_prepared("find_by_id",values)
    db.close()
    return results.map  {|result| Property.new(result)}
  end

  def Property.find_by_address(address)
    db = PG.connect({dbname: 'properties', host: 'localhost'})
    sql = "SELECT * FROM properties WHERE address = $1;"
    values = [address]
    db.prepare("find_by_address",sql)
    results = db.exec_prepared("find_by_address",values)
    db.close()
    return results.map  {|result| Property.new(result)}
  end

end
