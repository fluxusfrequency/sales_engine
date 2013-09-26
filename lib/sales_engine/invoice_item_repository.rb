require_relative 'loader'

class SalesEngine
  class InvoiceItemRepository
    attr_reader :invoice_items

    def initialize(file)
      @data = Loader.load(file)
      populate_list
    end

    def all
      invoice_items
    end

    def random
      invoice_items.sample
    end

    private

    def populate_list
      @invoice_items = @data.collect do |row|
        InvoiceItem.new(row, SalesEngine)
      end
    end

    [:id, :item_id, :invoice_id, :quantity, :unit_price, :created_at, :updated_at].each do |attr|
      define_method("find_by_#{attr}") do |match|
        match ||= ''
        invoice_items.find { |invoice_item| invoice_item.send(attr).to_s == match.to_s }
      end
    end

    [:id, :item_id, :invoice_id, :quantity, :unit_price, :created_at, :updated_at].each do |attr|
      define_method("find_all_by_#{attr}") do |match|
        match ||= ''
        invoice_items.select { |invoice_item| invoice_item.send(attr).to_s == match.to_s }
      end
    end

  end
end
