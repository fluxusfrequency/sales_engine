require_relative 'loader'

class SalesEngine
  class InvoiceRepository
    attr_reader :invoices

    def initialize(file)
      @data = Loader.load(file)
      populate_list
    end

    def all
      invoices
    end

    def random
      invoices.sample
    end

    def create(params={})

      true
    end

    # Given a hash of inputs, you can create new invoices on the fly using this syntax:

    # invoice = invoice_repository.create(customer: customer, merchant: merchant, status: "shipped",
    #                          items: [item1, item2, item3])
    # Assuming that customer, merchant, and item1/item2/item3 are instances of their respective classes.

    # You should determine the quantity bought for each item by how many times the item is in the :items array. So, for items: [item1, item1, item2], the quantity bought will be 2 for item1 and 1 for item2.

    # Then, on such an invoice you can call:

    # invoice.charge(credit_card_number: "4444333322221111",
    #                credit_card_expiration: "10/13", result: "success")
    # The objects created through this process would then affect calculations, finds, etc.

    private

    def populate_list
      @invoices = @data.collect do |row|
        Invoice.new(row, SalesEngine)
      end
    end

    [:id, :customer_id, :merchant_id, :status, :created_at, :updated_at].each do |attr|
      define_method("find_by_#{attr}") do |match|
        match ||= ''
        invoices.find { |invoice| invoice.send(attr).to_s == match.to_s }
      end
    end

    [:id, :customer_id, :merchant_id, :status, :created_at, :updated_at].each do |attr|
      define_method("find_all_by_#{attr}") do |match|
        match ||= ''
        invoices.select { |invoice| invoice.send(attr).to_s == match.to_s }
      end
    end

  end
end
