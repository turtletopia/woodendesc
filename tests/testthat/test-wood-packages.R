skip_if_not_installed("vcr")
wood_clear_cache()

# SETUP ----
vcr::use_cassette("lcb-packages", {
  packages <- wood_packages(repos = c("local#all", "cran", "bioc@1.5"))
}, record = "new_episodes")

# TESTS ----
test_packages(
  packages, wood_packages, .test_cache = FALSE
)

vcr::use_cassette("wood-omegahat-packages", {
  test_that("uppercase in URL is preserved", {
    expect_not_empty(wood_packages(repos = "http://www.omegahat.net/R"))
  })
}, record = "new_episodes")

test_that("empty vector is returned if repository doesn't exist", {
  expect_equal(
    wood_packages(repos = "https://www.notanRrepo.com"),
    character()
  )
})
