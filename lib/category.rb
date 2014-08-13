class Category
  attr_reader :name, :id

  def initialize(attributes)
    @name = attributes['name']
    @id = attributes['id']
  end

  def self.all
    []
  end

  def save
    results = DB.exec("INSERT INTO category (name) VALUES ('#{@name}') RETURNING id;")
    @id = results.first['id'].to_i
  end

end
