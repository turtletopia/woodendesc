if (requireNamespace("httptest2", quietly = TRUE)) {
  library("httptest2")
}

httptest2::.mockPaths("../fx")

with_mock_dir <- function(dir, expr) {
  httptest2::with_mock_dir(
    file.path("..", "fx", dir),
    expr
  )
}
