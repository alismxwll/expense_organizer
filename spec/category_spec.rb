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
end
