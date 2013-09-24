require_relative 'loader'

class ItemRepository
  attr_reader :items

  def initialize(file)
    @data = Loader.load(file)
    populate_list
  end

  def populate_list
    @items = @data.collect do |row|
      Item.new({
        :id => row[:id],
        :name => row[:name],
        :description => row[:description],
        :unit_price => row[:unit_price],
        :merchant_id => row[:merchant_id],
        :created_at => row[:created_at],
        :updated_at => row[:updated_at]
      })
    end
  end

  def all
    items
  end

  def random
    items.sample
  end

  def find_by_id(match)
    items.find { |item| item.id.to_i == match }
  end

  def find_all_by_id(match)
    items.select { |item| item.id.to_i == match }
  end

  def find_by_name(match)
  end

  def find_all_by_name(match)
  end

  def find_by_description(match)
  end

  def find_all_by_description(match)
  end

  def find_by_unit_price(match)
  end

  def find_all_by_unit_price(match)
  end

  def find_by_merchant_id(match)
  end

  def find_all_by_merchant_id(match)
  end

  def find_by_created_at(match)
  end

  def find_all_by_created_at(match)
  end

  def find_by_updated_at(match)
  end

  def find_all_by_updated_at(match)
  end
end
