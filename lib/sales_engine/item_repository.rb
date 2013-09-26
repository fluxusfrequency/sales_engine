require_relative 'loader'
require_relative '../sales_engine.rb'

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
