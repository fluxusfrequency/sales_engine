class SalesEngine
  class TransactionRepository

    attr_reader :file, :transactions

    def initialize(file)
      @file = file
      populate_list
    end

    def populate_list
      data = Database.load(file)
      @transactions = data.collect do |row|
        Transaction.new(row)
      end
    end

    def create(params={})
      new_transaction = Transaction.new(params)
      Database.save(file, attrs_array(new_transaction))

      #reload the repository
      Database.transaction_repository = TransactionRepository.new(file)
    end

    def find_last_transaction_id
      transactions.last.id
    end

    def all
      transactions
    end

    def random
      transactions.sample
    end

    def find_by_id(id)
      result = grouped_by_id[id] || return
      result.first
    end

    def find_all_by_id(id)
      grouped_by_id[id] || []
    end

    def find_by_invoice_id(id)
      grouped_by_invoice_id[id].first
    end

    def find_all_by_invoice_id(id)
      grouped_by_invoice_id[id] || []
    end

    def find_by_credit_card_number(num)
      grouped_by_credit_card_number[num].first
    end

    def find_all_by_credit_card_number(num)
      grouped_by_credit_card_number[num] || []
    end

    def find_by_result(result)
      grouped_by_result[result.to_s].first
    end

    def find_all_by_result(result)
      grouped_by_result[result.to_s] || []
    end

    def find_by_created_at(date)
      grouped_by_created_at[date].first
    end

    def find_all_by_created_at(date)
      grouped_by_created_at[date] || []
    end

    def find_by_updated_at(date)
      grouped_by_updated_at[date].first
    end

    def find_all_by_updated_at(date)
      grouped_by_updated_at[date] || []
    end

    private

    def attrs_array(transaction)
      [ transaction.id,
        transaction.invoice_id,
        transaction.credit_card_number,
        transaction.credit_card_expiration_date,
        transaction.result,
        transaction.created_at,
        transaction.updated_at ]
    end

    def grouped_by_id
      @grouped_by_id ||= transactions.group_by {|invoice_item| invoice_item.id }
    end

    def grouped_by_invoice_id
      @grouped_by_invoice_id ||= transactions.group_by {|invoice_item| invoice_item.invoice_id }
    end

    def grouped_by_credit_card_number
      @grouped_by_credit_card_number ||= transactions.group_by {|invoice_item| invoice_item.credit_card_number }
    end

    def grouped_by_result
      @grouped_by_result ||= transactions.group_by {|invoice_item| invoice_item.result }
    end

    def grouped_by_created_at
      @grouped_by_created_at ||= transactions.group_by {|invoice_item| invoice_item.created_at }
    end

    def grouped_by_updated_at
      @grouped_by_updated_at ||= transactions.group_by {|invoice_item| invoice_item.updated_at }
    end

  end
end