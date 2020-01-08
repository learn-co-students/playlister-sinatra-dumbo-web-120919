# Add seed data here. Seed your database with `rake db:seed`
require_relative "../lib/library_parser.rb"

library = LibraryParser.new
library.call
