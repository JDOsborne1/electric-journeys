
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

Using the publically available charging points database at
[data.gov.uk](https://data.gov.uk/dataset/1ce239a6-d720-4305-ab52-17793fedfac3/national-charge-point-registry)
I can extract the postcodes of the current charge points across the
whole UK. This is specifically the repository of publically accesible
charging points, so doesn’t account for any of the privately installed
and accesible points.

These then form the nodes of the network of charging points across the
uk.
