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
