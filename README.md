
<!-- README.md is generated from README.Rmd. Please edit that file -->

# electric\_journey\_planner

<!-- badges: start -->

<!-- badges: end -->

The goal of electric\_journey\_planner is to use the UK open charge
point registry to develop a method for determining the journey for an
electric vehicle over an arbitrary distance.

Also will use the google maps api to get the distances between any two
postcodes and cache them

## Overview plan

### Nodes

Using the publically available charging points database at
[data.gov.uk](https://data.gov.uk/dataset/1ce239a6-d720-4305-ab52-17793fedfac3/national-charge-point-registry)
I can extract the postcodes of the current charge points across the
whole UK. This is specifically the repository of publically accesible
charging points, so doesn’t account for any of the privately installed
and accesible points.

These then form the nodes of the network of charging points across the
uk.

### Edges

We can then use the google maps API to get the driving distances between
all the nodes in our network. Using the wrapper
[{gmapsdistance}](https://cran.r-project.org/web/packages/gmapsdistance/readme/README.html)
we can use any two UK postcodes as the input and get the driving
distance. We can also wrap the functions in this package, such that it
saves the results of the calls we make, and re-uses the results instead
of sending a new query to the GoogleMapsAPI.

Using this driving distance, we will then have edges for our network
with appropriate weights.

### Network infrastructure

For this project, and to generate the networks to perform our required
operations, we will be using the
[{tidygraph}](https://cran.r-project.org/web/packages/tidygraph/tidygraph.pdf)
package. This is based on earlier works with {igraph} and similar, but
reworked with a new interface to conform to the ‘tidyverse’ style.
