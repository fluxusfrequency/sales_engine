require_relative '../sales_engine.rb'

class SalesEngine
  class Customer

    attr_reader :id, :first_name, :last_name, :created_at, :updated_at

    def initialize(data={})
      @id = data[:id].to_s
      @first_name = data[:first_name].to_s
      @last_name = data[:last_name].to_s
      @created_at = Date.parse(data[:created_at].to_s)
      @updated_at = Date.parse(data[:updated_at].to_s)
    end

  end
end