require 'thor'
class App < Thor
  # Description & definition of arguments & options.
  desc 'list_trends',''
  option :"api-key", :type => :string
  option :"format", :type => :string
  option :"no-country-code", :type => :boolean
  def list_trends search = nil
    # Open, read the json file and store its contents in the variable.
    contents = File.read('list_trends.json')
        # Validate the user input for the api-key option to ensure it meets the requirements.
        if options[:"api-key"].length >= 8 && /\D/ === options[:"api-key"] && /\d/ === options[:"api-key"]
          # Split the string stored in the contents variable for accessibility when printing.
          substring = contents.tr(":",",").split(",")
          Integer i = 1
          puts("--------------")
          if search != nil
            while substring[i] != nil
              if contents.downcase.include?(search.to_s.downcase)
                if substring[i][2..-2].to_s.downcase.include?(search.to_s.downcase)
                  # Print in the format which reflects the users input.
                  if options[:"format"] != "oneline"
                    $stderr.puts "Trend Country: "+substring[i][2..-2]
                      if options[:"no-country-code"] == nil
                        $stderr.puts "Trend Country Code: "+substring[i+2][2..-2]
                      end
                    $stderr.puts "Trend Location Name: "+substring[i+4][2..-2]
                    $stderr.puts "Trend Location Place Type: "+substring[i+11][2..-8]
                    puts("")
                  else
                    if options[:"no-country-code"] == nil
                      $stderr.puts substring[i][2..-2] + " " + substring[i+2][2..-2] + " " + substring[i+4][2..-2] + " " + substring[i+11][2..-8]
                    else
                      $stderr.puts substring[i][2..-2] + " " + substring[i+4][2..-2] + " " + substring[i+11][2..-8]
                    end
                    end
                end
              end
              i = i + 18
            end
          else
            while substring[i] != nil
              if options[:"format"] != "oneline"
                $stderr.puts "Trend Country: "+substring[i][2..-2]
                if options[:"no-country-code"] == nil
                  $stderr.puts "Trend Country Code: "+substring[i+2][2..-2]
                end
                $stderr.puts "Trend Location Name: "+substring[i+4][2..-2]
                $stderr.puts "Trend Location Place Type: "+substring[i+11][2..-8]
                puts("")
              else
                if options[:"no-country-code"] == nil
                  $stderr.puts substring[i][2..-2] + " " + substring[i+2][2..-2] + " " + substring[i+4][2..-2] + " " + substring[i+11][2..-8]
                else
                  $stderr.puts substring[i][2..-2] + " " + substring[i+4][2..-2] + " " + substring[i+11][2..-8]
                end
              end
            i = i + 18
            end
            end
        else
          # Handle a user input for the api-key option which does not meet the requirements.
          puts("Invalid API Key, operation abort...")
          end
  end
end
App.start(ARGV)