require_relative 'loader'

class InvoiceItemRepository
  attr_reader :invoice_items

  def initialize(file)
    @data = Loader.load(file)
    populate_list
  end

  def populate_list
    @invoice_items = @data.collect do |row|
      InvoiceItem.new({ 
        :id => row[:id],
        :item_id => row[:item_id],
        :invoice_id => row[:invoice_id],
        :quantity => row[:quantity],
        :unit_price => row[:unit_price],
        :created_at => row[:created_at],
        :updated_at => row[:updated_at]
      })
    end
  end

  def all
    invoice_items
  end

  def random
    invoice_items.sample
  end

  def find_by_X(match)
  end

  def find_all_by_X(match)
  end
end
