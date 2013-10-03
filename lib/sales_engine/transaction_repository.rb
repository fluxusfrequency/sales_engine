require_relative '../sales_engine.rb'

class SalesEngine
  class TransactionRepository
    attr_reader :transactions, :file, :data

    def initialize(file)
      @file = file
      @data = SalesEngine::Database.load(file)
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
        :credit_card_expiration_date => '',
        :result => params[:result],
        :created_at => params[:created_at],
        :updated_at => params[:updated_at]
        }

      new_transaction = SalesEngine::Transaction.new(data, SalesEngine)
      SalesEngine::Database.transaction_repository.save_new_transaction_row(new_transaction)
      SalesEngine::Database.reload_transaction_repository(file)
    end

    def save_new_transaction_row(transaction)
      transaction_attrs = [ transaction.id,
                            transaction.invoice_id,
                            transaction.credit_card_number,
                            transaction.credit_card_expiration_date,
                            transaction.result,
                            transaction.created_at,
                            transaction.updated_at]
      SalesEngine::Database.save(file, transaction_attrs)
    end

    [:invoice_id, :credit_card_number, :result, :created_at, :updated_at].each do |attr|
      define_method("find_by_#{attr}") do |match|
        match ||= ''
        transactions.find { |transaction| transaction.send(attr).to_s == match.to_s }
      end
    end

    [:id, :credit_card_number, :created_at, :updated_at].each do |attr|
      define_method("find_all_by_#{attr}") do |match|
        match ||= ''
        transactions.select { |transaction| transaction.send(attr).to_s == match.to_s }
      end
    end

    def find_by_id(id)
      Array(transactions_grouped_by_id[id]).first
    end

    def transactions_grouped_by_id
      @transactions_grouped_by_id ||= all.group_by { |transaction| transaction.id }
    end

    def find_all_by_invoice_id(invoice_id)
      transactions_grouped_by_invoice_id[invoice_id.to_i]
    end

    def transactions_grouped_by_invoice_id
      @transactions_grouped_by_invoice_id ||= all.group_by { |transactions| transactions.invoice_id.to_i }
    end

    def find_all_by_result(result)
      transactions_grouped_by_result[result]
    end

    def transactions_grouped_by_result
      @transactions_grouped_by_result ||= all.group_by { |transactions| transactions.result }
    end

    private

    def populate_list
      @transactions = data.collect do |row|
        Transaction.new(row, SalesEngine)
      end
    end

  end
end
