skip_if_not_installed("vcr")
wood_clear_cache()

# SETUP ----
vcr::use_cassette("gh-turtletopia-packages", {
  turtletopia_packages <- wood_github_packages("turtletopia")
})

# TESTS ----
test_packages(turtletopia_packages)
test_cache(wood_github_packages, turtletopia_packages, user = "turtletopia")

test_that("several packages make the list", {
  expect_subset(c("versionsort", "gglgbtq", "woodendesc"), turtletopia_packages)
})

test_that("non-packages are omitted", {
  expect_no_match(turtletopia_packages, "^universe$")
})
