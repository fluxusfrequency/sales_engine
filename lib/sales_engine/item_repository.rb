require_relative '../sales_engine.rb'

class SalesEngine
  class ItemRepository
    attr_reader :items, :file, :data

    def initialize(file)
      @file = file
      @data = Loader.load(file)
      populate_list
    end

    def find_by_unit_price(match)
      items.find { |item| BigDecimal.new(item.unit_price) == match }
    end

    def find_all_by_unit_price(match)
      items.select { |item| BigDecimal.new(item.unit_price) == match }
    end

    def all
      items
    end

    def random
      items.sample
    end

    def most_revenue(x)
    #   returns the top x item instances ranked by total revenue generated
      item_revenues = Hash.new(0)
      items.each_with_object(item_revenues) do |item|
        item_revenues[item] += item.revenue_generated
      end

      sorted_item_count_nested_array = item_revenues.sort_by{|item, revenue| revenue }.reverse
      sorted_items = sorted_item_count_nested_array.collect do |inner_array|
        inner_array.first
      end
      sorted_items[0..x.to_i-1]
    end

    def most_items(x)
      item_counts = Hash.new(0)
      items.each_with_object(item_counts) do |item|
        item_counts[item] += item.number_sold
      end

      sorted_item_sales_nested_array = item_counts.sort_by{|item, count| count}.reverse
      sorted_counts = sorted_item_sales_nested_array.collect do |inner_array|
        inner_array.first
      end
      sorted_counts[0..x.to_i]
    end

    private

    def populate_list
      @items = data.collect do |row|
        Item.new(row, SalesEngine)
      end
    end

    [:id, :name, :description, :merchant_id, :created_at, :updated_at].each do |attr|
      define_method("find_by_#{attr}") do |match|
        items.find { |item| item.send(attr).to_s == match.to_s }
      end
    end

    [:id, :name, :description, :merchant_id, :created_at, :updated_at].each do |attr|
      define_method("find_all_by_#{attr}") do |match|
        items.select { |item| item.send(attr).to_s == match.to_s }
      end
    end

  end
end
