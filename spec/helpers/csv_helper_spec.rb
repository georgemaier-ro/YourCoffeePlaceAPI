require 'rails_helper'

RSpec.describe CsvHelper, type: :helper do
  let! (:url) { ENV['COFFEE_SHOP_URL'] }
  let! (:invalid_url) { "h!!!ttps://raw.githubusercontent.com/Agilefreaks/test_oop/master/coffee_shops.csv" }

  context 'read_remote_csv' do
    it 'creates a CSV table based on the URL' do
      csv_table = create_csv_table_from_page(url)
      expect(csv_table.present?).to be true
    end

    it 'raises an error if csv is invalid' do
      expect { create_csv_table_from_page(invalid_url) }.to raise_error(an_instance_of(ErrorsService).and having_attributes(message: "Invalid CSV table"))
    end

    it 'raises an error if csv is nil' do
      expect { create_csv_table_from_page(nil) }.to raise_error(an_instance_of(ErrorsService).and having_attributes(message: "Invalid CSV table"))
    end

    it 'creates an array from the csv' do
      csv_table = create_csv_table_from_page(url)
      expect(create_array_from_csv_table(csv_table)).to be_an_instance_of(Array)
    end

    it 'creates an array that includes coffee shops' do
      csv_table = create_csv_table_from_page(url)
      expect(create_array_from_csv_table(csv_table).include?([ "Starbucks Seattle", "47.5809", "-122.3160" ])).to eq(true)
    end

    it 'raises an error if csv_table is nil' do
      expect { create_array_from_csv_table(nil) }.to raise_error(an_instance_of(ErrorsService).and having_attributes(message: "Invalid CSV table"))
    end
  end
end
