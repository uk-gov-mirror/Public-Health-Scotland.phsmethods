# Create age groups

`create_age_groups()` takes a numeric vector and assigns each age to the
appropriate age group.

## Usage

``` r
create_age_groups(
  x,
  from = lifecycle::deprecated(),
  to = lifecycle::deprecated(),
  by = lifecycle::deprecated(),
  as_factor = FALSE,
  breaks = seq(0, 90, 5)
)
```

## Arguments

- x:

  a vector of numeric values

- from, to, by:

  **\[deprecated\]** Use `breaks` instead.

- as_factor:

  The default behaviour is to return a character vector. Use `TRUE` to
  return a factor vector instead.

- breaks:

  a numeric vector of cut points defining the age groups. The default is
  `seq(0, 90, 5)`, which corresponds to the [European Standard
  Population](https://www.opendata.nhs.scot/dataset/standard-populations/resource/edee9731-daf7-4e0d-b525-e4c1469b8f69)
  age groups.

## Value

A character vector, where each element is the age group for the
corresponding element in `x`. If `as_factor = TRUE`, a factor vector is
returned instead.

## Details

The `breaks` vector defines the cut points for the age groups. The final
age group will capture all ages equal to or greater than the last value
in `breaks`, labelled as `last+`. If the cut points are not evenly
spaced, the labels will reflect the actual width of each group.

## Examples

``` r
age <- c(54, 7, 77, 1, 26, 101)

create_age_groups(age)
#> [1] "50-54" "5-9"   "75-79" "0-4"   "25-29" "90+"  
create_age_groups(age, breaks = seq(0, 80, 10))
#> [1] "50-59" "0-9"   "70-79" "0-9"   "20-29" "80+"  

# Non-uniform age groups
create_age_groups(age, breaks = c(0, 18, 45, 65, 90))
#> [1] "45-64" "0-17"  "65-89" "0-17"  "18-44" "90+"  

# Final group may start below the last break
create_age_groups(age, breaks = seq(0, 65, 10))
#> [1] "50-59" "0-9"   "60+"   "0-9"   "20-29" "60+"  

# To get the output as a factor:
create_age_groups(age, as_factor = TRUE)
#> [1] 50-54 5-9   75-79 0-4   25-29 90+  
#> 19 Levels: 0-4 < 5-9 < 10-14 < 15-19 < 20-24 < 25-29 < 30-34 < ... < 90+
```
