if (requireNamespace("vcr", quietly = TRUE)) {
  library("vcr") # *Required* as vcr is set up on loading
  invisible(vcr::vcr_configure(
    dir = vcr::vcr_test_path("fixtures"),
    verbose_errors = TRUE
  ))
  vcr::check_cassette_names()
}
