class Expense
attr_reader :description, :amount, :id

  def initialize(attributes)
    @description = attributes['description']
    @amount = attributes['amount'].to_f
    @id = attributes['id']
  end

  def self.all
    expenses = []
    results = DB.exec("SELECT * FROM expense")
    results.each do |result|
      description = result['description']
      amount = result['amount'].to_f
      id = result['id'].to_i
      expenses << Expense.new({'description' => description, 'amount' => amount, 'id' => id})
    end
    expenses
  end

  def save
    results = DB.exec("INSERT INTO expense (description, amount) VALUES ('#{@description}', #{@amount}) RETURNING id;")
    @id = results.first['id'].to_i
  end

  def ==(other_id)
    @id == other_id.id
  end

  def category
    categories = []
    results = DB.exec("SELECT category.* FROM expense
                      JOIN expense_category ON (expense.id = expense_category.expense_id)
                      JOIN category ON (expense_category.category_id = category_id)
                      WHERE expense.id = #{self.id}")
    results.each do |result|
      id = result['id']
      name = result['name']
      categories << Category.new({'name' => name, 'id' => id})
    end
    categories
  end

  def add_category(category_id)
    DB.exec("INSERT INTO expense_category (expense_id, category_id) VALUES (#{self.id}, #{category_id.id});")
  end

  def delete_expense!
    DB.exec("DELETE FROM expense WHERE id = #{self.id};")
  end
end
