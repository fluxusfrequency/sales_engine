require_relative '../sales_engine.rb'

class SalesEngine
  class Database

    class << self
      attr_reader :customer_repository, :invoice_repository, :invoice_item_repository, :item_repository, :merchant_repository, :transaction_repository

      def setup
        load_data('./data')
      end

      def setup_stubs
        load_data('./test/fixtures')
      end

      def load_data(dir)
        @customer_repository = SalesEngine::CustomerRepository.new(load_for(dir, "customer"))
        @invoice_repository = SalesEngine::InvoiceRepository.new(load_for(dir, "invoice"))
        @invoice_item_repository = SalesEngine::InvoiceItemRepository.new(load_for(dir, "invoice_item"))
        @item_repository = SalesEngine::ItemRepository.new(load_for(dir, "item"))
        @merchant_repository = SalesEngine::MerchantRepository.new(load_for(dir, "merchant"))
        @transaction_repository = SalesEngine::TransactionRepository.new(load_for(dir, "transaction"))
      end

      def load_for(dir, klass)
        "#{dir}/#{klass}s.csv"
      end

      def find_last_invoice_item
        invoice_item_repository.invoice_items.last
      end

      def find_last_invoice
        invoice_repository.invoices.last
      end

      def find_last_transaction
        transaction_repository.transactions.last
      end

      def save_new_invoice_item_row(invoice_item)
        invoice_item_repository.save_new_invoice_item_row(invoice_item)
      end

      def save_new_invoice_row(invoice)
        invoice_repository.save_new_invoice_row(invoice)
      end

      def save_new_transaction_row(transaction)
        transaction_repository.save_new_transaction_row(transaction)
      end

    end
  end
end
