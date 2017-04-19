require 'open-uri'

class MeteorologistController < ApplicationController
  def street_to_weather_form
    # Nothing to do here.
    render("meteorologist/street_to_weather_form.html.erb")
  end

  def street_to_weather
    @street_address = params[:user_street_address]

    # ==========================================================================
    # Your code goes below.
    #
    # The street address that the user typed is in the variable @street_address.
    # ==========================================================================

    base1 = "http://maps.googleapis.com/maps/api/geocode/json?address="
    user_input = @street_address.gsub(" ","+")
    close1 = "&sensor=false"
    url = base1 + user_input + close1
    parsed_data = JSON.parse(open(url).read)
    @lat = parsed_data["results"][0]["geometry"]["location"]["lat"]
    @lng = parsed_data["results"][0]["geometry"]["location"]["lng"]

    lat = @lat.to_s
    lng = @lng.to_s

    base2 = "https://api.darksky.net/forecast/860c5fb9d7d24f11b4ee4563c360c237/"
    combo =  lat + "," + lng
    url2 = base2 + combo
    parsed_data2 = JSON.parse(open(url2).read)


    @current_temperature = parsed_data2["currently"]["temperature"]

    @current_summary = parsed_data2["currently"]["summary"]

    @summary_of_next_sixty_minutes = parsed_data2["minutely"]["summary"]

    @summary_of_next_several_hours = parsed_data2["hourly"]["summary"]

    @summary_of_next_several_days = parsed_data2["daily"]["summary"]

    render("meteorologist/street_to_weather.html.erb")
  end
end
