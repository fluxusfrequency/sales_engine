require_relative 'loader'

class SalesEngine
  class InvoiceItemRepository
    attr_reader :invoice_items

    def initialize(file)
      @data = Loader.load(file)
      populate_list
    end

    def populate_list
      @invoice_items = @data.collect do |row|
        InvoiceItem.new({
          :id => row[:id],
          :item_id => row[:item_id],
          :invoice_id => row[:invoice_id],
          :quantity => row[:quantity],
          :unit_price => row[:unit_price],
          :created_at => row[:created_at],
          :updated_at => row[:updated_at]
        })
      end
    end

    def all
      invoice_items
    end

    def random
      invoice_items.sample
    end

    private

    def self.generate_find_by_methods
      attrs = [:id, :item_id, :invoice_id, :quantity, :unit_price, :created_at, :updated_at]
      attrs.each do |attr|
        define_method("find_by_#{attr}") do |match|
          match ||= ''
          invoice_items.find { |invoice_item| invoice_item.send(attr).to_s == match.to_s }
        end
      end
      # attrs_with_int = []
      # attrs_with_int.each do |attr|
      #   define_method("find_by_#{attr}") do |match|
      #     match ||= ''
      #     invoice_items.find { |invoice_item| invoice_item.send(attr).to_s == match.to_s }
      #   end
      # end
    end

    def self.generate_find_all_by_methods
      attrs = [:id, :item_id, :invoice_id, :quantity, :unit_price, :created_at, :updated_at]
      attrs.each do |attr|
        define_method("find_all_by_#{attr}") do |match|
          match ||= ''
          invoice_items.select { |invoice_item| invoice_item.send(attr).to_s == match.to_s }
        end
      end
      # attrs_with_int = []
      # attrs_with_int.each do |attr|
      #   define_method("find_all_by_#{attr}") do |match|
      #     match ||= ''
      #     invoice_items.select { |invoice_item| invoice_item.send(attr).to_s == match.to_s }
      #   end
      # end
    end

    generate_find_by_methods
    generate_find_all_by_methods

  end
end
