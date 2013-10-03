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

    def random
      invoices.sample
    end

    def find_by_id(id)
      grouped_by_id[id].first
    end

    def find_all_by_id(id)
      grouped_by_id[id] || []
    end

    def find_by_customer_id(id)
      grouped_by_customer_id[id].first
    end

    def find_all_by_customer_id(id)
      grouped_by_customer_id[id] || []
    end

    def find_by_merchant_id(id)
      grouped_by_merchant_id[id].first
    end

    def find_all_by_merchant_id(id)
      grouped_by_merchant_id[id] || []
    end

    def find_by_status(status)
      return nil if grouped_by_status[status.to_s].nil?
      grouped_by_status[status.to_s].first
    end

    def find_all_by_status(status)
      grouped_by_status[status.to_s] || []
    end

    def find_by_created_at(date)
      grouped_by_created_at[date].first
    end

    def find_all_by_created_at(date)
      grouped_by_created_at[date] || []
    end

    def find_by_updated_at(date)
      grouped_by_updated_at[date].first
    end

    def find_all_by_updated_at(date)
      grouped_by_updated_at[date] || []
    end

    def grouped_by_id
      @grouped_by_id ||= invoices.group_by {|invoice| invoice.id }
    end

    def grouped_by_customer_id
      @grouped_by_customer_id ||= invoices.group_by {|invoice| invoice.customer_id }
    end

    def grouped_by_merchant_id
      @grouped_by_merchant_id ||= invoices.group_by {|invoice| invoice.merchant_id }
    end

    def grouped_by_status
      @grouped_by_status ||= invoices.group_by {|invoice| invoice.status.to_s }
    end

    def grouped_by_created_at
      @grouped_by_created_at ||= invoices.group_by {|invoice| invoice.created_at }
    end

    def grouped_by_updated_at
      @grouped_by_updated_at ||= invoices.group_by {|invoice| invoice.updated_at }
    end

  end
end