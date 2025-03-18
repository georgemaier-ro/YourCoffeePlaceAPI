# Methods for handling CSV data

module CsvHelper
  include UrlHelper
  include ErrorsHelper

  def create_csv_table_from_page(url)
    begin
      csv_table = CSV.new(read_remote_url(url))
    rescue StandardError
      api_error 3
    else
      csv_table
    end
  end

  def create_array_from_csv_table(csv_table)
    array_from_csv = csv_table.read
  end
end
