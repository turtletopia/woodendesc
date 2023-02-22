test_param_package <- function(tested_function, ...) {
  test_that("`package` must be a character vector", {
    expect_error(
      tested_function(package = 1, ...),
      "`package` must be a character vector, not .*"
    )
    expect_error(
      tested_function(package = list(), ...),
      "`package` must be a character vector, not .*"
    )
  })

  test_that("`package` must have length 1", {
    expect_error(
      tested_function(package = letters, ...),
      sprintf("`package` must have length 1, not %i.", length(letters)),
      fixed = TRUE
    )
  })

  test_that("`package` must not be NA", {
    expect_error(
      tested_function(package = NA_character_, ...),
      "`package` must not contain NAs.",
      fixed = TRUE
    )
  })
}

test_param_version <- function(tested_function, ...) {
  test_that("`version` must be a character vector", {
    expect_error(
      tested_function(version = 1, ...),
      "`version` must be a character vector, not .*"
    )
    expect_error(
      tested_function(version = list(), ...),
      "`version` must be a character vector, not .*"
    )
  })

  test_that("`version` must have length 1", {
    expect_error(
      tested_function(version = letters, ...),
      sprintf("`version` must have length 1, not %i.", length(letters)),
      fixed = TRUE
    )
  })

  test_that("`version` must not be NA", {
    expect_error(
      tested_function(version = NA_character_, ...),
      "`version` must not contain NAs.",
      fixed = TRUE
    )
  })
}

test_param_repos <- function(tested_function, ...) {
  test_that("`repos` must be a character vector", {
    expect_error(
      tested_function(repos = 1, ...),
      "`repos` must be a character vector, not .*"
    )
    expect_error(
      tested_function(repos = list(), ...),
      "`repos` must be a character vector, not .*"
    )
  })

  test_that("`repos` must not be empty", {
    expect_error(
      tested_function(repos = character(), ...),
      "`repos` must not be empty.",
      fixed = TRUE
    )
  })

  test_that("`repos` must not be NA", {
    expect_error(
      tested_function(repos = c(letters, NA_character_), ...),
      "`repos` must not contain NAs.",
      fixed = TRUE
    )
  })

  test_that("`repos` must be unique", {
    expect_error(
      tested_function(repos = c("h", letters), ...),
      "`repos` must not contain duplicate values.",
      fixed = TRUE
    )
  })
}

test_param_packages <- function(tested_function, ...) {
  test_that("`packages` must be a character vector", {
    expect_error(
      tested_function(packages = 1, ...),
      "`packages` must be a character vector, not .*"
    )
    expect_error(
      tested_function(packages = list(), ...),
      "`packages` must be a character vector, not .*"
    )
  })

  test_that("`packages` must not be NA", {
    expect_error(
      tested_function(packages = c(letters, NA_character_), ...),
      "`packages` must not contain NAs.",
      fixed = TRUE
    )
  })

  test_that("`packages` must be unique", {
    expect_error(
      tested_function(packages = c("h", letters), ...),
      "`packages` must not contain duplicate values.",
      fixed = TRUE
    )
  })
}

test_param_runiverse <- function(tested_function, ...) {
  test_that("`universe` must be a character vector", {
    expect_error(
      tested_function(universe = 1, ...),
      "`universe` must be a character vector, not .*"
    )
    expect_error(
      tested_function(universe = list(), ...),
      "`universe` must be a character vector, not .*"
    )
  })

  test_that("`universe` must have length 1", {
    expect_error(
      tested_function(universe = letters, ...),
      sprintf("`universe` must have length 1, not %i.", length(letters)),
      fixed = TRUE
    )
  })

  test_that("`universe` must not be NA", {
    expect_error(
      tested_function(universe = NA_character_, ...),
      "`universe` must not contain NAs.",
      fixed = TRUE
    )
  })
}

test_param_url_repo <- function(tested_function, ...) {
  test_that("`repository` must be a character vector", {
    expect_error(
      tested_function(repository = 1, ...),
      "`repository` must be a character vector, not .*"
    )
    expect_error(
      tested_function(repository = list(), ...),
      "`repository` must be a character vector, not .*"
    )
  })

  test_that("`repository` must have length 1", {
    expect_error(
      tested_function(repository = letters, ...),
      sprintf("`repository` must have length 1, not %i.", length(letters)),
      fixed = TRUE
    )
  })

  test_that("`repository` must not be NA", {
    expect_error(
      tested_function(repository = NA_character_, ...),
      "`repository` must not contain NAs.",
      fixed = TRUE
    )
  })
}

test_param_paths <- function(tested_function, ...) {
  test_that("`paths` must be a character vector", {
    expect_error(
      tested_function(paths = 1, ...),
      "`paths` must be a character vector, not .*"
    )
    expect_error(
      tested_function(paths = list(), ...),
      "`paths` must be a character vector, not .*"
    )
  })

  test_that("`paths` must not be empty", {
    expect_error(
      tested_function(paths = character(), ...),
      "`paths` must not be empty.",
      fixed = TRUE
    )
  })

  test_that("`paths` must not be NA", {
    expect_error(
      tested_function(paths = c(letters, NA_character_), ...),
      "`paths` must not contain NAs.",
      fixed = TRUE
    )
  })

  test_that("`paths` must be unique", {
    expect_error(
      tested_function(paths = c("h", letters), ...),
      "`paths` must not contain duplicate values.",
      fixed = TRUE
    )
  })

  test_that("`paths` cannot contain \"all\" mixed with paths", {
    expect_error(
      tested_function(paths = c("all", letters), ...),
      "`paths` must not contain both \"all\" and paths.",
      fixed = TRUE
    )
  })

  test_that("`paths` cannot contain non-existent directories", {
    expect_error(
      tested_function(paths = c("inst", "nonexistent"), ...),
      "`paths` must contain only valid paths.",
      fixed = TRUE
    )
  })
}

