require_relative '../sales_engine.rb'

class SalesEngine
  class MerchantRepository
    attr_reader :merchants, :file, :data

    def initialize(file)
      @file = file
      @data = SalesEngine::Database.load(file)
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
      hash = Hash.new
      merchants.each do |merchant|
        hash[merchant] = merchant.revenue
      end

      top_revenues = hash.values.sort_by{|v|v.to_s}.reverse
      top_producers = []
      top_revenues.each_with_index do |revenue, index|
        top_producers << hash.keys.find {|k| hash[k] == top_revenues[index]}
        break if index <= x
      end
      top_producers
    end

    #   returns the top x merchant instances ranked by total number of items sold
    def most_items(x)
      x ||= 0
      count = count_all_merchant_sales
      sorted_array = count.sort_by {|merchant, sales| sales}.reverse.flatten
      sorted_array[0..x-1]
    end

    def revenue(date)
      revenue = 0
      merchants.each do |merchant|
        revenue += merchant.revenue(date)
      end
      revenue
    end

    [:name, :created_at, :updated_at].each do |attr|
      define_method("find_by_#{attr}") do |match|
        merchants.find { |merchant| merchant.send(attr).to_s == match.to_s }
      end
    end

    [:id, :name, :created_at, :updated_at].each do |attr|
      define_method("find_all_by_#{attr}") do |match|
        merchants.select { |merchant| merchant.send(attr).to_s == match.to_s }
      end
    end

    def find_by_id(id)
      Array(merchants_grouped_by_id[id.to_i]).first
    end

    def merchants_grouped_by_id
      @merchants_grouped_by_id ||= all.group_by { |merchant| merchant.id.to_i }
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

  end
end

#loads up the merchants from the csv
#each merchant in the repo responds to the merhcant class methods

