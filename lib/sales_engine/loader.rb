require 'csv'

class SalesEngine
  class Loader
    def initialize
    end

    def self.load(filename)
      CSV.open(filename, headers: true, header_converters: :symbol)
    end

  end
end
