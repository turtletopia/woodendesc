#' @export
wood_core_dependencies <- function(package) {
  core_pkgs <- installed.packages(priority = "base")

  if (!package %in% rownames(core_pkgs))
    stop("package not part of R core", call. = FALSE)

  extract_dependencies(core_pkgs[package, ])
}
