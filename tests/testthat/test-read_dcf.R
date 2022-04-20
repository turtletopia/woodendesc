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

# READ ALL VALUES ----
cynkra_packages <- read_dcf_all_values(PACKAGES, "Package")
misc_packages <- read_dcf_all_values(PACKAGES_2, "Package")

test_that("read_dcf_all_values() returns a vector of strings", {
  expect_vector(cynkra_packages,
                ptype = character())
  expect_vector(misc_packages,
                ptype = character())
})

test_that("read_dcf_all_values() returns non-empty string", {
  expect_gt(length(cynkra_packages), 0)
  expect_gt(length(misc_packages), 0)
})

test_that("read_dcf_all_values() returns all expected values from example file", {
  expect_setequal(
    cynkra_packages,
    c("dm", "cynkrathis", "fledge", "indiedown", "munch", "tic", "tv")
  )
})

# READ ONE VALUE ----
dm_version <- read_dcf_one_value(PACKAGES, "Version")
dm_package <- read_dcf_one_value(PACKAGES, "Package")
A3_version <- read_dcf_one_value(PACKAGES_2, "Version")

test_that("read_dcf_one_value() returns single string", {
  expect_vector(dm_version,
                ptype = character(),
                size = 1)
  expect_vector(dm_package,
                ptype = character(),
                size = 1)
  expect_vector(A3_version,
                ptype = character(),
                size = 1)
})

test_that("read_dcf_one_value() returns an expected value from example file", {
  expect_equal(dm_version, "0.2.8.9000")
  expect_equal(dm_package, "dm")
  expect_equal(A3_version, "1.0.0")
})

# READ TO STRING ----
packages <- read_char(system.file("extdata", "PACKAGES", package = "woodendesc"))

test_that("read_char() returns a single string", {
  expect_vector(packages,
                ptype = character(),
                size = 1)
})

test_that("read_char() contains data from the file", {
  expect_match(
    packages,
    "MD5sum: 3bf55df981de5d2b4e542de074f89098",
    fixed = TRUE
  )
  expect_match(
    packages,
    "fst, future, miniUI, parallel, reactable, shiny, shinyWidgets, tibble",
    fixed = TRUE
  )
})
