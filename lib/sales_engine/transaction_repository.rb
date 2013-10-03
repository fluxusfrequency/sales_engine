class SalesEngine
  class TransactionRepository

    attr_reader :file, :transactions

    def initialize(file)
      @file = file
      populate_list
    end

    def populate_list
      data = Database.load(file)
      @transactions = data.collect do |row|
        Transaction.new(row)
      end
    end

    def all
      transactions
    end

  end
end