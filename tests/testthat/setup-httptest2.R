if (requireNamespace("httptest2", quietly = TRUE)) {
  library("httptest2")
}

with_mock_dir <- function(dir, expr) {
  httptest2::with_mock_dir(
    fs::path("fixtures", dir),
    expr
  )
}
