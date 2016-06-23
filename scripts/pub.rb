class Pub
  def self.handle(request)
    action = request.split[1] if request.split.length > 1
    case action
      when "post"
      when "get"
        id = request.split[2] if request.split.length > 2
        if id
          puts %x(curl -s -D - -X GET localhost:3000/pubs/#{id} -H "Accept: application/json" -H "Content-Type:application/json")
        else
          puts %x(curl -s -D - -X GET localhost:3000/pubs -H "Accept: application/json" -H "Content-Type:application/json")
        end
      when "put"
        
      when "delete"
        
      else
        puts "Illegal action or parameters supplied for Pub resource"
    end
  end
end
