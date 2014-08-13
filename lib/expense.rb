class Expense
attr_reader :description, :amount

  def initialize(attributes)
    @description = attributes['description']
    @amount = attributes['amount']
  end

  def self.all
    []
  end
end
