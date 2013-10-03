class SalesEngine
  class CustomerRepository

    attr_reader :file, :customers

    def initialize(file)
      @file = file
      populate_list
    end

    def populate_list
      data = Database.load(file)
      @customers = data.collect do |row|
        Customer.new(row)
      end
    end

    def all
      customers
    end

    def random
      customers.sample
    end

    def find_by_id(id)
      grouped_by_id[id.to_s].first
    end

    def find_all_by_id(id)
      grouped_by_id[id.to_s] || []
    end

    def find_by_first_name(name)
      grouped_by_first_name[name].first
    end

    def find_all_by_first_name(name)
      grouped_by_first_name[name] || []
    end

    def find_by_last_name(name)
      grouped_by_last_name[name].first
    end

    def find_all_by_last_name(name)
      grouped_by_last_name[name] || []
    end

    def find_by_created_at(date)
      grouped_by_created_at[date].first
    end

    def find_all_by_created_at(date)
      grouped_by_created_at[date] || []
    end

    def find_by_updated_at(date)
      grouped_by_updated_at[date].first
    end

    def find_all_by_updated_at(date)
      grouped_by_updated_at[date] || []
    end

    def grouped_by_id
      @grouped_by_id ||= customers.group_by {|customer| customer.id }
    end

    def grouped_by_first_name
      @grouped_by_first_name ||= customers.group_by {|customer| customer.first_name }
    end

    def grouped_by_last_name
      @grouped_by_last_name ||= customers.group_by {|customer| customer.last_name }
    end

    def grouped_by_created_at
      @grouped_by_created_at ||= customers.group_by {|customer| customer.created_at }
    end

    def grouped_by_updated_at
      @grouped_by_updated_at ||= customers.group_by {|customer| customer.updated_at }
    end

  end
end