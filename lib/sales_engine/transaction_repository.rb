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

    def all
      transactions
    end

    def random
      transactions.sample
    end

    def find_by_id(id)
      grouped_by_id[id.to_s].first
    end

    def find_all_by_id(id)
      grouped_by_id[id.to_s]
    end

    def find_by_invoice_id(id)
      grouped_by_invoice_id[id.to_s].first
    end

    def find_all_by_invoice_id(id)
      grouped_by_invoice_id[id.to_s]
    end

    def find_by_credit_card_number(num)
      grouped_by_credit_card_number[num.to_s].first
    end

    def find_all_by_credit_card_number(num)
      grouped_by_credit_card_number[num.to_s]
    end

    def find_by_result(result)
      grouped_by_result[result.to_s].first
    end

    def find_all_by_result(result)
      grouped_by_result[result.to_s]
    end

    def find_by_created_at(date)
      grouped_by_created_at[date].first
    end

    def find_all_by_created_at(date)
      grouped_by_created_at[date]
    end

    def find_by_updated_at(date)
      grouped_by_updated_at[date].first
    end

    def find_all_by_updated_at(date)
      grouped_by_updated_at[date]
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