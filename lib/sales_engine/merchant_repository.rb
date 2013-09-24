require_relative 'loader'
require_relative 'merchant'

class MerchantRepository
  attr_reader :merchants

  def initialize(file)
    @data = Loader.load(file)
    populate_list
  end

  def populate_list
    @merchants = @data.collect do |row|
      Merchant.new({
        :id => row[:id],
        :name => row[:name],
        :created_at => row[:created_at],
        :updated_at => row[:updated_at]
      })
    end
  end

  def all
    merchants
  end

  def random
    merchants.sample
  end

  private

  def self.generate_find_by_methods
    attrs = [:name, :id, :created_at, :updated_at]
    attrs.each do |attr|
      define_method("find_by_#{attr}") do |match|
        merchants.find { |merchant| merchant.send(attr).to_s == match.to_s }
      end
    end
    # attrs_with_int = [:id]
    # attrs_with_int.each do |attr|
    #   define_method("find_by_#{attr}") do |match|
    #     merchants.find { |merchant| merchant.send(attr).to_i == match }
    #   end
    # end
  end

  def self.generate_find_all_by_methods
    attrs = [:name, :id, :created_at, :updated_at]
    attrs.each do |attr|
      define_method("find_all_by_#{attr}") do |match|
        merchants.select { |merchant| merchant.send(attr).to_s == match.to_s }
      end
    end
    # attrs_with_int = [:id]
    # attrs_with_int.each do |attr|
    #   define_method("find_all_by_#{attr}") do |match|
    #     merchants.select { |merchant| merchant.send(attr).to_i == match }
    #   end
    # end
  end

  generate_find_by_methods
  generate_find_all_by_methods

end

#loads up the merchants from the csv
#each merchant in the repo responds to the merhcant class methods
