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

      def find_last_invoice_item
        invoice_item_repository.invoice_items.last
      end

      def find_last_invoice
        invoice_repository.invoices.last
      end

      def save_new_invoice_item_row(invoice_item)
        invoice_item_attrs = [invoice_item.id, invoice_item.item_id, invoice_item.invoice_id, invoice_item.quantity, invoice_item.unit_price, invoice_item.created_at, invoice_item.updated_at]
        file = CSV.open(load_stubs_for("invoice_item"), 'ab', headers: true, header_converters: :symbol) do |csv|
          csv << invoice_item_attrs
        end
      end

      def save_new_invoice_row(invoice)
        invoice_attrs = [invoice.id, invoice.customer_id, invoice.merchant_id, invoice.status, invoice.created_at, invoice.updated_at]
        CSV.open(load_stubs_for("invoice"), 'ab', headers: true, header_converters: :symbol) do |csv|
          csv << invoice_attrs
        end
      end

    end
  end
end
