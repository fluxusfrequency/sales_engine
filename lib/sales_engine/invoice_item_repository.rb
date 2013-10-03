class SalesEngine
  class InvoiceItemRepository

    attr_reader :file, :invoice_items

    def initialize(file)
      @file = file
      populate_list
    end

    def populate_list
      data = Database.load(file)
      @invoice_items = data.collect do |row|
        InvoiceItem.new(row)
      end
    end

    def all
      invoice_items
    end

    def random
      invoice_items.sample
    end

    def create_new_invoice_items(items, invoice)
      item_counts(items)
      @count_hash.keys.each do |i|
        new_id = find_last_invoice_item_id + 1
        new_invoice_item = InvoiceItem.new(hash_for_new_invoice_item(i, new_id, invoice, @count_hash[i]))
        Database.save(file, attrs_array(new_invoice_item))
      end

      #reload the repository
      Database.invoice_item_repository = InvoiceItemRepository.new(file)
    end

     def item_counts(items)
      @count_hash ||= Hash.new(0)
      items.each do |item|
        @count_hash[item] += 1
      end
      @count_hash
    end

    def hash_for_new_invoice_item(item, id, invoice, quantity)
      { :id => id,
        :item_id => item.id,
        :invoice_id => invoice.id,
        :quantity => quantity,
        :unit_price => item.unit_price,
        :created_at => invoice.created_at.to_s,
        :updated_at => invoice.created_at.to_s }
    end

    def find_last_invoice_item_id
      invoice_items.last.id
    end

    def attrs_array(invoice_item)
      [ invoice_item.id,
        invoice_item.item_id,
        invoice_item.invoice_id,
        invoice_item.quantity,
        invoice_item.unit_price,
        invoice_item.created_at,
        invoice_item.updated_at ]
    end

    def find_by_id(id)
      grouped_by_id[id].first
    end

    def find_all_by_id(id)
      grouped_by_id[id] || []
    end

    def find_by_item_id(id)
      grouped_by_item_id[id].first
    end

    def find_all_by_item_id(id)
      grouped_by_item_id[id] || []
    end

    def find_by_invoice_id(id)
      grouped_by_invoice_id[id].first
    end

    def find_all_by_invoice_id(id)
      grouped_by_invoice_id[id] || []
    end

    def find_by_quantity(qty)
      grouped_by_quantity[qty].first
    end

    def find_all_by_quantity(qty)
      grouped_by_quantity[qty] || []
    end

    def find_by_unit_price(price)
      grouped_by_unit_price[price].first
    end

    def find_all_by_unit_price(price)
      grouped_by_unit_price[price] || []
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

    def grouped_by_id
      @grouped_by_id ||= invoice_items.group_by {|invoice_item| invoice_item.id }
    end

    def grouped_by_item_id
      @grouped_by_item_id ||= invoice_items.group_by {|invoice_item| invoice_item.item_id }
    end

    def grouped_by_invoice_id
      @grouped_by_invoice_id ||= invoice_items.group_by {|invoice_item| invoice_item.invoice_id }
    end

    def grouped_by_quantity
      @grouped_by_quantity ||= invoice_items.group_by {|invoice_item| invoice_item.quantity }
    end

    def grouped_by_unit_price
      @grouped_by_unit_price ||= invoice_items.group_by {|invoice_item| invoice_item.unit_price }
    end

    def grouped_by_created_at
      @grouped_by_created_at ||= invoice_items.group_by {|invoice_item| invoice_item.created_at }
    end

    def grouped_by_updated_at
      @grouped_by_updated_at ||= invoice_items.group_by {|invoice_item| invoice_item.updated_at }
    end

  end
end