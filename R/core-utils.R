validate_core_package <- function(package, packages) {
  if (!package %in% rownames(packages)) {
    stopf(
      c("`package` must be one of R core packages.\n",
        "(i) Package `%1$s` is not a part of R core"),
      package
    )
  }
}
