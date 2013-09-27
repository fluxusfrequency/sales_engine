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

    def most_revenue(x)
    #   returns the top x item instances ranked by total revenue generated
      # true
      # [SalesEngine::Item.new({})]
      item_revenues = Hash.new(0)
      invoices.each do |invoice|
        invoice.items.each_with_object(item_revenues) do |item|
          item_revenues[item] += item.revenue_generated
        end
      end
      sorted_item_counts = item_revenues.sort_by{|item, revenue| revenue}
      sorted_item_counts[0..x.to_i]
    end

    # def most_items(x)
    #   returns the top x item instances ranked by total number sold
    # end

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
