class SalesEngine
  class MerchantRepository

    attr_reader :file, :merchants

    def initialize(file)
      @file = file
      populate_list
    end

    def populate_list
      data = Database.load(file)
      @merchants = data.collect do |row|
        Merchant.new(row)
      end
    end

    def all
      merchants
    end

  end
end