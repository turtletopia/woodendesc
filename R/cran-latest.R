#' Get latest package version on CRAN
#'
#' @description This function queries CRAN for the code of the latest version
#' of the selected package.
#'
#' @template package
#'
#' @return A single string with a version code.
#'
#' @examplesIf !woodendesc:::is_cran_check()
#' wood_cran_latest("versionsort")
#'
#' @family cran
#' @family versions
#' @export
wood_cran_latest <- function(package) {
  assert_param_package(package)

  cran_latest_cache(package)
}

cran_latest_cache <- function(package) {
  with_cache({
    desc <- rlang::try_fetch({
      httr2::request("http://crandb.r-pkg.org") |>
        httr2::req_url_path_append("-", "desc") |>
        httr2::req_url_query(start_key = sprintf("\"%s\"", package), limit = 1) |>
        httr2::req_perform() |>
        httr2::resp_body_json()
    }, httr2_http_404 = function(cnd) {
      rlang::abort(
        sprintf("Can't find package `%1$s` on CRAN.", package, version),
        parent = cnd
      )
    })

    validate_cran_package(package, desc)

    desc[[package]][["version"]]
  }, "latest", "CRAN", package)
}
