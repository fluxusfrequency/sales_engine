require_relative 'loader'

class ItemRepository
  attr_reader :list

  def initialize(file)
    @items = Loader.load(file)
    populate_list
  end

  def populate_list
    @list = @items.collect do |row|
      item = {
        :id => row[:id],
        :name => row[:name],
        :description => row[:description],
        :unit_price => row[:unit_price],
        :merchant_id => row[:merchant_id],
        :created_at => row[:created_at],
        :updated_at => row[:updated_at]
      }
    end
  end

  def all
  end

  def random
  end

  def find_by_X(match)
  end

  def find_all_by_X(match)
  end
end
