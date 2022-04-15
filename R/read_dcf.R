read_dcf_packages <- function(object) {
  if (R_older_than("4.1.0")) {
    # gregexec was introduced in 4.1.0
    matches <- regmatches(
      object,
      gregexpr("Package: (\\S+)", object)
    )
    unique(substring(matches[[1]], first = 10))
  } else {
    matches <- regmatches(
      object,
      gregexec("Package: (\\S+)", object)
    )
    unique(matches[[1]][2, ])
  }
}
