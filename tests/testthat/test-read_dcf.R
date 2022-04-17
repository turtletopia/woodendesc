# SETUP ----
PACKAGES <- read_to_string("extdata", "PACKAGES")
PACKAGES_2 <- read_to_string("extdata", "misc_PACKAGES")

# READ ALL ----
cynkra_all <- read_dcf(PACKAGES)
misc_all <- read_dcf(PACKAGES_2)

test_that("read_dcf() returns a list of lists", {
  expect_vector(cynkra_all,
                ptype = list())
  for (x in cynkra_all) {
    expect_vector(x,
                  ptype = list())
  }

  expect_vector(misc_all,
                ptype = list())
  for (x in misc_all) {
    expect_vector(x,
                  ptype = list())
  }
})

test_that("read_dcf() returns a list named with package names", {
  expect_named(
    cynkra_all,
    c("dm", "cynkrathis", "fledge", "indiedown", "munch", "tic", "tv"),
    ignore.order = TRUE
  )
})

test_that("each element of read_dcf() contains 'Package' and 'Version' fields", {
  for (x in cynkra_all) {
    expect_subset(c("Package", "Version"), names(x))
  }
})

test_that("all package fields in read_dcf() are single strings", {
  for (x in cynkra_all) {
    for (field in x) {
      expect_vector(field,
                    ptype = character(),
                    size = 1)
    }
  }
})

test_that("read_dcf() correctly parses multiline values when in the middle", {
  expect_match(misc_all[["aaSEA"]][["Imports"]], "shinydashboard", fixed = TRUE)
  expect_match(misc_all[["aaSEA"]][["Imports"]], "plotly", fixed = TRUE)
})

test_that("read_dcf() correctly parses multiline values when last field", {
  expect_match(
    misc_all[["CGIwithR"]][["URL"]],
    "http://www.warwick.ac.uk/go/cgiwithr",
    fixed = TRUE
  )
})

test_that("read_dcf() preserves newlines in values", {
  # Each of these fields contain exactly two newlines
  expect_match(misc_all[["aaSEA"]][["Imports"]], "\\n.*\\n")
  expect_match(misc_all[["CGIwithR"]][["URL"]], "\\n.*\\n")
})

test_that("read_dcf() doesn't introduce random newlines", {
  expect_no_match(misc_all[["ABACUS"]][["Imports"]], "\\n")
})

# READ PACKAGES ----
cynkra_packages <- read_dcf_packages(PACKAGES)
misc_packages <- read_dcf_packages(PACKAGES_2)

test_that("read_dcf_packages() returns a vector of strings", {
  expect_vector(cynkra_packages,
                ptype = character())
  expect_vector(misc_packages,
                ptype = character())
})

test_that("read_dcf_packages() returns non-empty string", {
  expect_gt(length(cynkra_packages), 0)
  expect_gt(length(misc_packages), 0)
})

test_that("read_dcf_packages() returns only valid package names", {
  expect_pkg_name(cynkra_packages)
  expect_pkg_name(misc_packages)
})

test_that("read_dcf_packages() returns all expected packages from example file", {
  expect_setequal(
    cynkra_packages,
    c("dm", "cynkrathis", "fledge", "indiedown", "munch", "tic", "tv")
  )
})
