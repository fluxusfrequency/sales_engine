class SalesEngine
  class Invoice

    attr_reader :id, :customer_id, :merchant_id, :status, :created_at, :updated_at

    def initialize(data={})
      @id = data[:id].to_i
      @customer_id = data[:customer_id].to_i
      @merchant_id = data[:merchant_id].to_i
      @status = data[:status]
      @created_at = Date.parse(data[:created_at])
      @updated_at = Date.parse(data[:updated_at])
    end

    def transactions
      @transactions ||= Database.transaction_repository.find_all_by_invoice_id(id)
    end

    def invoice_items
      @invoice_items ||= Database.invoice_item_repository.find_all_by_invoice_id(id)
    end

    def items
      @items ||= invoice_items.collect do |invoice_item|
        Database.item_repository.find_by_id(invoice_item.item_id)
      end
    end

    def customer
      @customer ||= Database.customer_repository.find_by_id(customer_id)
    end

    def merchant
      @merchant ||= Database.merchant_repository.find_by_id(merchant_id)
    end

    def charge(data={})
      Database.invoice_repository.create(params_for_invoice)
      Database.transaction_repository.create(params_for_transaction(data))
      @transactions = Database.transaction_repository.find_all_by_invoice_id(id)
    end

    def successful?
      if transactions
        transactions.any? { |transaction| transaction.result == "success" }
      end
    end

    def total
      invoice_items.map(&:total).inject(0,:+)
    end

    private

    def params_for_invoice
      {:id => Database.invoice_repository.find_last_invoice_id + 1,
      :customer => customer,
      :merchant => merchant,
      :status => status,
      :created_at => created_at,
      :updated_at => updated_at }
    end

    def params_for_transaction(data)
      { :id => Database.transaction_repository.find_last_transaction_id + 1,
        :invoice_id => id,
        :credit_card_number => data[:credit_card_number].to_s,
        :credit_card_expiration_date => nil,
        :result => data[:result] || 'unknown',
        :created_at => created_at.to_s,
        :updated_at => updated_at.to_s }
    end

  end
end