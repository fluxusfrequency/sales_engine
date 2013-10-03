require_relative '../sales_engine.rb'

class SalesEngine
  class Customer

    attr_reader :id, :first_name, :last_name, :created_at, :updated_at

    def initialize(data={})
      @file = file
    end

  end
end