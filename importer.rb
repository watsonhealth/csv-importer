# This script will use some gems to import a csv table
# and others to parse it to retrieve objects that can be imported in a database

require "smarter_csv"

# Define the maladie class (structure)
# (In rails it would be a Model)

class Maladie
  attr_accessor :nom, :symptomes, :prevalence, :contexte, :antecedents
  
  def add_symptom (symptome)
    # If symptomes is not defined we defined it as an array
    @symptomes ||= []
    @symptomes.push(symptome)
    puts 'adding symptom...'
  end  
  
  def to_s
    puts "Je suis #{@nom ? @nom  : "sans nom"} et j'ai #{ @symptomes ? @symptomes.size.to_s : 0} symptomes"  
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
        puts maladie_hash
        # Parse maladie hash to fill the maladie object well
        
        # Create new maladie object
        mal = Maladie.new
        # the second 'maladie' is referring to the column name in the excel
        mal.nom = maladie_hash['maladie']
        puts mal

        # find the keys matching "symptome" and pass their values to the add symptom method
        # 
        maladie_hash.each_key do |key| 
            mal.add_symptom(maladie_hash[key]) if key.include? "symptome"

        puts mal
    end

end

main