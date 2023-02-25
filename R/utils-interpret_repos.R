interpret_repos <- function(repos, context) {
  lapply(repos, function(repo) {
    l_repo <- tolower(repo)
    if (grepl("^cran$", l_repo, perl = TRUE)) {
      return(query_maker("cran", context))
    }
    if (grepl("^core$", l_repo, perl = TRUE)) {
      return(query_maker("core", context))
    }
    if (grepl("^bioc", l_repo, perl = TRUE)) {
      return(interpret_bioc(l_repo, context))
    }
    if (grepl("^github", l_repo, perl = TRUE)) {
      return(interpret_github(repo, context))
    }
    if (grepl("^runiverse", l_repo, perl = TRUE)) {
      return(interpret_runiverse(l_repo, context))
    }
    if (grepl("^local", l_repo, perl = TRUE)) {
      return(interpret_local(l_repo, context))
    }
    query_maker("url", context, repository = repo)
  })
}

interpret_bioc <- function(repo, context) {
  ret <- query_maker("bioc", context)
  param <- regmatches(repo, regexpr("(?<=bioc@).+", repo, perl = TRUE))
  add_parameter(ret, param, "release")
}

interpret_github <- function(repo, context) {
  ret <- query_maker("github", context)
  param <- regmatches(repo, regexpr("(?<=github/).+", repo, ignore.case = TRUE, perl = TRUE))
  add_parameter(ret, param, "user")
}

interpret_runiverse <- function(repo, context) {
  ret <- query_maker("runiverse", context)
  param <- regmatches(repo, regexpr("(?<=runiverse@).+", repo, perl = TRUE))
  add_parameter(ret, param, "universe")
}

interpret_local <- function(repo, context) {
  if (grepl("local#all", repo, fixed = TRUE)) {
    return(query_maker("local", context, paths = "all"))
  }

  ret <- query_maker("local", context)
  param <- regmatches(repo, regexpr("(?<=local#)\\d+", repo, perl = TRUE))
  add_parameter(ret, param, "paths",
                function(index) .libPaths()[as.integer(index)])
}

find_function <- function(type, context) {
  switch(
    type,
    cran = switch(
      context,
      packages = wood_cran_packages,
      version = wood_cran_versions,
      dependencies = wood_cran_dependencies
    ),
    bioc = switch(
      context,
      packages = wood_bioc_packages,
      version = wood_bioc_version,
      dependencies = wood_bioc_dependencies
    ),
    github = switch(
      context,
      packages = wood_github_packages,
      version = wood_github_versions,
      dependencies = wood_github_dependencies
    ),
    runiverse = switch(
      context,
      packages = wood_runiverse_packages,
      version = wood_runiverse_version,
      dependencies = wood_runiverse_dependencies
    ),
    url = switch(
      context,
      packages = wood_url_packages,
      version = wood_url_version,
      dependencies = wood_url_dependencies
    ),
    local = switch(
      context,
      packages = wood_local_packages,
      version = wood_local_versions,
      dependencies = wood_local_dependencies
    ),
    core = switch(
      context,
      packages = wood_core_packages,
      version = wood_core_version,
      dependencies = wood_core_dependencies
    )
  )
}
