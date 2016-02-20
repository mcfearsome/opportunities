require 'json'
require_relative './point'

class Position < Struct.new(:title)
end

class Company
  attr_accessor :name, :careers_url, :main_url, :address,
                :geo_point, :positions, :state, :county

  class << self
    def from_json(raw_json)
      data = JSON.parse(raw_json)
      name = data['company']
      careers_url = data['url']
      main_url = data['webSiteUrl']
      address = data['address']
      geo_point = [data['geo']['longitude'].to_f, data['geo']['latitude'].to_f]
      positions = data['positions'].collect {|p| p['title']}
      return Company.new(name, careers_url, main_url, address, geo_point, positions)
    end
  end

  def initialize(name, careers_url, main_url, address,
                 geo_point, positions)
    @name = name
    @careers_url = careers_url
    @main_url = main_url
    @address = address
    @geo_point = Point.new(geo_point[0], geo_point[1])
    @positions = []
    positions.each do |p|
      @positions.push(Position.new(p))
    end
  end

  def to_json
    {
      company: @name,
      url: @careers_url,
      webSiteUrl: @main_url,
      address: @address,
      geo: {
        longitude: @geo_point.x,
        latitude: @geo_point.y
      },
      positions: @positions.collect {|p| {title: p.title} },
      state: @state,
      county: @county
    }.to_json
  end
end
