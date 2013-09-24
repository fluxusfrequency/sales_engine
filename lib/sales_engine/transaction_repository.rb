class TransactionRepository
  attr_reader :list

  def initialize(file)
    @items = Loader.load(file)
    populate_list
  end

  def populate_list
    @list = @items.collect do |row|
      transaction = {
        :id => row[:id],
        :invoice_id => row[:invoice_id],
        :credit_card_number => row[:credit_card_number],
        :credit_card_expiration_date => row[:credit_card_expiration_date],
        :result => row[:result],
        :merchant_id => row[:merchant_id],
        :created_at => row[:created_at],
        :updated_at => row[:updated_at]
      }
    end
  end

  def all
  end

  def random
  end

  def find_by_X(match)
  end

  def find_all_by_X(match)
  end
end
