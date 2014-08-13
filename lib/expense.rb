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
end
