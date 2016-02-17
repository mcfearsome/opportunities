# Opportunities

## Table of contents

* [Introduction](#introduction)
* [Contributing](#contributing)
* [Build](#build)
* [Acknowledgements](#acknowledgements)


## Introduction

Just a dump of data I've been collecting on companies hiring around Philadelphia.  I might eventually spin this in to some sort of app - if so I have no plans to monetize... totally an open source effort.


## Contributing

### New company
If you want to list a new company, please perform the following steps:

* Fork the repository.
* Create a new JSON file in the `companies` folder.
  * Please only use Alphanumeric characters [A-Za-z0-9] or "-" for the company portion of the filename.
* Review the `sample.json` file to see an example.
* For the company object populate the following attributes:
  * company
  * url
    * Should be for the company's careers or jobs page.
  * webSiteUrl
    * Main page for the company.
  * address
  * geo
    * You can use [MyGeoPosition.com](http://mygeoposition.com/) to determine the geolocation for the address.
  * positions
    * If no current positions, leave as an empty array.
* For the position objects populate the following attributes:
  * title
* Other attributes can be populated on either the company or position objects.
* Commit you changes.
* Create a pull request.


### Meta Data
More meta data is welcome. The `sample.json` files shows an expanded version of the meta data in use. Where possible, the meta data has tried to match the vocabulary of [Schema.org](http://schema.org/). In general, the [JobPosting schema](https://schema.org/JobPosting) is a reference point for the position's meta data.

If you have thoughts on how to enhance the meta data, please open an [issue](https://github.com/mcelaney/opportunities/issues) and share your ideas.


## Build

For building the county files, you need to have [Node.js](https://nodejs.org/) and [npm](https://www.npmjs.com/) installed. Type `npm run merge` to merge the company JSON files into their county file.


## Acknowledgements

### Geospacial Data

The Delaware Valley Regional Planning Commission provided most of the geospatial data. You can find the original data on their [website](http://www.dvrpc.org/Mapping/data.htm). Additional sources of data:
* Pennsylvania Spatial Data Access provided the coordinates for Chester County. ([data set](http://www.pasda.psu.edu/uci/MetadataDisplay.aspx?entry=PASDA&file=PaCounty2015_01.xml&dataset=24))
* FirstMap Open Data provided the coordinates for New Castle County. ([data set](http://opendata.firstmap.delaware.gov/datasets/634f9ede21d1479c8779ab82628ebd4c_0
))
