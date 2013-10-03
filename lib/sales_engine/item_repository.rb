class SalesEngine
  class ItemRepository

    attr_reader :file, :items

    def initialize(file)
      @file = file
      populate_list
    end

    def populate_list
      data = Database.load(file)
      @items = data.collect do |row|
        Item.new(row)
      end
    end

    def all
      items
    end

    def random
      items.sample
    end

    def most_items(x)
      # returns_n_items_ranked_by_most_sold
      sorted_totals = items_grouped_by_number_sold.keys.sort.reverse

      most_items = sorted_totals.collect do |total|
        items_grouped_by_number_sold[total]
      end

      most_items.flatten[0,x]
    end

    def items_grouped_by_number_sold
      items.group_by {|item| item.number_sold}
    end

    def find_by_id(id)
      grouped_by_id[id].first
    end

    def find_all_by_id(id)
      grouped_by_id[id] || []
    end

    def find_by_name(name)
      grouped_by_name[name].first
    end

    def find_all_by_name(name)
      grouped_by_name[name] || []
    end

    def find_by_description(description)
      grouped_by_description[description].first
    end

    def find_all_by_description(description)
      grouped_by_description[description] || []
    end

    def find_by_unit_price(price)
      grouped_by_unit_price[price].first
    end

    def find_all_by_unit_price(price)
      grouped_by_unit_price[price] || []
    end

    def find_by_merchant_id(id)
      grouped_by_merchant_id[id].first
    end

    def find_all_by_merchant_id(id)
      grouped_by_merchant_id[id] || []
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
      @grouped_by_id ||= items.group_by {|item| item.id }
    end

    def grouped_by_name
      @grouped_by_name ||= items.group_by {|item| item.name }
    end

    def grouped_by_description
      @grouped_by_description ||= items.group_by {|item| item.description }
    end

    def grouped_by_unit_price
      @grouped_by_unit_price ||= items.group_by {|item| item.unit_price }
    end

    def grouped_by_merchant_id
      @grouped_by_merchant_id ||= items.group_by {|item| item.merchant_id }
    end

    def grouped_by_created_at
      @grouped_by_created_at ||= items.group_by {|item| item.created_at }
    end

    def grouped_by_updated_at
      @grouped_by_updated_at ||= items.group_by {|item| item.updated_at }
    end

  end
end