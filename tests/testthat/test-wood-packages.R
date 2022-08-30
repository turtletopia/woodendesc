skip_if_not_installed("vcr")
wood_clear_cache()

# SETUP ----
vcr::use_cassette("lcb-packages", {
  packages <- wood_packages(repos = c("local#all", "cran", "bioc@1.5"))
}, record = "new_episodes")

vcr::use_cassette("wood-colinfay-packages", {
  colinfay_packages <- wood_packages(repos = "https://colinfay.me")
}, record = "new_episodes")

# TESTS ----
test_packages(packages)
test_param_repos(wood_packages)

test_that("uppercase in URL is preserved", {
  expect_not_empty(colinfay_packages)
})

test_that("empty vector is returned if repository doesn't exist", {
  expect_equal(
    wood_packages(repos = "https://www.notanRrepo.com"),
    character()
  )
})
