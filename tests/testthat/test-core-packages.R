core_packages <- wood_core_packages()

test_packages(core_packages, wood_core_packages, .test_cache = FALSE)

test_that("core packages include utils and tools packages", {
  expect_subset(c("utils", "tools"), core_packages)
})
