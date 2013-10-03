require_relative '../sales_engine.rb'

class SalesEngine
  class Item

    attr_reader :id, :name, :description, :unit_price, :merchant_id, :created_at, :updated_at

    def initialize(data={})
      @id = data[:id].to_s
      @name = data[:name].to_s
      @description = data[:description].to_s
      @unit_price = data[:unit_price].to_s
      @merchant_id = data[:merchant_id].to_s
      @created_at = Date.parse(data[:created_at])
      @updated_at = Date.parse(data[:updated_at])
    end

  end
end