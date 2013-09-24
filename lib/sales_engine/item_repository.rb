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

  def self.generate_find_by_methods
    attrs = [:name, :description, :created_at, :updated_at]
    attrs_with_int = [:id, :unit_price, :merchant_id]
    attrs.each do |attr|
      define_method("find_by_#{attr}") do |match|
        items.find { |item| item.send(attr) == match }
      end
    end
    attrs_with_int.each do |attr|
      define_method("find_by_#{attr}") do |match|
        items.find { |item| item.send(attr).to_i == match }
      end
    end
  end

  def self.generate_find_all_by_methods
    attrs = [:name, :description, :created_at, :updated_at]
    attrs_with_int = [:id, :unit_price, :merchant_id]
    attrs.each do |attr|
      define_method("find_all_by_#{attr}") do |match|
        items.select { |item| item.send(attr) == match }
      end
    end
    attrs_with_int.each do |attr|
      define_method("find_all_by_#{attr}") do |match|
        items.select { |item| item.send(attr).to_i == match }
      end
    end
  end

  # def find_by_id(match)
  #   items.find { |item| item.id.to_i == match }
  # end

  # def find_all_by_id(match)
  #   items.select { |item| item.id.to_i == match }
  # end

generate_find_by_methods
generate_find_all_by_methods

end

