require_relative '../sales_engine.rb'

class SalesEngine
  class InvoiceItemRepository

    attr_reader :invoice_items, :file, :data

    def initialize(file)
      @file = file
      @data = SalesEngine::Database.load(file)
      populate_list
    end

    def all
      invoice_items
    end

    def random
      invoice_items.sample
    end

    def create(item_counts, invoice_id)
      item_counts.keys.each_with_index do |item, index|
        next_id = SalesEngine::Database.find_last_invoice_item.id.to_i+index+1
        data_hash = { :id => next_id,
                      :item_id => item.id,
                      :invoice_id => invoice_id,
                      :quantity => item_counts[item],
                      :unit_price => item.unit_price,
                      :created_at => item.created_at,
                      :updated_at => item.updated_at
                      }
        new_invoice_item = SalesEngine::InvoiceItem.new(data_hash, SalesEngine)
        SalesEngine::Database.invoice_item_repository.save_new_invoice_item_row(new_invoice_item)
      end
      SalesEngine::Database.reload_invoice_item_repository(file)
    end

    def save_new_invoice_item_row(invoice_item)
      invoice_item_attrs = [invoice_item.id,
                            invoice_item.item_id,
                            invoice_item.invoice_id,
                            invoice_item.quantity,
                            invoice_item.unit_price,
                            invoice_item.created_at,
                            invoice_item.updated_at]

      SalesEngine::Database.save(file, invoice_item_attrs)
    end

    def find_all_by_invoice_id(invoice_id)
      invoice_items_grouped_by_invoice_id[invoice_id.to_i]
    end

    def invoice_items_grouped_by_invoice_id
      @invoice_items_grouped_by_invoice_id ||= all.group_by { |invoice_item| invoice_item.invoice_id.to_i }
    end

    private

    def populate_list
      @invoice_items = data.collect do |row|
        SalesEngine::InvoiceItem.new(row, SalesEngine)
      end
    end

    [:id, :item_id, :invoice_id, :quantity, :unit_price, :created_at, :updated_at].each do |attr|
      define_method("find_by_#{attr}") do |match|
        match ||= ''
        invoice_items.find { |invoice_item| invoice_item.send(attr).to_s == match.to_s }
      end
    end

    [:id, :item_id, :invoice_id, :quantity, :unit_price, :created_at, :updated_at].each do |attr|
      define_method("find_all_by_#{attr}") do |match|
        match ||= ''
        invoice_items.select { |invoice_item| invoice_item.send(attr).to_s == match.to_s }
      end
    end

  end
end
