require 'optparse'

def parse_arguments
    options = { pub: "pub.json", post: false }
    OptionParser.new do |opts|
        opts.banner = "Usage: ruby pubs.rb [options]"

        opts.on("-dID", "--delete=ID", "Delete pub with given id") do |p|
            options[:delete] = p
        end
        opts.on("-p", "--post", "Create new pub") do |p|
            options[:post] = true
        end
        
        opts.on("--pub=FILE", "JSON file with pub data") do |p|
            options[:pub] = p
        end
    end.parse!
    options
end

options = parse_arguments

if options[:post]
    puts %x(curl -s -D - -X POST -d @#{options[:pub]} localhost:3000/pubs -H "Accept: application/json" -H "Content-Type:application/json")
end
if options[:delete]
    puts %x(curl -s -D - -X DELETE localhost:3000/pubs/#{options[:delete]} -H "Accept: application/json" -H "Content-Type:application/json")
end
