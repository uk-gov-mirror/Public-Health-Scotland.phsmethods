# Check the validity of a CHI number

`chi_check` takes a CHI number or a vector of CHI numbers with
`character` class. It returns feedback on the validity of the entered
CHI number and, if found to be invalid, provides an explanation as to
why.

## Usage

``` r
chi_check(chi_number, check_mod11 = TRUE, check_mod10 = TRUE)
```

## Arguments

- chi_number:

  a CHI number or a vector of CHI numbers with `character` class.

- check_mod11, check_mod10:

  Logical values (TRUE or FALSE, default is `TRUE`). By default, a CHI
  that passes either the modulo 10 or the modulo 11 check will be
  considered valid. Historically, CHIs only used modulo 11 for their
  check digit; however, starting in August 2026, some CHIs will only
  pass if they meet the modulo 10 criteria. Implementation of Mod 10 CHI
  numbers is scheduled for August 2026. From this date, CHI numbers are
  valid if they pass either a Mod 11 check or a Mod 10 check.

## Value

`chi_check` returns a character string. Depending on the validity of the
entered CHI number, it will return one of the following:

- `Valid CHI`

- `Invalid character(s) present`

- `Too many characters`

- `Too few characters`

- `Invalid date`

- `Invalid checksum`

- `Missing (NA)`

- `Missing (Blank)`

## Details

The Community Health Index (CHI) is a register of all patients in NHS
Scotland. A CHI number is a unique, ten-digit identifier assigned to
each patient on the index.

The first six digits of a CHI number are a patient's date of birth in
DD/MM/YY format.

The ninth digit of a CHI number identifies a patient's sex: odd for
male, even for female. The tenth digit is a check digit, denoted
`checksum`.

While a CHI number is made up exclusively of numeric digits, it cannot
be stored with `numeric` class in R. This is because leading zeros in
numeric values are silently dropped, a practice not exclusive to R. For
this reason, `chi_check` accepts input values of `character` class only.
A leading zero can be added to a nine-digit CHI number using
[`chi_pad()`](https://public-health-scotland.github.io/phsmethods/reference/chi_pad.md).

`chi_check` assesses whether an entered CHI number is valid by checking
whether the answer to each of the following criteria is `Yes`:

- Does it contain no non-numeric characters?

- Is it ten digits in length?

- Do the first six digits denote a valid date?

- Is the checksum digit correct?

## Examples

``` r
chi_check("0101011237")
#> By default, `chi_check()` now returns CHI numbers as valid if they pass either
#> a Mod11 or Mod10 check
#> Previously `chi_check()` would only return CHI numbers as valid if they pass a
#> Mod11 check - for this behaviour, please use `chi_check(chi_number, check_mod10
#> = FALSE)`
#> This message is displayed once per session.
#> [1] "Valid CHI"
chi_check(c("0101201234", "3201201234"))
#> [1] "Valid CHI"    "Invalid date"

library(dplyr)
df <- tibble(chi = c(
  "3213201234",
  "123456789",
  "12345678900",
  "010120123?",
  NA
))
df %>%
  mutate(validity = chi_check(chi))
#> # A tibble: 5 × 2
#>   chi         validity                    
#>   <chr>       <chr>                       
#> 1 3213201234  Invalid date                
#> 2 123456789   Too few characters          
#> 3 12345678900 Too many characters         
#> 4 010120123?  Invalid character(s) present
#> 5 NA          Missing (NA)                
```
