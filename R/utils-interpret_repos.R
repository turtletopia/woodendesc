interpret_repos <- function(repos, context) {
  repos <- tolower(repos)
  lapply(repos, function(repo) {
    if (grepl("^cran$", repo, perl = TRUE)) {
      return(query_maker("cran", context))
    }
    if (grepl("^core$", repo, perl = TRUE)) {
      return(query_maker("core", context))
    }
    if (grepl("^bioc", repo, perl = TRUE)) {
      return(interpret_bioc(repo, context))
    }
    if (grepl("^local", repo, perl = TRUE)) {
      return(interpret_local(repo, context))
    }
    if (grepl("^runiverse", repo, perl = TRUE)) {
      return(interpret_runiverse(repo, context))
    }
    query_maker("url", context, repository = repo)
  })
}

interpret_bioc <- function(repo, context) {
  ret <- query_maker("bioc", context)
  param <- regmatches(repo, regexpr("(?<=bioc@).+", repo, perl = TRUE))
  add_parameter(ret, param, "release")
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

interpret_runiverse <- function(repo, context) {
  ret <- query_maker("runiverse", context)
  param <- regmatches(repo, regexpr("(?<=runiverse@).+", repo, perl = TRUE))
  add_parameter(ret, param, "universe")
}

#' @importFrom utils getFromNamespace
find_function <- function(type, context) {
  func <- NULL

  try({
    func <- getFromNamespace(paste("wood", type, context, sep = "_"), "woodendesc")
  }, silent = TRUE)

  if (is.null(func)) {
    # Pluralize context
    context <- paste0(context, "s")
    func <- getFromNamespace(paste("wood", type, context, sep = "_"), "woodendesc")
  }

  func
}
