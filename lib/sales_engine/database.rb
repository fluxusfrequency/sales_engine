class SalesEngine
  class Database

    attr_reader :customer_repository, :invoice_repository, :invoice_item_repository, :item_repository, :merchant_repository, :transaction_repository

    def self.setup
      @customer_repository = CustomerRepository.new(load_for("customers"))
      @invoice_repository = InvoiceRepository.new(load_for("invoices"))
      @invoice_item_repository = InvoiceItemRepository.new(load_for("invoice_items"))
      @item_repository = ItemRepository.new(load_for("items"))
      @merchant_repository = MerchantRepository.new(load_for("merchants"))
      @transaction_repository = TransactionRepository.new(load_for("transactions"))

      load_customers
      load_invoices
      load_invoice_items
      load_items
      load_merchants
      load_transactions
    end

    def self.load_for(klass)
      "./data/#{klass}.csv"
    end



    def self.load_customer_methods
      @customer_invoices = customer.invoices
      # @customer_transactions = customer_transactions
      # @customer_favorite_merchant = customer.favorite_merchant
    end

    def self.load_invoice_methods
      @invoice_transactions = invoice.transactions
      @invoice_invoice_items = invoice.invoice_items
      @invoice_idets_collection = invoice.items
      @invoice_customer = invoice.customer
      @invoice_merchant = invoice.merchant
      @invoice_successful_transactions = invoice.succesful_transactions
      @invoice_failed_transactions = invoice.failed_transactions
    end

    def self.load_invoice_items
      @invoice_item_invoices = invoice_item.invoices
      @invoice_item_items = invoice_item.items
    end

    def self.load_items
      @item_invoice_items = item.invoice_items
      @item_merchant = item.merchant
      @item_best_day = item.best_day
      @item_revenue_generated = item.revenue_generated
    end

    def self.load_merchants
      @merchant_items = merchant.items
      @merchant_invoices = merchant_invoices
      @merchant_revenue = merchant.revenue
      @merchant_favorite_customer = merchant.favorite_customer
      @merchant_customers_with_pending_invoices = merchant.customers_with_pending_invoices
      @merchant_revenue_without_date = merchant.revenue_without_date
      @merchant_revenue_with_date = merchant.revenue_with_date
      @merchant_find_pending_invoices = merchant.find_pending_invoices
    end

    def self.load_transactions
      @transaction_invoice = transaction.invoice
    end

  end
end
