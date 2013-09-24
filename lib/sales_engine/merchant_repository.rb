require_relative 'loader'

class MerchantRepository
  attr_reader :list

  def initialize(file)
    @merchants = Loader.load(file)
    populate_list
  end

  def populate_list
    @list = @merchants.collect do |row|
      merchant = {
        :id => row[:id],
        :name => row[:name],
        :created_at => row[:created_at],
        :updated_at => row[:updated_at]
      }
    end
  end

  def all
  end

  def random
  end

  def find_by_X(match)
  end

  def find_all_by_X(match)
  end

end

#loads up the merchants from the csv
#each merchant in the repo responds to the merhcant class methods
