class SalesEngine
  class InvoiceRepository

    attr_reader :file, :invoices

    def initialize(file)
      @file = file
      populate_list
    end

    def populate_list
      data = Database.load(file)
      @invoices = data.collect do |row|
        Invoice.new(row)
      end
    end

    def all
      invoices
    end

  end
end