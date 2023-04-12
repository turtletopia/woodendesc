test_that("functions are assigned properly", {
  expect_equal(find_function("cran", "packages"), wood_cran_packages)
  expect_equal(find_function("cran", "version"), wood_cran_versions)
  expect_equal(find_function("cran", "dependencies"), wood_cran_dependencies)

  expect_equal(find_function("bioc", "packages"), wood_bioc_packages)
  expect_equal(find_function("bioc", "version"), wood_bioc_version)
  expect_equal(find_function("bioc", "dependencies"), wood_bioc_dependencies)

  expect_equal(find_function("github", "packages"), wood_github_packages)
  expect_equal(find_function("github", "version"), wood_github_versions)
  expect_equal(find_function("github", "dependencies"), wood_github_dependencies)

  expect_equal(find_function("runiverse", "packages"), wood_runiverse_packages)
  expect_equal(find_function("runiverse", "version"), wood_runiverse_version)
  expect_equal(find_function("runiverse", "dependencies"), wood_runiverse_dependencies)

  expect_equal(find_function("url", "packages"), wood_url_packages)
  expect_equal(find_function("url", "version"), wood_url_version)
  expect_equal(find_function("url", "dependencies"), wood_url_dependencies)

  expect_equal(find_function("local", "packages"), wood_local_packages)
  expect_equal(find_function("local", "version"), wood_local_versions)
  expect_equal(find_function("local", "dependencies"), wood_local_dependencies)

  expect_equal(find_function("core", "packages"), wood_core_packages)
  expect_equal(find_function("core", "version"), wood_core_version)
  expect_equal(find_function("core", "dependencies"), wood_core_dependencies)
})
