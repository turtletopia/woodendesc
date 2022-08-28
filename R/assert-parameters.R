assert_param_package <- function(value) {
  assert_string(value, "package")
  assert_length_1(value, "package")
  assert_no_NA(value, "package")
}
