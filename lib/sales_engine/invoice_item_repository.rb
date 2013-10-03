class SalesEngine
  class InvoiceItemRepository

    attr_reader :file, :invoice_items

    def initialize(file)
      @file = file
      populate_list
    end

    def populate_list
      data = Database.load(file)
      @invoice_items = data.collect do |row|
        InvoiceItem.new(row)
      end
    end

    def all
      invoice_items
    end

    def random
      invoice_items.sample
    end

    def find_by_id(id)
      grouped_by_id[id.to_s].first
    end

    def find_all_by_item_id(id)
      grouped_by_item_id[id.to_s]
    end

    def find_by_item_id(id)
      grouped_by_item_id[id.to_s].first
    end

    def find_all_by_id(id)
      grouped_by_id[id.to_s]
    end

    def find_by_invoice_id(id)
      grouped_by_invoice_id[id.to_s].first
    end

    def find_all_by_invoice_id(id)
      grouped_by_invoice_id[id.to_s]
    end

    def find_by_quantity(id)
      grouped_by_quantity[id.to_s].first
    end

    def find_all_by_quantity(id)
      grouped_by_quantity[id.to_s]
    end

    def find_by_unit_price(id)
      grouped_by_unit_price[id.to_s].first
    end

    def find_all_by_unit_price(id)
      grouped_by_unit_price[id.to_s]
    end

    def grouped_by_id
      @grouped_by_id ||= invoice_items.group_by {|invoice_item| invoice_item.id }
    end

    def grouped_by_item_id
      @grouped_by_item_id ||= invoice_items.group_by {|invoice_item| invoice_item.item_id }
    end

    def grouped_by_invoice_id
      @grouped_by_invoice_id ||= invoice_items.group_by {|invoice_item| invoice_item.invoice_id }
    end

    def grouped_by_quantity
      @grouped_by_quantity ||= invoice_items.group_by {|invoice_item| invoice_item.quantity }
    end

    def grouped_by_unit_price
      @grouped_by_unit_price ||= invoice_items.group_by {|invoice_item| invoice_item.unit_price }
    end

  end
end