test_param_bioc_release <- function(tested_function, ...) {
  test_that("`release` must be a character vector", {
    expect_error(
      tested_function(release = 1, ...),
      "`release` must be a character vector, not .*"
    )
    expect_error(
      tested_function(release = list(), ...),
      "`release` must be a character vector, not .*"
    )
  })

  test_that("`release` must have length 1", {
    expect_error(
      tested_function(release = letters, ...),
      sprintf("`release` must have length 1, not %i.", length(letters)),
      fixed = TRUE
    )
  })

  test_that("`release` must not be NA", {
    expect_error(
      tested_function(release = NA_character_, ...),
      "`release` must not contain NAs.",
      fixed = TRUE
    )
  })

  test_that("`release` must be a release code or a keyword", {
    expect_error(
      tested_function(release = "1.10.0", ...),
      "`release` must be a valid Bioconductor release code.",
      fixed = TRUE
    )
    expect_error(
      tested_function(release = "future", ...),
      "`release` must be a valid Bioconductor release code.",
      fixed = TRUE
    )
  })
}

test_param_gh_user <- function(tested_function, ...) {
  test_that("`user` must be a character vector", {
    expect_error(
      tested_function(user = 1, ...),
      "`user` must be a character vector, not .*"
    )
    expect_error(
      tested_function(user = list(), ...),
      "`user` must be a character vector, not .*"
    )
  })

  test_that("`user` must have length 1", {
    expect_error(
      tested_function(user = letters, ...),
      sprintf("`user` must have length 1, not %i.", length(letters)),
      fixed = TRUE
    )
  })

  test_that("`user` must not be NA", {
    expect_error(
      tested_function(user = NA_character_, ...),
      "`user` must not contain NAs.",
      fixed = TRUE
    )
  })
}

test_param_include_forks <- function(tested_function, ...) {
  test_that("`include_forks` must be a logical vector", {
    expect_error(
      tested_function(include_forks = "TRUE", ...),
      "`include_forks` must be a logical vector, not .*"
    )
    expect_error(
      tested_function(include_forks = list(), ...),
      "`include_forks` must be a logical vector, not .*"
    )
  })

  test_that("`include_forks` must have length 1", {
    expect_error(
      tested_function(include_forks = c(TRUE, FALSE, FALSE), ...),
      "`include_forks` must have length 1, not 3.",
      fixed = TRUE
    )
  })

  test_that("`include_forks` must not be NA", {
    expect_error(
      tested_function(include_forks = NA, ...),
      "`include_forks` must not contain NAs.",
      fixed = TRUE
    )
  })
}

test_param_tag <- function(tested_function, ...) {
  test_that("`tag` must be a character vector", {
    expect_error(
      tested_function(tag = 1, ...),
      "`tag` must be a character vector, not .*"
    )
    expect_error(
      tested_function(tag = list(), ...),
      "`tag` must be a character vector, not .*"
    )
  })

  test_that("`tag` must have length 1", {
    expect_error(
      tested_function(tag = letters, ...),
      sprintf("`tag` must have length 1, not %i.", length(letters)),
      fixed = TRUE
    )
  })

  test_that("`tag` must not be NA", {
    expect_error(
      tested_function(tag = NA_character_, ...),
      "`tag` must not contain NAs.",
      fixed = TRUE
    )
  })
}

test_param_which_deps <- function(tested_function, ...) {
  test_that("`which` must be a character vector", {
    expect_error(
      tested_function(which = 1, ...),
      "`which` must be a character vector, not .*"
    )
    expect_error(
      tested_function(which = list(), ...),
      "`which` must be a character vector, not .*"
    )
  })

  test_that("`which` must not be NA", {
    expect_error(
      tested_function(which = c(letters, NA_character_), ...),
      "`which` must not contain NAs.",
      fixed = TRUE
    )
  })

  test_that("`which` must be unique", {
    expect_error(
      tested_function(which = c("h", letters), ...),
      "`which` must not contain duplicate values.",
      fixed = TRUE
    )
  })

  test_that("`which` must not contain multiple keywords", {
    expect_error(
      tested_function(which = c("most", "strong"), ...),
      "`which` must not contain multiple keywords.",
      fixed = TRUE
    )
  })

  test_that("`which` must be a subset of legal values", {
    expect_error(
      tested_function(which = c("Depends", "Imports", "Cracks"), ...),
      "`which` must contain valid dependency types.",
      fixed = TRUE
    )
  })

  test_that("`which` must not mix dep types and keywords", {
    expect_error(
      tested_function(which = c("Depends", "strong"), ...),
      "`which` must not mix dependency types and keywords.",
      fixed = TRUE
    )
  })
}
