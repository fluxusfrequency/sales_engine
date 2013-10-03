require_relative '../sales_engine.rb'

class SalesEngine
  class Customer

    attr_reader :id, :first_name, :last_name, :created_at, :updated_at

    def initialize(data={})
      @id = data[:id]
      @first_name = data[:first_name]
      @last_name = data[:last_name]
      @created_at = Date.parse(data[:created_at])
      @updated_at = Date.parse(data[:updated_at])
    end

  end
end