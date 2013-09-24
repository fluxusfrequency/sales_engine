require_relative 'loader'

class InvoiceRepository
  attr_reader :items

  def initialize(file)
    @data = Loader.load(file)
    populate_list
  end

  def populate_list
    @invoice = @data.collect do |row|
      Invoice.new({
        :id => row[:id],
        :customer_id => row[:customer_id],
        :merchant_id => row[:merchant_id],
        :status => row[:status],
        :created_at => row[:data],
        :updated_at => row[:updated_at]
      })
    end
  end

  def all
    invoice
  end

  def random
    invoice.sample
  end

end
