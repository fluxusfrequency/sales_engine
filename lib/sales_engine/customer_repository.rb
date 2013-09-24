require_relative 'loader'

class CustomerRepository
  attr_reader :customer

  def initialize(file)
    @customer - Loader.load(file)
    populate_list
  end

  def populate_list
    @customer = @data.collect do |row|
      Customer.new({
        :id => row[:id]
        :first_name => row[:first_name]
        :last_name => row[:last_name]
        :created_at => row[:created_at]
        :updated_at => row[:updated_at]
      })

  def all
    customers
  end

  def random
    customers.sample
  end

end

