cpp20_available <- function() {
  .Call(`_cpp20_available`)
}

cpp_chi_check <- function(x, check_mod11, check_mod10) {
  .Call(`_phsmethods_cpp_chi_check`, x, check_mod11, check_mod10)
}

cpp_dob_from_chi <- function(x, min_date, max_date) {
  .Call(`_phsmethods_cpp_dob_from_chi`, x, min_date, max_date)
}
