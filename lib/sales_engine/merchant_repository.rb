require_relative 'loader'

class SalesEngine
  class MerchantRepository
    attr_reader :merchants

    def initialize(file)
      @data = Loader.load(file)
      populate_list
    end

    def all
      merchants
    end

    def random
      merchants.sample
    end

    def most_revenue(x)
      [SalesEngine::Merchant.new({}, SalesEngine)]
    end

    # def most_items(x)
    #   returns the top x merchant instances ranked by total number of items sold
    # end

    # def revenue(date)
    #   returns the total revenue for that date across all merchants
    # end

    private

    def populate_list
      @merchants = @data.collect do |row|
        Merchant.new(row, SalesEngine)
      end
    end

    [:id, :name, :created_at, :updated_at].each do |attr|
      define_method("find_by_#{attr}") do |match|
        merchants.find { |merchant| merchant.send(attr).to_s == match.to_s }
      end
    end

    [:id, :name, :created_at, :updated_at].each do |attr|
      define_method("find_all_by_#{attr}") do |match|
        merchants.select { |merchant| merchant.send(attr).to_s == match.to_s }
      end
    end

  end
end

#loads up the merchants from the csv
#each merchant in the repo responds to the merhcant class methods

