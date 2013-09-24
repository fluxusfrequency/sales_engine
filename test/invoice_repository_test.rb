gem 'minitest'
require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/sales_engine/invoice.rb'
require_relative '../lib/sales_engine/invoice_repository.rb'

class InvoiceRepositoryTest < Minitest::Test

  attr_accessor :invoice_repository

  def setup
    @invoice_repository = InvoiceRepository.new('test/fixtures/invoice_repositoy_fixture.csv')
  end

  def test_it_has_an_attr_called_invoice
    assert invoice_repository.invoice
  end

  def test_populates_a_list_of_invoices
    assert invoice_repository.populate_list
  end

  def test_the_invoice_array_contains_Invoice_objects
    assert_equal Invoice, invoice_repository.invoice[0].class
  end

  def test_the_all_method_returns_loaded_items
    assert invoice_repository.all.length > 1
    assert_equal Invoice, invoice_repository.all[0].class
    assert_equal Invoice, invoice_repository.all[-1].class
  end

  def test_the_random_method_returns_a_random_item_from_the_loaded_items
    assert_equal Invoice, invoice_repository.random.class
    random_searches = []
    10.times do
      random_searches << invoice_repository.random
    end
    random_searches.reject {|s| s == invoice_repository.items[0]}
    assert random_searches.length > 2
  end

  def test_it_returns_an_invoice_repository_class
    assert_equal InvoiceRepository, invoice_repository.class
  end

  def test_find_by_id_returns_an_invoice_with_the_correct_id
    assert_equal invoice_repository.invoices[0], invoice_repository.find_by_id(1)
  end

  def test_find_all_by_id_returns_an_invoice_with_the_correct_id
    assert_equal invoice_repository.invoices.select { |invoice| invoice.id.to_i == 2 }, invoice_repository.find_all_by_id(2)
  end

  def test_find_by_customer_id_returns_an_invoice_with_the_correct_customer_id
    assert_equal invoice_repository.invoices[0], invoice_repository.find_by_customer_id(1)
  end

  def test_find_all_by_customer_id_returns_an_invoice_with_the_correct_customer_id
    assert_equal invoice_repository.invoices.select { |invoice| invoice.customer_id == 1 }, invoice_repository.find_all_by_name(1)
  end

  def test_find_by_description_returns_an_invoice_with_the_correct_description
    assert_equal invoice_repository.invoices[0], invoice_repository.find_by_description("Nihil autem sit odio inventore deleniti. Est laudantium ratione distinctio laborum. Minus voluptatem nesciunt assumenda dicta voluptatum porro.")
  end

  def test_find_all_by_description_returns_an_invoice_with_the_correct_description
    assert_equal invoice_repository.invoices.select { |invoice| invoice.description == "Nihil autem sit odio inventore deleniti. Est laudantium ratione distinctio laborum. Minus voluptatem nesciunt assumenda dicta voluptatum porro." }, invoice_repository.find_all_by_description("Nihil autem sit odio inventore deleniti. Est laudantium ratione distinctio laborum. Minus voluptatem nesciunt assumenda dicta voluptatum porro.")
  end

  def test_find_by_unit_price_returns_an_invoice_with_the_correct_unit_price
    assert_equal invoice_repository.invoices[0], invoice_repository.find_by_unit_price(75107)
  end

  def test_find_all_by_unit_price_returns_an_invoice_with_the_correct_unit_price
    assert_equal invoice_repository.invoices.select { |invoice| invoice.unit_price.to_i == 75107}, invoice_repository.find_all_by_unit_price(75107)
  end

  def test_find_by_merchant_id_returns_an_invoice_with_the_correct_merchant_id
    assert_equal invoice_repository.invoices[0], invoice_repository.find_by_merchant_id(1)
  end

  def test_find_all_by_merchant_id_returns_an_invoice_with_the_correct_merchant_id
    assert_equal invoice_repository.invoices.select { |invoice| invoice.merchant_id.to_i == 1}, invoice_repository.find_all_by_merchant_id(1)
  end

  def test_find_by_created_at_returns_an_invoice_with_the_correct_created_at
    assert_equal invoice_repository.invoices[0], invoice_repository.find_by_created_at("2012-03-27 14:53:59 UTC")
  end

  def test_find_all_by_created_at_returns_an_invoice_with_the_correct_created_at
    assert_equal invoice_repository.invoices.select { |invoice| invoice.created_at == "2012-03-27 14:53:59 UTC"}, invoice_repository.find_all_by_created_at("2012-03-27 14:53:59 UTC")
  end

  def test_find_by_updated_at_returns_an_invoice_with_the_correct_updated_at
    assert_equal invoice_repository.invoices[0], invoice_repository.find_by_updated_at("2012-03-27 14:53:59 UTC")
  end

  def test_find_all_by_updated_at_returns_an_invoice_with_the_correct_updated_at
    assert_equal invoice_repository.invoices.select { |invoice| invoice.updated_at == "2012-03-27 14:53:59 UTC"}, invoice_repository.find_all_by_updated_at("2012-03-27 14:53:59 UTC")
  end

end
