require 'spec_helper'

describe "SalesEngine customers" do

  describe "Searching" do

    describe ".random" do
      it "usually returns different things on subsequent calls" do
        customer_one = engine.customer_repository.random
        customer_two = engine.customer_repository.random

        10.times do
          break if customer_one.id != customer_two.id
          customer_two = engine.customer_repository.random
        end

        customer_one.id.should_not == customer_two.id
      end
    end

    describe ".find_by_last_name" do
      it "finds a record" do
        customer = engine.customer_repository.find_by_last_name "Ullrich"
        %w(Ramon Brice Annabell).should include(customer.first_name)
      end
    end

    describe ".find_all_by_first_name" do
      it "can find multiple records" do
        customers = engine.customer_repository.find_all_by_first_name "Sasha"
        customers.should have(2).customers
      end
    end

  end

#   context "Relationships" do
#     let(:customer) { engine.customer_repository.find_by_id 999 }

#     describe "#invoices" do
#       it "returns all of a customer's invoices" do
#         customer.invoices.should have(7).invoices
#       end

#       it "returns invoices belonging to the customer" do
#         customer.invoices.each do |invoice|
#           invoice.customer_id.should == 999
#         end
#       end
#     end
#   end

#   context "Business Intelligence" do
#     let(:customer) { engine.customer_repository.find_by_id 2 }

#     describe "#transactions" do
#       it "returns a list of transactions the customer has had" do
#         customer.transactions.should have(1).transaction
#       end
#     end

#     describe "#favorite_merchant" do
#       it "returns the merchant where the customer has had the most transactions" do
#         customer.favorite_merchant.name.should == "Shields, Hirthe and Smith"
#       end
#     end
#   end
end

