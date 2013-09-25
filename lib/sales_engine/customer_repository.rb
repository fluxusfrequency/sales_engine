require_relative 'loader'

module SalesEngine
  class CustomerRepository
    attr_reader :customers

    def initialize(file)
      @data = Loader.load(file)
      populate_list
    end

    def populate_list
      @customers = @data.collect do |row|
        Customer.new({
          :id => row[:id],
          :first_name => row[:first_name],
          :last_name => row[:last_name],
          :created_at => row[:created_at],
          :updated_at => row[:updated_at]
        })
      end
    end

    def all
      customers
    end

    def random
      customers.sample
    end

    private

    def self.generate_find_by_methods
      attrs = [:id, :first_name, :last_name, :created_at, :updated_at]
      attrs.each do |attr|
        define_method("find_by_#{attr}") do |match|
          match ||= ''
          customers.find { |customer| customer.send(attr).to_s == match.to_s }
        end
      end
      # attrs_with_int = []
      # attrs_with_int.each do |attr|
      #   define_method("find_by_#{attr}") do |match|
      #     match ||= ''
      #     customers.find { |customer| customer.send(attr).to_s == match.to_s }
      #   end
      # end
    end

    def self.generate_find_all_by_methods
      attrs = [:id, :first_name, :last_name, :created_at, :updated_at]
      attrs.each do |attr|
        define_method("find_all_by_#{attr}") do |match|
          match ||= ''
          customers.select { |customer| customer.send(attr).to_s == match.to_s }
        end
      end
      # attrs_with_int = []
      # attrs_with_int.each do |attr|
      #   define_method("find_all_by_#{attr}") do |match|
      #     match ||= ''
      #     customers.select { |customer| customer.send(attr).to_s == match.to_s }
      #   end
      # end
    end

    generate_find_by_methods
    generate_find_all_by_methods

  end
end
