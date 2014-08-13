class Category
  attr_reader :name, :id

  def initialize(attributes)
    @name = attributes['name']
    @id = attributes['id']
  end

  def self.all
    categories = []
    results = DB.exec("SELECT * FROM category")
    results.each do |result|
      name = result['name']
      id = result['id'].to_i
      categories << Category.new({'name' => name, 'id' => id})
    end
    categories
  end

  def save
    results = DB.exec("INSERT INTO category (name) VALUES ('#{@name}') RETURNING id;")
    @id = results.first['id'].to_i
  end

  def ==(another_category)
    self.name == another_category.name
  end
end
