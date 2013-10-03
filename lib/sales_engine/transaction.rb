require_relative '../sales_engine.rb'

class SalesEngine
  class Transaction

    attr_reader :id, :name, :created_at, :updated_at

    def initialize(data={})
      @id = data[:id].to_s
      @invoice_id = data[:invoice_id].to_s
      @credit_card_number = data[:credit_card_number].to_s
      @credit_card_expiration_date = data[:credit_card_expiration_date].to_s
      @result = data[:result].to_s
      @created_at = Date.parse(data[:created_at])
      @updated_at = Date.parse(data[:updated_at])
    end

  end
end