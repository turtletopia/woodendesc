if (requireNamespace("httptest2", quietly = TRUE)) {
  library("httptest2")
}

with_mock_dir <- function(dir, expr) {
  httptest2::with_mock_dir(
    file.path("fixtures", dir),
    expr
  )
}
