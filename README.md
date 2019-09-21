# gym

`gym` creates a set of visualisations to chart (progress) in tracked exercise over time.

## visualisations

### time

`time`-chart tracks exercise intensity over time.

### workout

`workout`-chart tracks the intensity of individual workouts over time.

## scripts

`1.0_class_exercises.R` classes exercises by muscle group, before aggregating classes to similar muscle groups (e.g. push, pull, legs).

`2.0_download_data.R` downloads data and checks for clashes between input exercise groups and classed exercise groups.

`3.0_produce_charts.R` takes downloaded data and produces visualisations.

`master_script.sh` runs the above scripts sequentially.
