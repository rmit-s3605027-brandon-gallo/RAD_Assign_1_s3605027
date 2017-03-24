require "thor"
class App < Thor
 # Description of the command.
  desc "welcome", "Print 'welcome ${name}' to the screen"
  # Definition of the command and its argument.
  def welcome name
    # Print a string and the argument provided by the user.
    puts "Welcome #{name}! ☺"
  end
end
App.start ARGV