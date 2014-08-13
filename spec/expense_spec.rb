require 'spec_helper'

describe Expense do
  it 'is initialized with a hash of attributes' do
    new_expense = Expense.new({'description' => 'coffee', 'amount' => 2.30})
    expect(new_expense).to be_an_instance_of Expense
  end

  it 'willl start with an empty array' do
    expect(Expense.all).to eq []
  end
end

