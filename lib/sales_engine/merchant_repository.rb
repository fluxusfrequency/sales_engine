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

    def most_revenue(x=1)
      x ||= 0
      sorted ||= merchants.each {|merchant| merchant.revenue}
      sorted[0..x.to_i]
    end

    #   returns the top x merchant instances ranked by total number of items sold
    def most_items(x)
      x ||= 0
      count = count_all_merchant_sales
      count.sort_by {|merchant, sales| sales}
      count[0..x.to_i]
    end

    def revenue(date)
      # returns the total revenue for that date across all merchants
      revenue = 0
      merchants.each do |merchant|
        revenue += merchant.revenue(date)
      end
      revenue
    end

    private

    def populate_list
      @merchants = @data.collect do |row|
        Merchant.new(row, SalesEngine)
      end
    end

    def count_all_merchant_sales
      merchant_sales = Hash.new(0)
      merchants.each_with_object(merchant_sales) do |merchant|
        successful_invoices = merchant.invoices - merchant.find_pending_invoices
        successful_invoices.each do |invoice|
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

