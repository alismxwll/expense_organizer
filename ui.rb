require './lib/expense'
require './lib/category'
require 'pry'
require 'pg'

DB = PG.connect({:dbname => 'money'})

def main_menu
  puts "Press 'd' to add an expense\nPress 'u' to show the categories\nPress 'c' to show your expenses\nPress 'k' to exit"
  user_input = gets.chomp
  if user_input == 'd'
    add_expense_to_a_category
  elsif user_input == 'u'
    show_categories
  elsif user_input == 'c'
    show_expenses
  elsif user_input == 'k'
    puts "Goodbye."
    exit
  else
    puts 'Not a valid option.'
  end
end

  def add_expense_to_a_category
    puts 'What did you waste your money on?'
    description_input = gets.chomp
    puts 'How much did you waste?'
    amount_input = gets.chomp.to_f
    new_expense = Expense.new({'description' => description_input, 'amount' => amount_input.to_i})
    new_expense.save
    puts 'Expense Added.'
    puts 'Select a category or create a new one?'
    list_categories
    input = gets.chomp
    Category.find_or_create(input)
    puts 'Your covered in beans!'
    main_menu
  end

  def show_categories
    Category.all.each do |category|
      puts category.name
    end
    main_menu
  end

  def show_expenses
    Expense.all.each do |expense|
      puts expense.description
    end
    main_menu
  end

  def list_categories
    Category.all.each do |category|
      puts category.name
    end
  end

  def list_expenses
    Expense.all.each do |expense|
      puts expense.description
    end
  end
main_menu

