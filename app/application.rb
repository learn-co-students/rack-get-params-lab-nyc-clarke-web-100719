
class Application

  @@items = ["Apples","Carrots","Pears"]
  @@cart = Array.new


  def call(env)
    resp = Rack::Response.new
    req = Rack::Request.new(env)

    if req.path.match(/items/)
      @@items.each do |item|
        resp.write "#{item}\n"
      end

    elsif req.path.match(/search/)
      search_term = req.params["q"]
      resp.write handle_search(search_term)

    elsif req.path.match(/cart/)
      if @@cart.empty?
        resp.write "Your cart is empty"
      elsif !@@cart.empty?
        @@cart.each do |item|
          resp.write "#{item}\n"
        end
      end

    elsif req.path.match(/add/)
      arr_add_item = req.params["item"]
      # binding.pry
      # arr_add_item.each do |str_item|
        if @@items.include?(arr_add_item)
          @@cart << arr_add_item
          resp.write "added #{arr_add_item}"
        else
          resp.write "We don't have that item"
        end
      # end



      # search_item.each do |item|
      #   if @@items.include?(item)
      #     resp.write "Item already exists"
      #   else
      #     @@items << item
      #   end
      # end

    else
      resp.write "Path Not Found"
    end

    resp.finish
  end



  def handle_search(search_term)
    if @@items.include?(search_term)
      return "#{search_term} is one of our items"
    else
      return "Couldn't find #{search_term}"
    end
  end
end
