require 'spec_helper'

describe Category do
  it 'is initialized with a hash of attributes' do
    new_category = Category.new({'name' => 'Foodu'})
    expect(new_category).to be_an_instance_of Category
  end

  it 'starts with an empty array' do
    expect(Category.all).to eq []
  end

  it 'saves it to the database' do
    new_category = Category.new({'name' => 'Foodu'})
    new_category.save
    expect(Category.all).to eq [new_category]
  end

  it 'is the same category if it has the same name' do
    new_category = Category.new({'name' => 'Foodu'})
    new_category.save
    new_category_two = Category.new({'name' => 'Foodu'})
    new_category_two.save
    expect(new_category).to eq new_category_two
  end

  it 'adds and expense to a category' do
    new_category = Category.new({'name' => 'Foodu'})
    new_category.save
    new_expense = Expense.new({'description' => 'Dog Food', 'amount' => 28.97})
    new_expense.save
    new_category.add_expense(new_expense)
    expect(new_category.expenses).to eq [new_expense]
  end

  describe 'find_or_create' do
    it 'returns the category if there is one with the given name' do
      new_category = Category.new({'name' => 'Foodu'})
      expect(Category.find_or_create('Foodu')).to eq new_category
    end

    it 'it creates a new category if there is not one that matches the given name' do
      new_category = Category.find_or_create('Biscuits')
      expect(Category.all).to eq [new_category]
    end
  end
end
