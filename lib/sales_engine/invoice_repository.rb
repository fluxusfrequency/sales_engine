require_relative 'loader'

class InvoiceRepository
  attr_reader :invoices

  def initialize(file)
    @data = Loader.load(file)
    populate_list
  end

  def populate_list
    @invoices = @data.collect do |row|
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
    invoices
  end

  def random
    invoices.sample
  end

  private

  def self.generate_find_by_methods
    attrs = [:id, :invoice_id, :credit_card_number, :result, :created_at, :updated_at]
    attrs.each do |attr|
      define_method("find_by_#{attr}") do |match|
        match ||= ''
        invoices.find { |invoice| invoice.send(attr).to_s == match.to_s }
      end
    end
    # attrs_with_int = []
    # attrs_with_int.each do |attr|
    #   define_method("find_by_#{attr}") do |match|
    #     match ||= ''
    #     invoices.find { |invoice| invoice.send(attr).to_s == match.to_s }
    #   end
    # end
  end

  def self.generate_find_all_by_methods
    attrs = [:id, :invoice_id, :credit_card_number, :result, :created_at, :updated_at]
    attrs.each do |attr|
      define_method("find_all_by_#{attr}") do |match|
        match ||= ''
        invoices.select { |invoice| invoice.send(attr).to_s == match.to_s }
      end
    end
    # attrs_with_int = []
    # attrs_with_int.each do |attr|
    #   define_method("find_all_by_#{attr}") do |match|
    #     match ||= ''
    #     invoices.select { |invoice| invoice.send(attr).to_s == match.to_s }
    #   end
    # end
  end

  generate_find_by_methods
  generate_find_all_by_methods


end
