# SETUP ----
empty_deps <- as_wood_deps(data.frame(
  package = character(),
  version = character(),
  type = character()
))

# TESTS ----
test_param_which_deps(filter_dependencies, object = empty_deps)
