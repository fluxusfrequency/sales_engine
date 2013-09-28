require_relative '../sales_engine.rb'

class SalesEngine
  class Database
    class << self
      attr_reader :customer_repository, :invoice_repository, :invoice_item_repository, :item_repository, :merchant_repository, :transaction_repository

      def setup
        @customer_repository = SalesEngine::CustomerRepository.new(load_for("customer"))
        @invoice_repository = SalesEngine::InvoiceRepository.new(load_for("invoice"))
        @invoice_item_repository = SalesEngine::InvoiceItemRepository.new(load_for("invoice_item"))
        @item_repository = SalesEngine::ItemRepository.new(load_for("item"))
        @merchant_repository = SalesEngine::MerchantRepository.new(load_for("merchant"))
        @transaction_repository = SalesEngine::TransactionRepository.new(load_for("transaction"))
      end

      def setup_stubs
        @customer_repository = SalesEngine::CustomerRepository.new(load_stubs_for("customer"))
        @invoice_repository = SalesEngine::InvoiceRepository.new(load_stubs_for("invoice"))
        @invoice_item_repository = SalesEngine::InvoiceItemRepository.new(load_stubs_for("invoice_item"))
        @item_repository = SalesEngine::ItemRepository.new(load_stubs_for("item"))
        @merchant_repository = SalesEngine::MerchantRepository.new(load_stubs_for("merchant"))
        @transaction_repository = SalesEngine::TransactionRepository.new(load_stubs_for("transaction"))
      end

      def load_for(klass)
        "./data/#{klass}s.csv"
      end

      def load_stubs_for(klass)
        "./test/fixtures/#{klass}_repository_fixture.csv"
      end

      def load_customer_methods
        @customer_invoices = customer.invoices
        # @customer_transactions = customer_transactions
        # @customer_favorite_merchant = customer.favorite_merchant
      end

      def load_invoice_methods
        @invoice_transactions = invoice.transactions
        @invoice_invoice_items = invoice.invoice_items
        @invoice_idets_collection = invoice.items
        @invoice_customer = invoice.customer
        @invoice_merchant = invoice.merchant
        @invoice_successful_transactions = invoice.succesful_transactions
        @invoice_failed_transactions = invoice.failed_transactions
      end

      def load_invoice_items
        @invoice_item_invoices = invoice_item.invoices
        @invoice_item_items = invoice_item.items
      end

      def load_items
        @item_invoice_items = item.invoice_items
        @item_merchant = item.merchant
        @item_best_day = item.best_day
        @item_revenue_generated = item.revenue_generated
      end

      def load_merchants
        @merchant_items = merchant.items
        @merchant_invoices = merchant_invoices
        @merchant_revenue = merchant.revenue
        @merchant_favorite_customer = merchant.favorite_customer
        @merchant_customers_with_pending_invoices = merchant.customers_with_pending_invoices
        @merchant_revenue_without_date = merchant.revenue_without_date
        @merchant_revenue_with_date = merchant.revenue_with_date
        @merchant_find_pending_invoices = merchant.find_pending_invoices
      end

      def load_transactions
        @transaction_invoice = transaction.invoice
      end

    end
  end
end
