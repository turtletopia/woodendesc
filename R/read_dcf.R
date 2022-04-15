read_dcf_packages <- function(object) {
  match <- gregexec("Package: ([^\n]+)\\n", object)[[1]]
  start <- match[2, ]
  end <- start + attr(match, "match.length", exact = TRUE)[2, ] - 1
  unique(substring(object, start, end))
}
