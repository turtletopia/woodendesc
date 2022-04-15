# R OLDER THAN ----
test_that("R_older_than() returns a single boolean", {
  expect_vector(R_older_than("3.5.3"),
                ptype = logical(),
                size = 1)
})

test_that("R_older_than() returns correct results (will fail after R 10.0)", {
  expect_false(R_older_than("1.0"))
  expect_true(R_older_than("10.0"))
})
