# R-UNIVERSE URL ----
test_that("runiverse_url() returns a single string", {
  expect_vector(runiverse_url("ropensci"),
                ptype = character(),
                size = 1)
  expect_vector(runiverse_url("tidyverse", "packages", "ggplot2"),
                ptype = character(),
                size = 1)
})

test_that("runiverse_url() separates API with slashes", {
  expect_match(
    runiverse_url("tidyverse", "packages", "ggplot2"),
    "/packages/ggplot2",
    fixed = TRUE
  )
})
