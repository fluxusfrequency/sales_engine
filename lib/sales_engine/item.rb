require_relative '../sales_engine.rb'

class SalesEngine
  class Item

    attr_reader :id, :name, :description, :unit_price, :merchant_id, :created_at, :updated_at

    def initialize(data={})
    end

  end
end