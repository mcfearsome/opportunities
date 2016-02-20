##
# This class represents a county within a state
#
# contains_point code from:
# http://jakescruggs.blogspot.com/2009/07/point-inside-polygon-in-ruby.html

require 'json'
require_relative './point'

class County
  attr_accessor :state
  attr_accessor :county
  attr_accessor :polygon_points

  class << self
    ##
    # Creates a new County from raw geojson data

    def from_json(json_raw)
      data = JSON.parse(json_raw)
      state = data['properties']['state']
      county = data['features'][0]['properties']['name']
      polygon_points = data['features'][0]['geometry']['coordinates'][0][0]
      return County.new(state, county, polygon_points)
    end
  end

  ##
  # initialize method
  # +state+ is a string
  # +county+ is a string
  # +polygon_points+ expects an array of points and creates
  # an array of Point objects where:
  # x = longitude
  # y = latitude

  def initialize(state, county, polygon_points)
    @state = state
    @county = county
    @polygon_points = []
    polygon_points.each do |p|
      @polygon_points.push(Point.new(p[0],p[1]))
    end
  end

  ##
  # Determines if a point is within the county
  # +point+ is a Point objects where:
  # x = longitude
  # y = latitude
  
  def contains_point?(point)
    contains_point = false
    i = -1
    j = @polygon_points.size - 1
    while (i += 1) < @polygon_points.size
      a_point_on_polygon = @polygon_points[i]
      trailing_point_on_polygon = @polygon_points[j]
      if point_is_between_the_ys_of_the_line_segment?(point, a_point_on_polygon, trailing_point_on_polygon)
        if ray_crosses_through_line_segment?(point, a_point_on_polygon, trailing_point_on_polygon)
          contains_point = !contains_point
        end
      end
      j = i
    end
    return contains_point
  end

private

def point_is_between_the_ys_of_the_line_segment?(point, a_point_on_polygon, trailing_point_on_polygon)
  (a_point_on_polygon.y <= point.y && point.y < trailing_point_on_polygon.y) ||
  (trailing_point_on_polygon.y <= point.y && point.y < a_point_on_polygon.y)
end

def ray_crosses_through_line_segment?(point, a_point_on_polygon, trailing_point_on_polygon)
  (point.x < (trailing_point_on_polygon.x - a_point_on_polygon.x) * (point.y - a_point_on_polygon.y) /
             (trailing_point_on_polygon.y - a_point_on_polygon.y) + a_point_on_polygon.x)
end

end
