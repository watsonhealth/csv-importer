# This script will use some gems to import a csv table
# and others to parse it to retrieve objects that can be imported in a database

require "smarter_csv"

# Define the maladie and symptome class (structure)
# (In rails it would be a Model)

class Symptome
    attr_accessor :nom, :position, :specifics

    # Ex: to get substring you need to use regex scanning
    # String1 = "<name> <substring>"
    # String1.scan( /<([^>]*)>/).last.first
    # 
    def initialize(sym_str)
        # We get the name from the string first
        @nom = sym_str.split(" (").first

        # Then we get the parenthesis if it exists
        parenth_scan = sym_str.scan(/\(([^>]*)\)/)
        parenth = parenth_scan.first ? parenth_scan.first.first : nil

        if parenth
            # 2/1:3:4
            @position = parenth.split("/").first

            # Scan for 1:3:4 to get the number
            parenth_sub = parenth.split("/").size == 2 ? parenth.split("/").last : ""

            @specifics = parenth_sub.split(":")

        else
            @position = -1
            @specifics ||= []
        end
    end

    def to_s
        return "Je suis #{@nom} positionne à #{@position} avec #{@specifics ? @specifics.size.to_s : 0} specificitees"
    end
end

class Maladie
  attr_accessor :nom, :symptomes, :contexte, :incidence, :prevalence, :antecedents
  
  def add_symptom (symptome)
    # If symptomes is not defined we defined it as an array
    @symptomes ||= []
    sympt = Symptome.new(symptome)
    @symptomes.push(sympt)
    puts 'adding symptom...' + sympt.to_s
  end
  
  def to_s
    # Creates the standard string representation of the Maladie object
    return "Je suis #{@nom ? @nom  : "sans nom"} et j'ai #{@symptomes ? @symptomes.size.to_s : 0} symptomes. Contexte : #{ @contexte || "non"}, inc: #{@incidence || "non"} prev: #{@prevalence || "non"} ant: #{@antecedents || "non"}" 
  end

end  

def main

    puts "Hello Ruby ! It's been a long time"
    # check the smarter csv documentation
    # !!! Works only if the file is utf-8 encoded !!! (exported as csv via NUMBERS on Mac and NOT "save as " on Excel)
    maladies_csv = SmarterCSV.process(
        'liste.csv',
        :col_sep => ";",
        :strings_as_keys => true)

    puts maladies_csv.size.to_s + " maladies imported"

    maladies_csv.each do |maladie_hash|
        # Parse maladie hash to fill the maladie object well
        
        puts maladie_hash

        # Create new maladie object
        mal = Maladie.new

        # the second part in ['  '] is referring to the column name in the excel
        mal.nom         = maladie_hash['maladie']
        mal.contexte    = maladie_hash['contexte']
        mal.incidence   = maladie_hash['incidence'] ? maladie_hash['incidence'].to_i : nil
        # Parse the prevalence to convert it to floating point number
        mal.prevalence  = maladie_hash['prevalence'] ? maladie_hash['prevalence'].chop.sub(",", ".").to_f : nil
        mal.antecedents = maladie_hash['antecedents']

        puts mal

        # find the keys matching "symptome" and pass their values to the add symptom method
        maladie_hash.each_key { |key| mal.add_symptom(maladie_hash[key]) if key.include? "symptome" }
        
        puts mal
    end
end

main