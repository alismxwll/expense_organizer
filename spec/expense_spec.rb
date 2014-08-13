require 'spec_helper'

describe Expense do
  it 'is initialized with a hash of attributes' do
    new_expense = Expense.new({'description' => 'coffee', 'amount' => 2.30})
    expect(new_expense).to be_an_instance_of Expense
  end

  it 'will start with an empty array' do
    expect(Expense.all).to eq []
  end

  it 'will save a new expense to the array of expenses' do
    new_expense = Expense.new({'description' => 'coffee', 'amount' => 2.30})
    new_expense.save
    expect(Expense.all).to eq [new_expense]
  end

  it 'will be the same object if it has the same id' do
    new_expense = Expense.new({'description' => 'coffee', 'amount' => 2.30})
    new_expense.save
    expect(Expense.all).to eq [new_expense]
  end

  it 'is a different object if it has a different id' do
    new_expense = Expense.new({'description' => 'coffee', 'amount' => 2.30})
    new_expense.save
    new_expense2 = Expense.new({'description' => 'coffee', 'amount' => 2.30})
    new_expense2.save
    expect(Expense.all).to eq [new_expense, new_expense2]
  end
end

