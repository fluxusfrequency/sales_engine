require_relative 'loader'
require_relative 'transaction'

class TransactionRepository
  attr_reader :transactions

  def initialize(file)
    @data = Loader.load(file)
    populate_list
  end

  def populate_list
    @transactions = @data.collect do |row|
      Transaction.new({
        :id => row[:id],
        :invoice_id => row[:invoice_id],
        :credit_card_number => row[:credit_card_number],
        :credit_card_expiration_date => row[:credit_card_expiration_date],
        :result => row[:result],
        :merchant_id => row[:merchant_id],
        :created_at => row[:created_at],
        :updated_at => row[:updated_at]
      })
    end
  end

  def all
    transactions
  end

  def random
    transactions.sample
  end

  private

  def self.generate_find_by_methods
    attrs = [:result, :created_at, :updated_at]
    attrs_with_int = [:id, :invoice_id, :credit_card_number, :credit_card_expiration_date]
    attrs.each do |attr|
      define_method("find_by_#{attr}") do |match|
        transactions.find { |transaction| transaction.send(attr) == match }
      end
    end
    attrs_with_int.each do |attr|
      define_method("find_by_#{attr}") do |match|
        transactions.find { |transaction| transaction.send(attr).to_i == match }
      end
    end
  end

  def self.generate_find_all_by_methods
    attrs = [:result, :created_at, :updated_at]
    attrs_with_int = [:id, :invoice_id, :credit_card_number, :credit_card_expiration_date]
    attrs.each do |attr|
      define_method("find_all_by_#{attr}") do |match|
        transactions.select { |transaction| transaction.send(attr) == match }
      end
    end
    attrs_with_int.each do |attr|
      define_method("find_all_by_#{attr}") do |match|
        transactions.select { |transaction| transaction.send(attr).to_i == match }
      end
    end
  end

  generate_find_by_methods
  generate_find_all_by_methods

end
