require 'readline'

require_relative 'pub'

ACTIONS = [
  'pub post', 'pub get', 'pub put', 'pub delete',
  'beer post', 'beer get', 'beer put', 'beer delete',
  'event post', 'event get', 'event put', 'event delete',
  'comment post', 'comment get', 'comment put', 'comment delete', 
  'user post', 'user get', 'user put', 'user delete', 
  'token post', 'token get', 'token put', 'token delete', 
  'subscription post', 'subscription get', 'subscription put', 'subscription delete', 
  'notification post', 'notification get', 'notification put', 'notification delete', 
  'offer post', 'offer get', 'offer put', 'offer delete'
].sort

RESOURCES = ['Pub', 'Beer', 'Event', 'Comment', 'User', 'Token', 'Subscription', 'Notification', 'Offer']

comp = proc { |s| ACTIONS.grep(/^#{Regexp.escape(s)}/) }

Readline.completion_append_character = " "
Readline.completion_proc = comp
Readline.completer_word_break_characters = ""

while line = Readline.readline('> ', true)
  resource_read = line.split.first.capitalize
  if RESOURCES.include? resource_read
    Object::const_get(resource_read).handle(line)
  else
    puts "#{resource} is not a valid resource!"
  end
end

#~if options[:post]
    #~puts %x(curl -s -D - -X POST -d @#{options[:pub]} localhost:3000/pubs -H "Accept: application/json" -H "Content-Type:application/json")
#~end
#~if options[:update]
    #~puts %x(curl -s -D - -X UPDATE -d @#{options[:pub]} localhost:3000/pubs/#{options[:update]} -H "Accept: application/json" -H "Content-Type:application/json")
#~end
#~if options[:delete]
    #~puts %x(curl -s -D - -X DELETE localhost:3000/pubs/#{options[:delete]} -H "Accept: application/json" -H "Content-Type:application/json")
#~end
