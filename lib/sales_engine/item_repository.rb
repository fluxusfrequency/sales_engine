require_relative 'loader'
require 'bigdecimal'

class SalesEngine
  class ItemRepository
    attr_reader :items

    def initialize(file)
      @data = Loader.load(file)
      populate_list
    end

    def all
      items
    end

    def random
      items.sample
    end

    def most_revenue(x)
    #   returns the top x item instances ranked by total revenue generated
      item_revenues = Hash.new(BigDecimal.new(0))
      items.each_with_object(item_revenues) do |item|
        item_revenues[item] += item.revenue_generated
      end
      sorted_item_count_nested_array = item_revenues.sort_by{|item, revenue| revenue }.reverse
      sorted_items = sorted_item_count_nested_array.collect do |inner_array|
        inner_array.first
      end
      sorted_items[0..x.to_i]
    end

    # def most_items(x)
    #   returns the top x item instances ranked by total number sold
    # end

    private

    def populate_list
      @items = @data.collect do |row|
        Item.new(row, SalesEngine)
      end
    end

    [:id, :name, :description, :unit_price, :merchant_id, :created_at, :updated_at].each do |attr|
      define_method("find_by_#{attr}") do |match|
        items.find { |item| item.send(attr).to_s == match.to_s }
      end
    end

    [:id, :name, :description, :unit_price, :merchant_id, :created_at, :updated_at].each do |attr|
      define_method("find_all_by_#{attr}") do |match|
        items.select { |item| item.send(attr).to_s == match.to_s }
      end
    end

  end
end
