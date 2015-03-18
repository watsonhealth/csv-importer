# This script will use some gems to import a csv table
# and others to parse it to retrieve objects that can be imported in a database

require "smarter_csv"

def main

    puts "Hello Ruby ! It's been a long time"
    # check the smarter csv documentation
    # !!! Works only if the file is utf-8 encoded !!! (exported as csv via NUMBERS on Mac and NOT "save as " on Excel)
    maladies = SmarterCSV.process(
        'liste.csv',
        :col_sep => ";",
        :strings_as_keys => true)

    puts maladies.size.to_s + " maladies imported"

    maladies do |maladie|
        puts "hello"
    end

end

main