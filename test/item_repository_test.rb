gem 'minitest'
require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/sales_engine.rb'

class ItemRepositoryTest < Minitest::Test

  attr_accessor :item_repository, :database

  def setup
    @database = SalesEngine::Database
    database.setup_stubs
    @item_repository = database.item_repository
  end

  def test_it_has_an_attr_called_items
    assert item_repository.items
  end

  def test_the_items_array_contains_Item_objects
    assert_equal SalesEngine::Item, item_repository.items[0].class
  end

  def test_the_all_method_returns_loaded_items
    assert item_repository.all.length > 1
    assert_equal SalesEngine::Item, item_repository.all[0].class
    assert_equal SalesEngine::Item, item_repository.all[-1].class
  end

  def test_the_random_method_returns_a_random_item_from_the_loaded_items
    assert_equal SalesEngine::Item, item_repository.random.class
    random_searches = []
    10.times do
      random_searches << item_repository.random
    end
    random_searches.reject {|s| s == item_repository.items[0]}
    assert random_searches.length > 2
  end

  def test_it_returns_an_item_repository_class
    assert_equal SalesEngine::ItemRepository, item_repository.class
  end

  def test_find_by_id_returns_an_item_with_the_correct_id
    assert_equal item_repository.items[0], item_repository.find_by_id(1)
  end

  def test_find_all_by_id_returns_an_item_with_the_correct_id
    assert_equal 2, item_repository.find_all_by_id(2).first.id.to_i
  end

  def test_find_by_name_returns_an_item_with_the_correct_name
    assert_equal item_repository.items[0], item_repository.find_by_name("Item Qui Esse")
  end

  def test_find_all_by_name_returns_an_item_with_the_correct_name
    assert_equal "Item Qui Esse", item_repository.find_all_by_name("Item Qui Esse").first.name
  end

  def test_find_by_description_returns_an_item_with_the_correct_description
    assert_equal item_repository.items[0], item_repository.find_by_description("Nihil autem sit odio inventore deleniti. Est laudantium ratione distinctio laborum. Minus voluptatem nesciunt assumenda dicta voluptatum porro.")
  end

  def test_find_all_by_description_returns_an_item_with_the_correct_description
    assert_equal "Nihil autem sit odio inventore deleniti. Est laudantium ratione distinctio laborum. Minus voluptatem nesciunt assumenda dicta voluptatum porro.", item_repository.find_all_by_description("Nihil autem sit odio inventore deleniti. Est laudantium ratione distinctio laborum. Minus voluptatem nesciunt assumenda dicta voluptatum porro.").first.description
  end

  def test_find_by_unit_price_returns_an_item_with_the_correct_unit_price
    assert_equal item_repository.items[0], item_repository.find_by_unit_price(75107)
  end

  def test_find_all_by_unit_price_returns_an_item_with_the_correct_unit_price
    assert_equal 75107, item_repository.find_all_by_unit_price(75107).first.unit_price.to_i
  end

  def test_find_by_merchant_id_returns_an_item_with_the_correct_merchant_id
    assert_equal item_repository.items[0], item_repository.find_by_merchant_id(1)
  end

  def test_find_all_by_merchant_id_returns_an_item_with_the_correct_merchant_id
    assert_equal 1, item_repository.find_all_by_merchant_id(1).first.merchant_id.to_i
  end

  def test_find_by_created_at_returns_an_item_with_the_correct_created_at
    assert_equal item_repository.items[0], item_repository.find_by_created_at("2012-03-27 14:53:59 UTC")
  end

  def test_find_all_by_created_at_returns_an_item_with_the_correct_created_at
    assert_equal "2012-03-27 14:53:59 UTC", item_repository.find_all_by_created_at("2012-03-27 14:53:59 UTC").first.created_at
  end

  def test_find_by_updated_at_returns_an_item_with_the_correct_updated_at
    assert_equal item_repository.items[0], item_repository.find_by_updated_at("2012-03-27 14:53:59 UTC")
  end

  def test_find_all_by_updated_at_returns_an_item_with_the_correct_updated_at
    assert_equal "2012-03-27 14:53:59 UTC", item_repository.find_all_by_updated_at("2012-03-27 14:53:59 UTC").first.updated_at
  end

  def test_the_most_revenue_x_method_returns_an_array_of_items_sorted_by_revenue
    result = item_repository.most_revenue(2)
    assert_equal Array, result.class
    assert_equal SalesEngine::Item, result.first.class
    assert result.first.revenue_generated > result.last.revenue_generated
  end

  def test_it_has_a_most_items_method
    assert item_repository.most_items(2)
  end

  def test_the_most_items_method_returns_an_array_of_items_sorted_by_number_sold
    result = item_repository.most_items(2)
    assert_equal Array, result.class
    assert_equal SalesEngine::Item, result.first.class
    assert result.first.number_sold > result.last.number_sold
  end

end
