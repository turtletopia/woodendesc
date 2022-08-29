assert_param_package <- function(value) {
  assert_string(value, "package")
  assert_length_1(value, "package")
  assert_no_NA(value, "package")
}

assert_param_version <- function(value) {
  assert_string(value, "version")
  assert_length_1(value, "version")
  assert_no_NA(value, "version")
}

assert_param_runiverse <- function(value) {
  assert_string(value, "universe")
  assert_length_1(value, "universe")
  assert_no_NA(value, "universe")
}

assert_param_paths <- function(value) {
  assert_string(value, "paths")
  assert_not_empty(value, "paths")
  assert_no_NA(value, "paths")
  assert_all_or_paths(value, "paths")
}

assert_param_bioc_release <- function(value) {
  assert_string(value, "release")
  assert_length_1(value, "release")
  assert_no_NA(value, "release")
  assert_keyword_or_release(value, "release")
}

assert_param_url_repo <- function(value) {
  assert_string(value, "repository")
  assert_length_1(value, "repository")
  assert_no_NA(value, "repository")
}
