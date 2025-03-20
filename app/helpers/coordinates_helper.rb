module CoordinatesHelper
  # Checks if its a valid coordinate/float
  def check_if_valid_float(coordinate)
    if coordinate.to_s !~ /^\s*[+-]?((\d+_?)*\d+(\.(\d+_?)*\d+)?|\.(\d+_?)*\d+)(\s*|([eE][+-]?(\d+_?)*\d+)\s*)$/
      return false
    end
    true
  end

  # Calculates distance between two coordinantes
  # to_s for values guards against can't omit precision for a Float error, there are probably better ways to do it, needs more investigating
  # didn't want to mess with the precision for now as BigDecimal can also handle strings, we just use precision for magnitude cause we round anyway.
  def calculate_distance(latitude, longitude, user_latitude, user_longitude)
    check_coordinates(latitude, longitude, user_latitude, user_longitude)
    begin
      current_location = Vector[BigDecimal(latitude.to_s), BigDecimal(longitude.to_s)]
      user_location = Vector[BigDecimal(user_latitude.to_s), BigDecimal(user_longitude.to_s)]
      distance = BigDecimal((current_location - user_location).magnitude, 10).round(4).to_s
    rescue StandardError
      raise ErrorsService.new("Invalid coordinates, can't calculate distance.")
    end
  end

  def check_coordinates(latitude, longitude, user_latitude, user_longitude)
    coordinates_to_check = [ latitude, longitude, user_latitude, user_longitude ]
    coordinates_to_check.each do |coordinate|
      if !coordinate.present? || !check_if_valid_float(coordinate)
        raise ErrorsService.new("Invalid user coordinate #{coordinate}, can't calculate distance.")
      end
    end
  end
end
