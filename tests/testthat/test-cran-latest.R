skip_if_not_installed("vcr")
wood_clear_cache()

# SETUP ----
vcr::use_cassette("versionsort-latest", {
  versionsort_latest <- wood_cran_latest("versionsort")
})

# TESTS ----
test_version(versionsort_latest)
test_cache(wood_cran_latest, versionsort_latest, "versionsort")
