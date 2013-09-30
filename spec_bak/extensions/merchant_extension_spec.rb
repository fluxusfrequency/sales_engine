require 'spec_helper'

describe "SalesEngine merchant extensions", merchant: true do
  context "extensions" do
    describe ".dates_by_revenue" do
      it  "returns an array of Dates in descending order of revenue" do
        dates = engine.merchant_repository.dates_by_revenue

        (dates.first == DateTime.parse("2012-03-09") || dates.first == Date.parse("2012-03-09")).should be_true
        (dates[21] == DateTime.parse("2012-03-06") || dates[21] == Date.parse("2012-03-06")).should be_true
      end
    end

    describe ".dates_by_revenue(x)" do
      it  "returns the top x Dates in descending order of revenue" do
        dates = engine.merchant_repository.dates_by_revenue(5)

        dates.size.should == 5
        (dates[1] == DateTime.parse("2012-03-08") || dates[1] == Date.parse("2012-03-08")).should be_true
        (dates.last == DateTime.parse("2012-03-15") || dates.last == Date.parse("2012-03-15")).should be_true
      end
    end

    describe ".revenue(range_of_dates)" do
      it "returns the total revenue for all merchants across several dates" do
        date_1 = Date.parse("2012-03-14")
        date_2 = Date.parse("2012-03-16")
        revenue = engine.merchant_repository.revenue(date_1..date_2)

        revenue.should == BigDecimal("8226179.74")
      end
    end

    describe "#revenue(range_of_dates)" do
      it "returns the total revenue for that merchant across several dates" do
        date_1 = Date.parse("2012-03-01")
        date_2 = Date.parse("2012-03-07")
        merchant = engine.merchant_repository.find_by_id(7)
        revenue = merchant.revenue(date_1..date_2)

        revenue.should == BigDecimal("57103.77")
      end
    end
  end
end
