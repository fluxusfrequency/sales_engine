require_relative '../sales_engine.rb'

class SalesEngine
  class TransactionRepository
    attr_reader :transactions, :file, :data

    def initialize(file)
      @file = file
      @data = Loader.load(file)
      populate_list
    end

    def all
      transactions
    end

    def random
      transactions.sample
    end

    def create(params={})
      data = {
        :id => SalesEngine::Database.find_last_transaction.id.to_i+1,
        :invoice_id => params[:invoice_id],
        :credit_card_number => params[:credit_card_number],
        :credit_card_expiration_date => nil,
        :result => params[:result],
        :created_at => params[:created_at],
        :updated_at => params[:updated_at]
        }

      new_transaction = SalesEngine::Transaction.new(data, SalesEngine)
      SalesEngine::Database.save_new_transaction_row(new_transaction)

    end

    def save_new_transaction_row(transaction)
      transaction_attrs = [transaction.id, transaction.invoice_id, transaction.credit_card_number, transaction.credit_card_expiration_date, transaction.result, transaction.created_at, transaction.updated_at]
      CSV.open(file, 'ab', headers: true, header_converters: :symbol) do |csv|
        csv << transaction_attrs
      end
    end

    private

    def populate_list
      @transactions = data.collect do |row|
        Transaction.new(row, SalesEngine)
      end
    end

    [:id, :invoice_id, :credit_card_number, :result, :created_at, :updated_at].each do |attr|
      define_method("find_by_#{attr}") do |match|
        match ||= ''
        transactions.find { |transaction| transaction.send(attr).to_s == match.to_s }
      end
    end

    [:id, :invoice_id, :credit_card_number, :result, :created_at, :updated_at].each do |attr|
        define_method("find_all_by_#{attr}") do |match|
          match ||= ''
          transactions.select { |transaction| transaction.send(attr).to_s == match.to_s }
        end
      end

  end
end
