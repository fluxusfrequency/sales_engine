gem 'minitest'
require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/sales_engine/item.rb'
require_relative '../lib/sales_engine/item_repository.rb'

class ItemRepositoryTest < Minitest::Test

  attr_accessor :item_repository

  def setup
    @item_repository = ItemRepository.new()
  end

  def test_it_returns_an_item_repository_class
    assert_equal ItemRepository, item_repository.class
  end
end
