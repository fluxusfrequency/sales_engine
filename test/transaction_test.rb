gem 'minitest'
require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/sales_engine/transaction.rb'

class TransactionTest < Minitest::Test
  attr_accessor :transaction

  def setup
    @transaction = Transaction.new(1, "Schroeder-Jerde", "2012-03-27 14:53:59 UTC", "2012-03-27 14:53:59 UTC")
  end

  def test
    true
  end
end
