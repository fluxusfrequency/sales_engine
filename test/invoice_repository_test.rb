gem 'minitest'
require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/sales_engine.rb'

class InvoiceRepositoryTest < Minitest::Test

  attr_accessor :invoice_repository, :database

  def setup
    @database = SalesEngine::Database
    database.setup_stubs
    @invoice_repository = database.invoice_repository
  end

  def teardown
  end

  def test_it_has_an_attr_called_invoices
    assert invoice_repository.invoices
  end

  def test_the_invoice_array_contains_Invoice_objects
    assert_equal SalesEngine::Invoice, invoice_repository.invoices[0].class
  end

  def test_the_all_method_returns_loaded_items
    assert invoice_repository.all.length > 1
    assert_equal SalesEngine::Invoice, invoice_repository.all[0].class
    assert_equal SalesEngine::Invoice, invoice_repository.all[-1].class
  end

  def test_the_random_method_returns_a_random_item_from_the_loaded_items
    assert_equal SalesEngine::Invoice, invoice_repository.random.class
    random_searches = []
    10.times do
      random_searches << invoice_repository.random
    end
    random_searches.reject {|s| s == invoice_repository.invoices[0]}
    assert random_searches.length > 2
  end

  def test_it_returns_an_invoice_repository_class
    assert_equal SalesEngine::InvoiceRepository, invoice_repository.class
  end

  def test_find_by_id_returns_an_invoice_with_the_correct_id
    assert_equal invoice_repository.invoices[0], invoice_repository.find_by_id(1)
  end

  def test_find_all_by_id_returns_an_invoice_with_the_correct_id
    assert_equal 1, invoice_repository.find_all_by_id(1).first.id.to_i
  end

  def test_find_by_customer_id_returns_an_invoice_with_the_correct_customer_id
    assert_equal invoice_repository.invoices[0], invoice_repository.find_by_customer_id(1)
  end

  def test_find_all_by_customer_id_returns_an_invoice_with_the_correct_customer_id
    assert_equal 1, invoice_repository.find_all_by_customer_id(1).first.id.to_i
  end

  def test_find_by_merchant_id_returns_an_invoice_with_the_correct_merchant_id
    assert_equal invoice_repository.invoices[0], invoice_repository.find_by_merchant_id(26)
  end

  def test_find_all_by_merchant_id_returns_an_invoice_with_the_correct_merchant_id
    assert_equal 26, invoice_repository.find_all_by_merchant_id(26).first.merchant_id.to_i
  end

  def test_find_by_status_returns_an_invoice_with_the_correct_status
    assert_equal invoice_repository.invoices[0], invoice_repository.find_by_status("shipped")
  end

  def test_find_all_by_status_returns_an_invoice_with_the_correct_status
    assert_equal "shipped", invoice_repository.find_all_by_status("shipped").first.status
  end

  def test_find_by_created_at_returns_an_invoice_with_the_correct_created_at
    assert_equal invoice_repository.invoices[0], invoice_repository.find_by_created_at("2012-03-25 09:54:09 UTC")
  end

  def test_find_all_by_created_at_returns_an_invoice_with_the_correct_created_at
    assert_equal "2012-03-25 09:54:09 UTC", invoice_repository.find_all_by_created_at("2012-03-25 09:54:09 UTC").first.created_at
  end

  def test_find_by_updated_at_returns_an_invoice_with_the_correct_updated_at
    assert_equal invoice_repository.invoices[0], invoice_repository.find_by_updated_at("2012-03-25 09:54:09 UTC")
  end

  def test_find_all_by_updated_at_returns_an_invoice_with_the_correct_updated_at
    assert_equal "2012-03-25 09:54:09 UTC", invoice_repository.find_all_by_updated_at("2012-03-25 09:54:09 UTC").first.updated_at
  end

  def test_it_has_a_create_function_that_takes_a_hash_of_parameters
    item1_data = {:id => 13,
            :name => "Item Qui Esse",
            :description => "Nihil autem sit odio inventore deleniti. Est laudantium ratione distinctio laborum. Minus voluptatem nesciunt assumenda dicta voluptatum porro.",
            :unit_price => 75107,
            :merchant_id => 1,
            :created_at => "2012-03-27 14:53:59 UTC",
            :updated_at => "2012-03-27 14:53:59 UTC"
            }
    item2_data = {:id => 14,
            :name => "Monkeys In A Barrel",
            :description => "They're a barrel of fun.",
            :unit_price => 55135,
            :merchant_id => 1,
            :created_at => "2012-03-27 14:53:59 UTC",
            :updated_at => "2012-03-27 14:53:59 UTC"
            }
    customer_data = {:id => 1,
            :first_name => "Joey",
            :last_name => "Ondricka",
            :created_at => "2012-03-27 14:54:09 UTC",
            :updated_at => "2012-03-27 14:54:09 UTC"
            }
    merchant_data = {:id => 1,
            :name => "Schroeder-Jerde",
            :created_at => "2012-03-27 14:53:59 UTC",
            :updated_at => "2012-03-27 14:53:59 UTC"
            }
    item1 = SalesEngine::Item.new(item1_data, SalesEngine)
    item2 = SalesEngine::Item.new(item2_data, SalesEngine)
    customer = SalesEngine::Customer.new(customer_data, SalesEngine)
    merchant = SalesEngine::Merchant.new(merchant_data, SalesEngine)

    params_hash = {id: SalesEngine::Database.find_last_invoice.id.to_i+1, customer: customer, merchant: merchant, status: "shipped", items: [item1, item1, item2]}
    assert SalesEngine::Database.invoice_repository.create(params_hash)
  end

end
