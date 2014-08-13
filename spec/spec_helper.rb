require 'rspec'
require './lib/expense'
require './lib/category'
require 'pg'
require 'pry'

DB = PG.connect({:dbname => 'money'})

RSpec.configure do |config|
  config.after(:each) do
    DB.exec("DELETE FROM expense *;")
  end
end
