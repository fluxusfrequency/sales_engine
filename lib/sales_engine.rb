Dir["./lib/sales_engine/*.rb"].each do |file|
  require file
end

class SalesEngine
  def self.startup
    SalesEngine::Database.setup
  end

end

# Jeff's solution to DB problem: create a singleton class called Database
# class Database
#   def items
#     @items ||= ItemRepository.new
#   end
# end
#
# call it from the merchant instance:
# Database.items
#
#
# This is a global variable, which is bad because it will reference whichever DB was loaded last
# If you instantiate it, you have to pass it down the chain anyway
