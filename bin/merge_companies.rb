require 'json'
require './lib/company'
require './lib/county'
require './lib/point'

geojson_path = ARGV[0]
companies_path = ARGV[1]
store_path = ARGV[2]

counties = []
companies = []
# Create directory to store JSON
Dir.mkdir(store_path) unless File.exists?(store_path)

# Read in geojson data
Dir.glob("#{geojson_path}/*.geojson") do |f|
  counties.push(County.from_json(IO.read(f)))
end

# Loop over files in path and add to companies array
Dir.glob("#{companies_path}/*.json") do |f|
  companies.push(Company.from_json(IO.read(f)))
end

# Get rid of companies without any positions
companies.keep_if {|c| c.positions.size > 0 }

# Loop over counties and find companies within them
counties.each do |county|
  companies.each do |company|
    next unless company.state.nil?
    if county.contains_point?(company.geo_point)
      company.state = county.state
      company.county = county.county
    end
  end
end

def write_array_to_file_as_json(path, arr)
  File.delete(path) if File.exists?(path)
  begin
    file = File.open(path, "w")
    file.write("[\n")
    arr.each do |item|
      file.write(item.to_json)
      file.write(",\n") unless arr.last == item
    end
    file.write("\n]")
  rescue IOError => e
    puts "IOError: #{e}"
  ensure
    file.close unless file.nil?
  end
end

# First delete then rewrite the all-companies.json file
all_companies_path = "#{store_path}/all-companies.json"
write_array_to_file_as_json(all_companies_path, companies)

# Write a json file for each county
counties.each do |county|
  county_companies = companies.select { |company| company.county == county.county }
  county_companies_path = "#{store_path}/#{county.state.downcase}-#{county.county.tr(' ','-').downcase}.json"
  write_array_to_file_as_json(county_companies_path, county_companies) unless county_companies.size == 0
  puts "#{county.state} - #{county.county}: #{county_companies.size}"
end
