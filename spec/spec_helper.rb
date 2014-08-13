require 'rspec'
require './lib/expense'
require './lib/category'
require 'pg'
require 'pry'

DB = PG.connect({:dbname => 'money'})
