class SalesEngine
  class Database
    class << self

      attr_accessor :customer_repository, :invoice_repository, :invoice_item_repository, :item_repository, :merchant_repository, :transaction_repository

      def startup(path)

      end

      def load_path_and_class(path, klass)
        "#{path}/#{klass}s.csv"
      end

      def load_data(path)
        @customer_repository = SalesEngine::CustomerRepository.new(load_path_and_class(path, klass)
        @invoice_repository = SalesEngine::InvoiceRepository.new
        @invoice_item_repository = SalesEngine::InvoiceItemRepository.new
        @item_repository = SalesEngine::ItemRepository.new
        @merchant_repository = SalesEngine::MerchantRepository.new
        @transaction_repository =SalesEngine::TransactionRepository.new
      end

      def load(file)
        CSV.open(file, headers: true, header_converters: :symbol)
      end

      def reload(klass)

      end


    end
  end
end