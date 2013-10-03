require 'spec_helper'

describe "SalesEngine merchants" do
  context "Searching" do
    describe ".random" do
      it "usually returns different things on subsequent calls" do
        merchant_one = engine.merchant_repository.random
        merchant_two = engine.merchant_repository.random

        10.times do
          break if merchant_one.id != merchant_two.id
          merchant_two = engine.merchant_repository.random
        end

        merchant_one.id.should_not == merchant_two.id
      end
    end

    describe ".find_by_name" do
      it "can find a record" do
        merchant = engine.merchant_repository.find_by_name "Marvin Group"
        merchant.should_not be_nil
      end
    end

    describe ".find_all_by_name" do
      it "can find multiple records" do
        merchants = engine.merchant_repository.find_all_by_name "Williamson Group"
        merchants.should have(2).merchants
      end
    end
  end

  # context "Relationships" do
  #   let(:merchant) { engine.merchant_repository.find_by_name "Kirlin, Jakubowski and Smitham" }

  #   describe "#items" do
  #     it "has the correct number of them" do
  #       merchant.items.should have(33).items
  #     end

  #     it "includes a known item" do
  #       item = merchant.items.find {|i| i.name == 'Item Consequatur Odit' }
  #       item.should_not be_nil
  #     end
  #   end

  #   describe "#invoices" do
  #     it "has the correct number of them" do
  #       merchant.invoices.should have(43).invoices
  #     end

  #     it "has a shipped invoice for a specific customer" do
  #       invoice = merchant.invoices.find {|i| i.customer.last_name == 'Block' }
  #       invoice.status.should == "shipped"
  #     end
  #   end
  # end

  # context "Business Intelligence" do

  #   describe ".revenue" do
  #     it "returns all revenue for a specific date" do
  #       date = Date.parse "Tue, 20 Mar 2012"

  #       revenue = engine.merchant_repository.revenue(date)
  #       revenue.should == BigDecimal.new("2549722.91")
  #     end
  #   end

  #   describe ".most_revenue" do
  #     it "returns the top n revenue-earners" do
  #       most = engine.merchant_repository.most_revenue(3)
  #       most.first.name.should == "Dicki-Bednar"
  #       most.last.name.should  == "Okuneva, Prohaska and Rolfson"
  #     end
  #   end

  #   describe ".most_items" do
  #     it "returns the top n item-sellers" do
  #       most = engine.merchant_repository.most_items(5)
  #       most.first.name.should == "Kassulke, O'Hara and Quitzon"
  #       most.last.name.should  == "Daugherty Group"
  #     end
  #   end

  #   describe "#revenue" do
  #     context "without a date" do
  #       let(:merchant) { engine.merchant_repository.find_by_name "Dicki-Bednar" }

  #       it "reports all revenue" do
  #         merchant.revenue.should == BigDecimal.new("1148393.74")
  #       end
  #     end
  #     context "given a date" do
  #       let(:merchant) { engine.merchant_repository.find_by_name "Willms and Sons" }

  #       it "restricts to that date" do
  #         date = Date.parse "Fri, 09 Mar 2012"

  #         merchant.revenue(date).should == BigDecimal.new("8373.29")
  #       end
  #     end
  #   end

  #   describe "#favorite_customer" do
  #     let(:merchant) { engine.merchant_repository.find_by_name "Terry-Moore" }
  #     let(:customer_names) do
  #       [["Jayme", "Hammes"], ["Elmer", "Konopelski"], ["Eleanora", "Kling"],
  #        ["Friedrich", "Rowe"], ["Orion", "Hills"], ["Lambert", "Abernathy"]]
  #     end

  #     it "returns the customer with the most transactions" do
  #       customer = merchant.favorite_customer
  #       customer_names.any? do |first_name, last_name|
  #         customer.first_name == first_name
  #         customer.last_name  == last_name
  #       end.should be_true
  #     end
  #   end

  #   describe "#customers_with_pending_invoices" do
  #     let(:merchant) { engine.merchant_repository.find_by_name "Parisian Group" }

  #     it "returns the total number of customers with pending invoices" do
  #       customers = merchant.customers_with_pending_invoices
  #       customers.count.should == 4
  #       customers.any? do |customer|
  #         customer.last_name == "Ledner"
  #       end.should be_true
  #     end
  #   end
  # end

end
