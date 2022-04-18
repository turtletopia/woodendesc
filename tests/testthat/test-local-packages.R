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
