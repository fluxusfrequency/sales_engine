require_relative 'loader'

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

end

