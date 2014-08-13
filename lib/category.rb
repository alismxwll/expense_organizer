class Category
  attr_reader :name, :id

  def initialize(attributes)
    @name = attributes['name']
    @id = attributes['id']
  end

  def self.all
    categories = []
    results = DB.exec("SELECT * FROM category;")
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
    self
  end

  def ==(another_category)
    self.name == another_category.name
  end

  def expenses
    expenses = []
    results = DB.exec("SELECT expense.* FROM category
                      JOIN expense_category ON (category.id = expense_category.category_id)
                      JOIN expense ON (expense_category.expense_id = expense_id)
                      WHERE category.id = #{self.id};")
    results.each do |result|
      id = result['id'].to_i
      description = result['description']
      amount = result['amount'].to_f
      expenses << Expense.new({'description' => description, 'amount' => amount, 'id' => id})
    end
    expenses
  end

  def add_expense(expense)
    DB.exec("INSERT INTO expense_category (expense_id, category_id) VALUES (#{expense.id}, #{self.id});")
  end

  def self.find_or_create(thing)
    Category.all.each do |category|
      if thing == category.name
        return category
      end
    end
     Category.new({'name' => thing}).save
  end


end
