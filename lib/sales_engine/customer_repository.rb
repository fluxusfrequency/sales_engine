require_relative '../sales_engine.rb'

class SalesEngine
  class CustomerRepository
    attr_reader :customers, :file, :data

    def initialize(file)
      @file = file
      @data = Loader.load(file)
      populate_list
    end

    def all
      customers
    end

    def random
      customers.sample
    end

    private

    def populate_list
      @customers = data.collect do |row|
        Customer.new(row, SalesEngine)
      end
    end

    [:id, :first_name, :last_name, :created_at, :updated_at].each do |attr|
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

  end
end
