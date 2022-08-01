#' @export
wood_core_version <- function(package) {
  core_pkgs <- installed.packages(priority = "base")

  if (!package %in% rownames(core_pkgs))
    stop("package not part of R core", call. = FALSE)

  core_pkgs[package, "Version"]
}
