require_relative 'loader'

class SalesEngine
  class InvoiceItemRepository

    attr_reader :invoice_items, :file, :data

    def initialize(file)
      @file = file
      @data = SalesEngine::Loader.load(file)
      populate_list
    end

    def all
      invoice_items
    end

    def random
      invoice_items.sample
    end

    def save_new_invoice_item_row(invoice_item)
      invoice_item_attrs = [invoice_item.id, invoice_item.item_id, invoice_item.invoice_id, invoice_item.quantity, invoice_item.unit_price, invoice_item.created_at, invoice_item.updated_at]
      CSV.open(file, 'ab', headers: true, header_converters: :symbol) do |csv|
        csv << invoice_item_attrs
      end
    end

    private

    def populate_list
      @invoice_items = data.collect do |row|
        SalesEngine::InvoiceItem.new(row, SalesEngine)
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
