require_relative '../sales_engine.rb'

class SalesEngine
  class ItemRepository
    attr_reader :items, :file, :data

    def initialize(file)
      @file = file
      @data = SalesEngine::Database.load(file)
      populate_list
    end

    def find_by_unit_price(match)
      items.find { |item| BigDecimal.new(item.unit_price) / 100 == match }
    end

    def find_all_by_unit_price(match)
      items.select { |item| BigDecimal.new(item.unit_price) / 100  == match }
    end

    def all
      items
    end

    def random
      items.sample
    end

    def most_revenue(x)
      item_revenues = Hash.new(0)

      items.each do |item|
        item_revenues[item] += item.revenue_generated
      end

      sorted_revenues = item_revenues.values.sort_by{|value| value.to_i}.reverse
      top_producers = sorted_revenues[0,x].collect do |revenue|
        item_revenues[revenue]
      end

      top_producers
    end

    def most_items(x)
      item_counts = Hash.new(0)

      items.each do |item|
        item_counts[item] = item.number_sold
      end

      sorted_item_sales = item_counts.values.sort.reverse
      top_sellers = sorted_item_sales[0,x].collect do |revenue|
        item_counts[revenue]
      end
      top_sellers
    end

    [:name, :description, :merchant_id, :created_at, :updated_at].each do |attr|
      define_method("find_by_#{attr}") do |match|
        items.find { |item| item.send(attr).to_s == match.to_s }
      end
    end

    [:id, :name, :description, :created_at, :updated_at].each do |attr|
      define_method("find_all_by_#{attr}") do |match|
        items.select { |item| item.send(attr).to_s == match.to_s }
      end
    end

    def find_by_id(id)
      Array(items_grouped_by_id[id.to_i]).first
    end

    def items_grouped_by_id
      @items_grouped_by_id ||= all.group_by { |item| item.id.to_i }
    end

    def find_all_by_merchant_id(merchant_id)
      items_grouped_by_merchant_id[merchant_id.to_i] || []
    end

    def items_grouped_by_merchant_id
      @items_grouped_by_merchant_id ||= all.group_by { |item| item.merchant_id.to_i }
    end

    private

    def populate_list
      @items = data.collect do |row|
        Item.new(row, SalesEngine)
      end
    end

  end
end
