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
