require 'csv'

class BaseRepository
  attr_accessor :id
  def initialize(csv_file)
    @csv_file = csv_file
    @elements = []
    @next_id = 1
    load_csv if File.exist?(@csv_file)
  end

  def add(element)
    element.id = @next_id
    @elements << element
    @next_id += 1
    save_csv
  end

  def all
    @elements
  end

  def find(id)
    @elements.find { |element| element.id == id } # "Return that |element| which element.id equals id"
  end

  def save_csv
    CSV.open(@csv_file, "w") do |csv|
      csv << @elements.first.class.headers # .first is embebbed already and so is .class (will return its class)
      # But .headers is from class method, and this class method returns something defined inside each model.
      @elements.each do |element|
        csv <<  element.to_csv_row # An instance method inside each model, because element is a model instance.
      end
    end
  end

  private

  def load_csv
    csv_options = { headers: :first_row, header_converters: :symbol }

    CSV.foreach(@csv_file, csv_options) do |row|
      @elements << build_element(row) # build element is a child repo method
      # only needed because id must go to to_i and must initialize a new instance of the repo, such as Customer.new
      @next_id += 1
    end
  end
end
