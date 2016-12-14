class Application

  def call(environment)
    response = Rack::Response.new
    request = Rack::Request.new(environment)

    if request.path.match("items/")
      item_name = request.path.split("/").last
      found_item = Item.all.find {|item| item.name == item_name}
      # binding.pry
      if  found_item
        response.write found_item.price
      else
        response.status = 400
        response.write "Item not found"
      end
    else
      response.status = 404
      response.write "Route not found."
    end
    response.finish
  end

end
