# SETUP ----
core_packages <- wood_core_packages()

# TESTS ----
test_packages(core_packages)

test_that("core packages include utils and tools packages", {
  expect_subset(c("utils", "tools"), core_packages)
})
