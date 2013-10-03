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

  end
end