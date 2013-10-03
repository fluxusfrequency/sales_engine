class SalesEngine
  class TransactionRepository

    attr_reader :file

    def initialize(file)
      @file = file
    end

  end
end