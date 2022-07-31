core_packages <- wood_core_packages()

test_that("returns a vector of strings", {
  expect_vector(core_packages,
                ptype = character())
})

test_that("returned vector of strings is not empty", {
  expect_gt(length(core_packages), 0)
})

test_that("all returned strings are valid package names", {
  expect_pkg_name(core_packages)
})

test_that("core packages include utils and tools packages", {
  expect_subset(c("utils", "tools"), core_packages)
})
