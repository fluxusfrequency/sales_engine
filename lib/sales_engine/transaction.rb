class SalesEngine
  class Transaction

    attr_reader :id, :invoice_id, :credit_card_number, :credit_card_expiration_date, :result, :created_at, :updated_at

    def initialize(data={})
      @id = data[:id].to_i
      @invoice_id = data[:invoice_id].to_i
      @credit_card_number = data[:credit_card_number]
      @credit_card_expiration_date = data[:credit_card_expiration_date]
      @result = data[:result]
      @created_at = Date.parse(data[:created_at])
      @updated_at = Date.parse(data[:updated_at])
    end

    def invoice
      @invoice ||= Database.invoice_repository.find_by_id(invoice_id)
    end

    def customer
      invoice.customer
    end

  end
end