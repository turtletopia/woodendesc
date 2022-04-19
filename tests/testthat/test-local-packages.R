# SETUP ----
# Create fake local library
fake_lib_pkgs <- c("fakepackage", "woodendesc")
lib_dir <- local_fake_library("fakepackage", "woodendesc")

# TESTS ----
local_packages <- wood_local_packages()

test_that("returns a vector of strings", {
  expect_vector(local_packages,
                ptype = character())
})

test_that("returned vector of strings is not empty", {
  expect_gt(length(local_packages), 0)
})

test_that("all returned strings are valid package names", {
  expect_pkg_name(local_packages)
})

test_that("local packages include woodendesc package", {
  expect_subset("woodendesc", local_packages)
})

test_that("different path may be specified", {
  local_fakelib <- wood_local_packages(lib_dir)

  expect_vector(local_fakelib,
                ptype = character())
  expect_setequal(local_fakelib, fake_lib_pkgs)
})

test_that("multiple paths may be specified", {
  local_multiple <- wood_local_packages(c(.libPaths(), lib_dir))

  expect_vector(local_multiple,
                ptype = character())
  expect_subset(fake_lib_pkgs, local_multiple)
  expect_subset(local_packages, local_multiple)
})

test_that("repeated packages are listed only once", {
  local_multiple <- wood_local_packages(c(.libPaths(), lib_dir))
  expect_setequal(local_multiple, unique(local_multiple))
})

test_that("paths = \"all\" is a shorthand for all .libPaths()", {
  expect_equal(
    wood_local_packages("all"),
    wood_local_packages(.libPaths())
  )
})
