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

    def find_by_invoice_id(id)
      grouped_by_invoice_id[id.to_s].first
    end

    def find_all_by_invoice_id(id)
      grouped_by_invoice_id[id.to_s]
    end

    def grouped_by_id
      @grouped_by_id ||= invoice_items.group_by {|invoice_item| invoice_item.id }
    end

    def grouped_by_invoice_id
      @grouped_by_invoice_id ||= invoice_items.group_by {|invoice_item| invoice_item.invoice_id }
    end

  end
end