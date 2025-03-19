# Methods used to validate coffee shops from an array
module CoffeeShopValidator
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
    new_coffee_shop.valid? ? true : false
  end
end
