skip_if_not_installed("vcr")

vcr::use_cassette("ropensci-packages", {
  ropensci_packages <- wood_runiverse_packages()
})

test_that("returns a vector of strings", {
  expect_vector(ropensci_packages,
                ptype = character())
})

test_that("returned vector of strings is not empty", {
  expect_gt(length(ropensci_packages), 0)
})

test_that("all returned strings are valid package names", {
  expect_pkg_name(ropensci_packages)
})
