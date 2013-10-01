require_relative '../sales_engine.rb'

class SalesEngine
  class MerchantRepository
    attr_reader :merchants, :file, :data

    def initialize(file)
      @file = file
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
      x ||= 0
      sorted = merchants.each {|merchant| merchant.revenue}
      sorted[0..x-1]
    end

    #   returns the top x merchant instances ranked by total number of items sold
    def most_items(x)
      x ||= 0
      count = count_all_merchant_sales
      sorted_array = count.sort_by {|merchant, sales| sales}
      inner = sorted_array[0..(x-1)].collect do |inner_array|
        inner_array.first
      end
      inner[0..x-1]
    end

    def revenue(date)
      # returns the total revenue for that date across all merchants
      revenue = 0
      merchants.each do |merchant|
        revenue += merchant.revenue
      end
      revenue
    end

    private

    def populate_list
      @merchants = data.collect do |row|
        Merchant.new(row, SalesEngine)
      end
    end

    def count_all_merchant_sales
      merchant_sales = Hash.new(0)
      merchants.each_with_object(merchant_sales) do |merchant|
        merchant.successful_invoices.each do |invoice|
          merchant_sales[merchant] += invoice.items.length
        end
      end
      merchant_sales
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

