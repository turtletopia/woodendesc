expect_pkg_name <- function(object) {
  expect_match(
    object, "^[^\\W\\d_]([^\\W_]|\\.)*[^\\W_]$", perl = TRUE
  )
}
