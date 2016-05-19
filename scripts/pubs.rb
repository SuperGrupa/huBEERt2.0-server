require 'optparse'

def parse_arguments
    options = { pub: "pub.json", post: false }
    OptionParser.new do |opts|
        opts.banner = "Usage: ruby pubs.rb [options]"

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
    %x(curl -X POST -d @#{options[:pub]} localhost:3000/pubs --header "Content-Type:application/json")
end