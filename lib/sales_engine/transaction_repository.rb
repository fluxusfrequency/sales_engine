require_relative 'loader'

class SalesEngine
  class TransactionRepository
    attr_reader :transactions

    def initialize(file)
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

    private

    def populate_list
      @transactions = @data.collect do |row|
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
