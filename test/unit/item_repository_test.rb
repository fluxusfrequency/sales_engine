gem 'minitest'
require 'minitest/autorun'
require 'minitest/pride'
require_relative '../../lib/sales_engine.rb'

class ItemRepositoryTest < Minitest::Test
  attr_accessor :database, :item_repository

  def setup
    @database = SalesEngine::Database
    database.startup_fixtures
    @item_repository ||= database.item_repository
  end

  def test_it_should_exist
    assert !item_repository.nil?
  end

  def test_it_should_have_an_attr_called_items_that_returns_an_array_of_item_objects
    result = item_repository.items
    assert_equal Array, result.class
    assert_equal SalesEngine::Item, result.first.class
  end

  def test_it_has_an_all_method_that_returns_an_array_of_item_objects
    result = item_repository.all
    assert_equal Array, result.class
    assert_equal SalesEngine::Item, result.last.class
  end

  def test_the_random_method_returns_a_random_item_from_the_loaded_items
    result = item_repository.random
    assert_equal SalesEngine::Item, result.class
    random_searches = []
    10.times { random_searches << item_repository.random }
    random_searches.reject {|s| s == item_repository.items[0]}
    assert random_searches.length > 2
  end

  def test_it_has_a_find_by_id_method_that_returns_an_item_with_the_matching_id
    result = item_repository.find_by_id(9)
    assert_equal SalesEngine::Item, result.class
    assert_equal 9, result.id.to_i
  end

  def test_it_has_a_find_all_by_id_method_that_returns_an_array_of_items_with_the_matching_id
    result = item_repository.find_all_by_id(9)
    assert_equal Array, result.class
    assert_equal SalesEngine::Item, result.first.class
    assert_equal 9, result.last.id.to_i
  end

  def test_it_has_a_find_by_name_method_that_returns_an_item_with_the_matching_name
    result = item_repository.find_by_name("Item Nemo Facere")
    assert_equal SalesEngine::Item, result.class
    assert_equal "Item Nemo Facere", result.name
  end

  def test_it_has_a_find_all_by_name_method_that_returns_an_array_of_items_with_the_matching_name
    result = item_repository.find_all_by_name("Item Nemo Facere")
    assert_equal Array, result.class
    assert_equal SalesEngine::Item, result.last.class
    assert_equal "Item Nemo Facere", result.last.name
  end

  def test_it_has_a_find_by_description_method_that_returns_an_item_itm_with_the_matching_id
    result = item_repository.find_by_description("Numquam officiis reprehenderit eum ratione neque tenetur. Officia aut repudiandae eum at ipsum doloribus. Iure minus itaque similique. Ratione dicta alias asperiores minima ducimus nesciunt at.")
    assert_equal SalesEngine::Item, result.class
    assert_equal "Numquam officiis reprehenderit eum ratione neque tenetur. Officia aut repudiandae eum at ipsum doloribus. Iure minus itaque similique. Ratione dicta alias asperiores minima ducimus nesciunt at.", result.description
  end

  def test_it_has_a_find_all_by_description_method_that_returns_an_array_of_items_with_the_matching_id
    result = item_repository.find_all_by_description("Numquam officiis reprehenderit eum ratione neque tenetur. Officia aut repudiandae eum at ipsum doloribus. Iure minus itaque similique. Ratione dicta alias asperiores minima ducimus nesciunt at.")
    assert_equal Array, result.class
    assert_equal SalesEngine::Item, result.last.class
    assert_equal "Numquam officiis reprehenderit eum ratione neque tenetur. Officia aut repudiandae eum at ipsum doloribus. Iure minus itaque similique. Ratione dicta alias asperiores minima ducimus nesciunt at.", result.last.description
  end

  def test_it_has_a_find_by_unit_price_method_that_returns_an_item_with_the_matching_id
    result = item_repository.find_by_unit_price(67076)
    assert_equal SalesEngine::Item, result.class
    assert_equal 67076, result.unit_price.to_i
  end

  def test_it_has_a_find_all_by_unit_price_method_that_returns_an_array_of_items_with_the_matching_id
    result = item_repository.find_all_by_unit_price(67076)
    assert_equal Array, result.class
    assert_equal SalesEngine::Item, result.last.class
    assert_equal 67076, result.last.unit_price.to_i
  end

  def test_it_has_a_find_by_merchant_id_method_that_returns_an_item_with_the_matching_id
    result = item_repository.find_by_merchant_id(1)
    assert_equal SalesEngine::Item, result.class
    assert_equal 1, result.merchant_id.to_i
  end

  def test_it_has_a_find_all_by_merchant_id_method_that_returns_an_array_of_items_with_the_matching_id
    result = item_repository.find_all_by_merchant_id(1)
    assert_equal Array, result.class
    assert_equal SalesEngine::Item, result.last.class
    assert_equal 1, result.last.merchant_id.to_i
  end

  def test_it_has_a_find_by_created_at_method_that_returns_an_item_itm_with_the_matching_id
    result = item_repository.find_by_created_at(Date.parse("2012-03-27 14:53:59 UTC"))
    assert_equal SalesEngine::Item, result.class
    assert_equal Date.parse("2012-03-27 14:53:59 UTC"), result.created_at
  end

  def test_it_has_a_find_all_by_created_at_method_that_returns_an_array_of_items_with_the_matching_id
    result = item_repository.find_all_by_created_at(Date.parse("2012-03-27 14:53:59 UTC"))
    assert_equal Array, result.class
    assert_equal SalesEngine::Item, result.last.class
    assert_equal Date.parse("2012-03-27 14:53:59 UTC"), result.last.created_at
  end

  def test_it_has_a_find_by_updated_at_method_that_returns_an_item_itm_with_the_matching_id
    result = item_repository.find_by_updated_at(Date.parse("2012-03-27 14:53:59 UTC"))
    assert_equal SalesEngine::Item, result.class
    assert_equal Date.parse("2012-03-27 14:53:59 UTC"), result.updated_at
  end

  def test_it_has_a_find_all_by_updated_at_method_that_returns_an_array_of_items_with_the_matching_id
    result = item_repository.find_all_by_updated_at(Date.parse("2012-03-27 14:53:59 UTC"))
    assert_equal Array, result.class
    assert_equal SalesEngine::Item, result.last.class
    assert_equal Date.parse("2012-03-27 14:53:59 UTC"), result.last.updated_at
  end


end