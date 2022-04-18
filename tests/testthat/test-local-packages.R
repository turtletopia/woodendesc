# SETUP ----
# Create fake local library
lib_dir <- tempdir()
withr::local_tempdir(tmpdir = lib_dir)
dir.create(file.path(lib_dir, "fakepackage"))
file.create(file.path(lib_dir, "fakepackage", "DESCRIPTION"))

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

test_that("multiple paths may be specified", {
  local_multiple <- wood_local_packages(c(.libPaths(), lib_dir))

  expect_vector(local_multiple,
                ptype = character())
  expect_pkg_name(local_multiple)
  expect_subset("fakepackage", local_multiple)
  expect_subset(local_packages, local_multiple)
})
