require_relative '../sales_engine.rb'

class SalesEngine
  class CustomerRepository
    attr_reader :customers, :file, :data

    def initialize(file)
      @file = file
      @data = SalesEngine::Database.load(file)
      populate_list
    end

    def all
      customers
    end

    def random
      customers.sample
    end



    [:first_name, :last_name, :created_at, :updated_at].each do |attr|
      define_method("find_by_#{attr}") do |match|
        match ||= ''
        customers.find { |customer| customer.send(attr).to_s == match.to_s }
      end
    end

    [:id, :first_name, :last_name, :created_at, :updated_at].each do |attr|
      define_method("find_all_by_#{attr}") do |match|
        match ||= ''
        customers.select { |customer| customer.send(attr).to_s == match.to_s }
      end
    end

    def find_by_id(id)
      Array(customers_grouped_by_id[id.to_i]).first
    end

    def customers_grouped_by_id
      @customers_grouped_by_id ||= all.group_by { |customer| customer.id.to_i }
    end

    private

    def populate_list
      @customers = data.collect do |row|
        Customer.new(row, SalesEngine)
      end
    end

  end
end
