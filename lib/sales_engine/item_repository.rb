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

  end
end