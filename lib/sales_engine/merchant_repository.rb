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

    def random
      merchants.sample
    end

    def most_items(x)
      merchants_sorted_by_items_sold.reverse[0,x]
    end

    def most_revenue(x)
      merchants_sorted_by_revenue.reverse[0,x]
    end

    def revenue(date)
      sum = merchants.map {|merchant| merchant.revenue(date)}.inject(BigDecimal.new(0),:+)
      BigDecimal.new(sum)
    end

    def merchants_sorted_by_items_sold
      merchants.sort_by { |merchant| merchant.items_on_successful_invoices.length }
    end

    def merchants_grouped_by_revenue
      merchants.group_by { |merchant| merchant.revenue }
    end

    def merchants_sorted_by_revenue
      merchants.sort_by { |merchant| merchant.revenue }
    end

    def find_by_id(id)
      grouped_by_id[id].first
    end

    def find_all_by_id(id)
      grouped_by_id[id] || []
    end

    def find_by_name(name)
      grouped_by_name[name].first
    end

    def find_all_by_name(name)
      grouped_by_name[name] || []
    end

    def find_by_created_at(date)
      grouped_by_created_at[date].first
    end

    def find_all_by_created_at(date)
      grouped_by_created_at[date] || []
    end

    def find_by_updated_at(date)
      grouped_by_updated_at[date].first
    end

    def find_all_by_updated_at(date)
      grouped_by_updated_at[date] || []
    end

    def grouped_by_id
      @grouped_by_id ||= merchants.group_by {|merchant| merchant.id }
    end

    def grouped_by_name
      @grouped_by_name ||= merchants.group_by {|merchant| merchant.name }
    end

    def grouped_by_created_at
      @grouped_by_created_at ||= merchants.group_by {|merchant| merchant.created_at }
    end

    def grouped_by_updated_at
      @grouped_by_updated_at ||= merchants.group_by {|merchant| merchant.updated_at }
    end

  end
end