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

assert_param_repos <- function(value) {
  assert_string(value, "repos")
  assert_not_empty(value, "repos")
  assert_no_NA(value, "repos")
  assert_unique(value, "repos")
}

assert_param_packages <- function(value) {
  assert_string(value, "packages")
  assert_no_NA(value, "packages")
  assert_unique(value, "packages")
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
  assert_unique(value, "paths")
  assert_all_or_paths(value, "paths")
  assert_dirs_exist(value, "paths")
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

assert_param_gh_user <- function(value) {
  assert_string(value, "user")
  assert_length_1(value, "user")
  assert_no_NA(value, "user")
}

assert_param_tag <- function(value) {
  assert_string(value, "tag")
  assert_length_1(value, "tag")
  assert_no_NA(value, "tag")
}

assert_param_include_forks <- function(value) {
  assert_logical(value, "include_forks")
  assert_length_1(value, "include_forks")
  assert_no_NA(value, "include_forks")
}

assert_param_which_deps <- function(value) {
  assert_string(value, "which")
  assert_no_NA(value, "which")
  assert_unique(value, "which")
  assert_keyword_single(value, "which", c("all", "most", "strong"))
  assert_keyword_or_dep_type(value, "which")
}
