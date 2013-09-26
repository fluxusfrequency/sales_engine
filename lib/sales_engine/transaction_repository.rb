require_relative 'loader'

class SalesEngine
  class TransactionRepository
    attr_reader :transactions

    def initialize(file)
      @data = Loader.load(file)
      populate_list
    end

    def all
      transactions
    end

    def random
      transactions.sample
    end

    private

    def populate_list
      @transactions = @data.collect do |row|
        Transaction.new(row, SalesEngine)
      end
    end

    [:id, :invoice_id, :credit_card_number, :result, :created_at, :updated_at].each do |attr|
      define_method("find_by_#{attr}") do |match|
        match ||= ''
        transactions.find { |transaction| transaction.send(attr).to_s == match.to_s }
      end
    end

    [:id, :invoice_id, :credit_card_number, :result, :created_at, :updated_at].each do |attr|
        define_method("find_all_by_#{attr}") do |match|
          match ||= ''
          transactions.select { |transaction| transaction.send(attr).to_s == match.to_s }
        end
      end

  end
end
