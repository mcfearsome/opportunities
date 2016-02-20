#!/bin/ruby
# This script will apply JSON.pretty_generate to any json file
# in the passed in directory
require 'json'

folder = ARGV[0]

raise "Expected a directory as argument" unless File.directory?(folder)

# Loop over each .json file in directory
begin
  Dir.glob("#{folder}/*.json") do |f|
    obj = JSON.parse(IO.read(f))
    pretty_json = JSON.pretty_generate(obj)
    File.open(f, "w") {|nf| nf.write(pretty_json + "\n")}
  end
rescue IOError => e
  puts "An Error occurred: #{e}"
end
