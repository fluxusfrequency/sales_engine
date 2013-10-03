class SalesEngine
  class CustomerRepository

    attr_reader :file, :customers

    def initialize(file)
      @file = file
      populate_list
    end

    def populate_list
      data = Database.load(file)
      @customers = data.collect do |row|
        Customer.new(row)
      end
    end

    def all
      customers
    end

  end
end