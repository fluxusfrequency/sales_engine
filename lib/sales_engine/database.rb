class SalesEngine
  class Database
    class << self

      attr_accessor :customer_repository, :invoice_repository, :invoice_item_repository, :item_repository, :merchant_repository, :transaction_repository

      def startup
        load_data('./data')
      end

      def startup_fixtures
        load_data('./test/fixtures')
      end

      def load_path_and_class(path, klass)
        "#{path}/#{klass}s.csv"
      end

      def load_data(path)
        @customer_repository = SalesEngine::CustomerRepository.new(load_path_and_class(path, "customer")
        @invoice_repository = SalesEngine::InvoiceRepository.new(load_path_and_class(path, "invoice")
        @invoice_item_repository = SalesEngine::InvoiceItemRepository.new(load_path_and_class(path, "invoice_item")
        @item_repository = SalesEngine::ItemRepository.new(load_path_and_class(path, "item")
        @merchant_repository = SalesEngine::MerchantRepository.new(load_path_and_class(path, "merchant")
        @transaction_repository =SalesEngine::TransactionRepository.new(load_path_and_class(path, "transaction")
      end

      def load(file)
        CSV.open(file, headers: true, header_converters: :symbol)
      end


    end
  end
end