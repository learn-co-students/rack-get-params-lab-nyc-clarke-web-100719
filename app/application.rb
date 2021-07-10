# require 'pry'
class Application

  @@items = ["Apples","Carrots","Pears"]
  @@cart = [] 

  def call(env)
    resp = Rack::Response.new
    req = Rack::Request.new(env)

    if req.path.match(/items/)
      @@items.each do |item|
        resp.write "#{item}\n"
      end

    elsif req.path.match(/cart/)
      resp.write "Your cart is empty" unless @@cart.count > 0
      @@cart.each { |item|
        resp.write "#{item}\n"
      }
    elsif req.path.match(/add/)
      add_term = req.params["item"]
      # puts '='*70
      # puts '\n'*2
      # puts "This is #{add_term}0000000"
      # puts '\n'*2
      # puts '='*70
      # puts '\n'*2
      if @@items.include?(add_term)
        @@cart.push(add_term)
        resp.write "added #{add_term}"
      else
        resp.write "We don't have that item"
      end
    elsif req.path.match(/search/)
      search_term = req.params["q"]
      resp.write handle_search(search_term)
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
