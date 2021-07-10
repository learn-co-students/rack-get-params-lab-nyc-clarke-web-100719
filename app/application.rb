class Application

  @@items = ["Apples","Carrots","Pears"]
  @@cart = []
  def call(env)
    resp = Rack::Response.new
    req = Rack::Request.new(env)

    if req.path.match(/cart/)
      if @@cart.empty? 
        resp.write "Your cart is empty"
      else
        @@cart.each do |car|
          resp.write "#{car}\n"
        end
      end
    elsif req.path.match(/add/)
      search_add = req.params["item"]
     if @@items.include?(search_add)
       @@cart << search_add
       resp.write "added #{search_add}"
     else
      resp.write "We don't have that item"
     end
    end

    resp.finish
  end



end
