require_relative '../sales_engine.rb'

class SalesEngine
  class InvoiceRepository
    attr_reader :invoices, :file, :data

    def initialize(file)
      @file = file
      @data = SalesEngine::Database.load(file)
      populate_list
    end

    def all
      invoices
    end

    def random
      invoices.sample
    end

    def create(params={})
      new_invoice = SalesEngine::Invoice.new(data_hash_for_new_invoice(params), SalesEngine)
      SalesEngine::Database.invoice_repository.save_new_invoice_row(new_invoice)
      SalesEngine::Database.reload_invoice_repository(file)

      if params[:items]
        item_counts = generate_item_counts(params[:items])
        SalesEngine::Database.invoice_item_repository.create(item_counts, new_invoice.id)
      end
    end

    def data_hash_for_new_invoice(params)
      { :id => SalesEngine::Database.find_last_invoice.id.to_i+1,
        :customer_id => params[:customer].id,
        :merchant_id => params[:merchant].id,
        :status => params[:status] || 'pending',
        :created_at => Time.now,
        :updated_at => Time.now
        }
    end

    def save_new_invoice_row(invoice)
      invoice_attrs = [ invoice.id,
                        invoice.customer_id,
                        invoice.merchant_id,
                        invoice.status,
                        invoice.created_at,
                        invoice.updated_at]
      SalesEngine::Database.save(file, invoice_attrs)
    end


    [:customer_id, :merchant_id, :status, :created_at, :updated_at].each do |attr|
      define_method("find_by_#{attr}") do |match|
        match ||= ''
        invoices.find { |invoice| invoice.send(attr).to_s == match.to_s }
      end
    end

    [:id, :status, :created_at, :updated_at].each do |attr|
      define_method("find_all_by_#{attr}") do |match|
        match ||= ''
        invoices.select { |invoice| invoice.send(attr).to_s == match.to_s }
      end
    end

    def find_by_id(id)
      Array(invoices_grouped_by_id[id]).first
    end

    def invoices_grouped_by_id
      @invoices_grouped_by_id ||= all.group_by { |invoice| invoice.id.to_i }
    end

    def find_all_by_merchant_id(merchant_id)
      invoices_grouped_by_merchant_id[merchant_id.to_i] || []
    end

    def invoices_grouped_by_merchant_id
      @invoices_grouped_by_merchant_id ||= all.group_by { |invoice| invoice.merchant_id.to_i }
    end

    def find_all_by_customer_id(customer_id)
      invoices_grouped_by_customer_id[customer_id.to_i] || []
    end

    def invoices_grouped_by_customer_id
      @invoices_grouped_by_customer_id ||= all.group_by { |invoice| invoice.customer_id.to_i }
    end

    private

    def populate_list
      @invoices = data.collect do |row|
        Invoice.new(row, SalesEngine)
      end
    end

    def generate_item_counts(items)
      item_counts = Hash.new(0)
      items.each_with_object(item_counts) do |item|
        item_counts[item] += 1
      end
      item_counts
    end


  end
end
