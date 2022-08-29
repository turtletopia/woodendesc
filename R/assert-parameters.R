assert_param_package <- function(value) {
  assert_string(value, "package")
  assert_length_1(value, "package")
  assert_no_NA(value, "package")
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
