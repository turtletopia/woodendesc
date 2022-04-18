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
  lib_dir <- tempdir()
  withr::with_tempdir({
    # Create fake local library
    dir.create(file.path(lib_dir, "fakepackage"))
    file.create(file.path(lib_dir, "fakepackage", "DESCRIPTION"))

    # Call function
    local_multiple <- wood_local_packages(c(.libPaths(), lib_dir))
  }, tmpdir = lib_dir)

  # Actual tests
  expect_vector(local_multiple,
                ptype = character())
  expect_pkg_name(local_multiple)
  expect_subset("woodendesc", local_multiple)
  expect_subset("fakepackage", local_multiple)
})
