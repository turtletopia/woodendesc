read_dcf_packages <- function(object) {
  matches <- regmatches(
    object,
    gregexec("Package: (\\S+)", object)
  )
  unique(matches[[1]][2, ])
}
