gem 'minitest'
require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/sales_engine/item.rb'
require_relative '../lib/sales_engine/item_repository.rb'

class ItemRepositoryTest < Minitest::Test

  attr_accessor :item_repository

  def setup
    @item_repository = ItemRepository.new('test/fixtures/item_repository_fixture.csv')
  end

  def test_it_has_an_attr_called_items
    assert item_repository.items
  end

  def test_populates_a_list_of_items
    assert item_repository.populate_list
  end

  def test_the_items_array_contains_Item_objects
    assert_equal Item, item_repository.items[0].class
  end

  def test_the_all_method_returns_loaded_items
    assert item_repository.all.length > 1
    assert_equal Item, item_repository.all[0].class
    assert_equal Item, item_repository.all[-1].class
  end

  def test_the_random_method_returns_a_random_item_from_the_loaded_items
    assert_equal Item, item_repository.random.class
    random_searches = []
    10.times do
      random_searches << item_repository.random
    end
    random_searches.reject {|s| s == item_repository.items[0]}
    assert random_searches.length > 2
  end

  def test_it_returns_an_item_repository_class
    assert_equal ItemRepository, item_repository.class
  end

  def test_find_by_id_returns_an_item_with_the_correct_id
    assert_equal item_repository.items[0], item_repository.find_by_id(1)
  end

  def test_find_all_by_id_returns_an_item_with_the_correct_id
    assert_equal item_repository.items.select { |item| item.id.to_i == 2 }, item_repository.find_all_by_id(2)
  end

  def test_find_by_name_returns_an_item_with_the_correct_name
    assert_equal item_repository.items[0], item_repository.find_by_name("Item Qui Esse")
  end

  def test_find_all_by_name_returns_an_item_with_the_correct_name
    assert_equal item_repository.items.select { |item| item.name == "Item Qui Esse" }, item_repository.find_all_by_name("Item Qui Esse")
  end

  def test_find_by_description_returns_an_item_with_the_correct_description
    assert_equal item_repository.items[0], item_repository.find_by_description("Nihil autem sit odio inventore deleniti. Est laudantium ratione distinctio laborum. Minus voluptatem nesciunt assumenda dicta voluptatum porro.")
  end

  def test_find_all_by_description_returns_an_item_with_the_correct_description
    assert_equal item_repository.items.select { |item| item.description == "Nihil autem sit odio inventore deleniti. Est laudantium ratione distinctio laborum. Minus voluptatem nesciunt assumenda dicta voluptatum porro." }, item_repository.find_all_by_description("Nihil autem sit odio inventore deleniti. Est laudantium ratione distinctio laborum. Minus voluptatem nesciunt assumenda dicta voluptatum porro.")
  end

  def test_find_by_unit_price_returns_an_item_with_the_correct_unit_price
    assert_equal item_repository.items[0], item_repository.find_by_unit_price(75107)
  end

  def test_find_all_by_unit_price_returns_an_item_with_the_correct_unit_price
    assert_equal item_repository.items.select { |item| item.unit_price == 75107}, item_repository.find_all_by_description(75107)
  end

end
