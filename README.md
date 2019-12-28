<!-- badges: start -->
[![Travis build status](https://travis-ci.org/joel-becker/gym.svg?branch=master)](https://travis-ci.org/joel-becker/gym)
<!-- badges: end -->

# gym

`gym` creates a set of visualisations to chart (progress) in tracked exercise over time.

## scripts

Scripts are to be run in the below order. (Eventually this will be formalised in a master script.)

1. `download_data.R` downloads the data from google sheets.
2. `class_exercises.R` classes exercises according to muscle group(s) used.
3. `wrangle_data.R` wrangles data in preperation for plotting.
4. `plot_data.R` produces visualisations from the wrangled data.

## visualisations

The following are visualisations produced by `plot_data.R`. (Eventually there will be example visualisations in this readme.)

### time

`time`-chart tracks exercise intensity over time.

### workout

`workout`-chart tracks the intensity of individual workouts over time.
