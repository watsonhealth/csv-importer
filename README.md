# csv-importer

###### This a simple ruby script to import and parse csv file describing sicknesses and symptoms and convert them into Ruby Objects (Model) ready to be imported in a RoR database !

It assumes you have Ruby installed on your computer (through a ruby version manager such as rbenv preferably).

It uses only one gem (it is the ruby word for "external librairy") for the moment called "smarter_csv" (https://github.com/tilo/smarter_csv).

This gem will open the csv file and transform it into a ruby array of "hash" structure (key value pairs)

The csv file has be encoded in UTF-8 format. 
!!! In order to obtain that you have to open the xls file in Numbers (Mac) and not Excel, and use the "export" functionality

Even if it uses one gem, we are using the tool called "Bundler" to manage gems in this ruby project (http://bundler.io/), like Rails does. (See at the bottom)

###### To run the script, do:

gem install bundler
=> install the bundler
bundle install
=> install the gems and produce Gemfile.lock

(you can try the following commands to see more:
bundle show
bundle update)

once this is done, just run

ruby importer.rb

to see the result

###### What does each part of the script does ?

...
Exercice: fill this part of the README !
...


###### Side note : What is Bundler ?

Bundler is made to resolve dependencies between your gems so if you want to use, for example (fake numbers):

gem rails version 0.3
gem activerecord

As rails 0.3 depends on activerecord version 0.1 and the current version of activerecord is 0.2, if you do something like this without bundler, rails will be broken because you overwrote the activerecord gem with the more recent one, and it is not necessarely backwards compatible.

Imagine the same scenario with twenty gems all depending on different versions of hundreds of smaller gems... you get the idea of the problem.

bundler uses algorithmic to determine the best solution given the constraints you give him and produces the file Gemfile.lock, which is the resolved problem.

End of side note.
