require_relative 'loader'
require_relative 'transaction'

module SalesEngine
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
      attrs = [:id, :invoice_id, :credit_card_number, :result, :created_at, :updated_at]
      attrs.each do |attr|
        define_method("find_by_#{attr}") do |match|
          match ||= ''
          transactions.find { |transaction| transaction.send(attr).to_s == match.to_s }
        end
      end
      # attrs_with_int = []
      # attrs_with_int.each do |attr|
      #   define_method("find_by_#{attr}") do |match|
      #     match ||= ''
      #     transactions.find { |transaction| transaction.send(attr).to_s == match.to_s }
      #   end
      # end
    end

    def self.generate_find_all_by_methods
      attrs = [:id, :invoice_id, :credit_card_number, :result, :created_at, :updated_at]
      attrs.each do |attr|
        define_method("find_all_by_#{attr}") do |match|
          match ||= ''
          transactions.select { |transaction| transaction.send(attr).to_s == match.to_s }
        end
      end
      # attrs_with_int = []
      # attrs_with_int.each do |attr|
      #   define_method("find_all_by_#{attr}") do |match|
      #     match ||= ''
      #     transactions.select { |transaction| transaction.send(attr).to_s == match.to_s }
      #   end
      # end
    end

    generate_find_by_methods
    generate_find_all_by_methods

  end
end
