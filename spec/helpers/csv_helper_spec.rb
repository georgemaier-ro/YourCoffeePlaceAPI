require 'rails_helper'

RSpec.describe CsvHelper, type: :helper do
  let! (:url) { "https://raw.githubusercontent.com/Agilefreaks/test_oop/master/coffee_shops.csv" }
  let! (:invalid_url) { "h!!!ttps://raw.githubusercontent.com/Agilefreaks/test_oop/master/coffee_shops.csv" }

  context 'read_remote_csv' do
    it 'creates a CSV table based on the URL' do
      csv_table = create_csv_table_from_page(url)
      expect(csv_table.present?).to be true
    end

    it 'raise an error if csv is invalid' do
      # expect(csv_table = create_csv_table_from_page(invalid_url)).to eq(api_error(3))
    end
  end
end
