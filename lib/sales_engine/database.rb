require_relative '../sales_engine.rb'

class SalesEngine
  class Database
    class << self
      attr_accessor :customer_repository, :invoice_repository, :invoice_item_repository, :item_repository, :merchant_repository, :transaction_repository

      def setup
        load_data('./data')
      end

      def setup_stubs
        load_data('./test/fixtures')
      end

      def load(file)
        CSV.open(file, headers: true, header_converters: :symbol)
      end

      def load_data(dir)
        @customer_repository = SalesEngine::CustomerRepository.new(load_path_for(dir, "customer"))
        @invoice_repository = SalesEngine::InvoiceRepository.new(load_path_for(dir, "invoice"))
        @invoice_item_repository = SalesEngine::InvoiceItemRepository.new(load_path_for(dir, "invoice_item"))
        @item_repository = SalesEngine::ItemRepository.new(load_path_for(dir, "item"))
        @merchant_repository = SalesEngine::MerchantRepository.new(load_path_for(dir, "merchant"))
        @transaction_repository = SalesEngine::TransactionRepository.new(load_path_for(dir, "transaction"))
      end

      def load_path_for(dir, klass)
        "#{dir}/#{klass}s.csv"
      end

      def reload_invoice_repository(file)
        @invoice_repository = SalesEngine::InvoiceRepository.new(file)
      end

      def reload_invoice_item_repository(file)
        @invoice_item_repository = SalesEngine::InvoiceItemRepository.new(file)
      end

      def reload_transaction_repository(file)
        @transaction_repository = SalesEngine::TransactionRepository.new(file)
      end

      def save(file, row)
        CSV.open(file, 'ab', headers: true, header_converters: :symbol) do |csv|
          csv << row
        end
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

    end
  end
end
