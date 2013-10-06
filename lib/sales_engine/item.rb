class SalesEngine
  class Item

    attr_reader :id, :name, :description, :unit_price, :merchant_id, :created_at, :updated_at

    def initialize(data={})
      @id = data[:id].to_i
      @name = data[:name]
      @description = data[:description]
      @unit_price = BigDecimal.new(data[:unit_price])/100
      @merchant_id = data[:merchant_id].to_i
      @created_at = Date.parse(data[:created_at])
      @updated_at = Date.parse(data[:updated_at])
    end

    def invoice_items
      @invoice_items ||= Database.invoice_item_repository.find_all_by_item_id(id)
    end

    def merchant
      @merchant ||= Database.merchant_repository.find_by_id(merchant_id)
    end

    def best_day
      top_total = invoice_item_quantity_sold_on_date.values.sort_by(&:to_s).first
      invoice_item_quantity_sold_on_date.key(top_total)
    end

    def revenue
      total_up(successful_invoice_items)
    end

    def successful_invoice_items
      invoice_items.compact.select(&:successful?)
    end

    def number_sold
      successful_invoice_items.collect(&:quantity).inject(0, :+)
    end

    private

    def invoice_item_quantity_sold_on_date
      successful_invoice_items.each_with_object(Hash.new(0)) do |invoice_item, date_counts|
        date = invoice_item.invoice.created_at.to_date
        date_counts[date] += invoice_item.total
      end
    end

    def total_up(invoice_items)
      sum = invoice_items.collect { |invoice_item| invoice_item.total }.inject(0,:+)
      BigDecimal.new(sum)/100
    end

  end
end