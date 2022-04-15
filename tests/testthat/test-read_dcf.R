# SETUP ----
PACKAGES_path <- system.file("extdata", "PACKAGES", package = "woodendesc")
PACKAGES <- readChar(PACKAGES_path, nchar = file.info(PACKAGES_path)[["size"]])

# READ PACKAGES ----
cynkra_packages <- read_dcf_packages(PACKAGES)

test_that("read_dcf_packages() returns a vector of strings", {
  expect_vector(cynkra_packages,
                ptype = character())
})

test_that("read_dcf_packages() returns non-empty string", {
  expect_gt(length(cynkra_packages), 0)
})

test_that("read_dcf_packages() returns only valid package names", {
  expect_pkg_name(cynkra_packages)
})

test_that("read_dcf_packages() returns all expected packages from example file", {
  expect_setequal(
    cynkra_packages,
    c("dm", "cynkrathis", "fledge", "indiedown", "munch", "tic", "tv")
  )
})
