module CoffeeShopsHelper
  include CsvHelper

  def setup_coffee_shops_list
    url = "https://raw.githubusercontent.com/Agilefreaks/test_oop/master/coffee_shops.csv"
    csv_table = create_csv_table_from_page(url)
    array_from_csv = create_array_from_csv_table(csv_table)
    valid_array_of_locations = validate_coffee_shop_locations(array_from_csv)
  end

  def sort_coffee_shops_by_distance(latitude, longitude)
    valid_array_of_locations = setup_coffee_shops_list
    coffee_shops = []
    valid_array_of_locations.each do |coffee_shop|
      coffee_shops << create_coffee_shop_with_distance(coffee_shop, latitude, longitude)
    end

    sorted_coffee_shops = coffee_shops.sort_by(&:distance)
    list_only_required_info(sorted_coffee_shops)
  end

  def validate_coffee_shop_locations(array_from_csv)
    valid_array_of_locations = []
    array_from_csv.each do |coffee_shop|
      if validate_coffee_shop(coffee_shop)
        valid_array_of_locations << coffee_shop
      end
    end

    valid_array_of_locations
  end

  def validate_coffee_shop(coffee_shop)
    new_coffee_shop = CoffeeShop.new(coffee_shop[0], coffee_shop[1], coffee_shop[2])
    true if new_coffee_shop.valid?
  end

  def create_coffee_shop_with_distance(coffee_shop, latitude, longitude)
    coffee_shop = CoffeeShop.new(coffee_shop[0], coffee_shop[1], coffee_shop[2])
    coffee_shop.calculate_distance(latitude, longitude)
    coffee_shop
  end

  def list_only_required_info(coffee_shops)
    top_three_coffee_shops = coffee_shops.map do |coffee_shop|
      [ coffee_shop.name, coffee_shop.distance, coffee_shop.latitude, coffee_shop.longitude ]
    end
    top_three_coffee_shops.first(3)
  end
end
