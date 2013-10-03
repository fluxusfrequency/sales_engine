require_relative '../sales_engine.rb'

class SalesEngine
  class Transaction

    attr_reader :id, :name, :created_at, :updated_at

    def initialize(data={})
      @file = file
    end

  end
end