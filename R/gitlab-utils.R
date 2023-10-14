guess_default_branch_gl <- function(user, package, ...) {
  guess_default_branch(
    "gitlab", user, package, ..., branches = c("master", "main", "dev", "prod")
  )
}
