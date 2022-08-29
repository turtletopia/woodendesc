# SETUP ----
# Create fake local library
fake_lib_pkgs <- c("fakepackage", "woodendesc")
lib_dir <- local_fake_library("fakepackage", "woodendesc")
lib_dir_2 <- local_fake_library("fakepackage", "woodendesc", path = "fake_dir")

# TESTS ----
test_param_package(wood_local_versions)
test_param_paths(wood_local_versions, package = "woodendesc")

woodendesc_versions <- wood_local_versions("woodendesc")

test_that("returns a vector of strings", {
  expect_vector(woodendesc_versions,
                ptype = character())
})

test_that("returned vector is not empty if package found", {
  expect_gt(length(woodendesc_versions), 0)
})

test_that("returned vector is empty if package not found", {
  expect_equal(wood_local_versions("fakepackage"), character())
})

test_that("different path may be specified", {
  fakepackage_version <- wood_local_versions("fakepackage", lib_dir)

  expect_vector(fakepackage_version,
                ptype = character())
  expect_equal(fakepackage_version, "0.0.0.9000")
})

test_that("multiple paths may be specified", {
  local_multiple <- wood_local_versions("woodendesc", c(.libPaths(), lib_dir))

  expect_vector(local_multiple,
                ptype = character())
})

test_that("repeated versions are listed only once", {
  local_multiple <- wood_local_versions("fakepackage", c(lib_dir, lib_dir_2))
  expect_setequal(local_multiple, unique(local_multiple))
})

test_that("all found versions are listed", {
  local_multiple <- wood_local_versions("woodendesc", c(.libPaths(), lib_dir))
  expect_equal(length(local_multiple), 2)
})

test_that("paths = \"all\" is a shorthand for all .libPaths()", {
  expect_equal(
    wood_local_versions("woodendesc", paths = "all"),
    wood_local_versions("woodendesc", paths = .libPaths())
  )
})
