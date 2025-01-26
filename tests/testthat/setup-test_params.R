test_param_package <- function(expression) {
  expression <- rlang::enquo(expression)

  test_that("`package` must be a character vector", {
    expect_error(
      expression |>
        rlang::call_modify(package = 1) |>
        rlang::eval_tidy(),
      "`package` must be a character vector, not .*"
    )
    expect_error(
      expression |>
        rlang::call_modify(package = list()) |>
        rlang::eval_tidy(),
      "`package` must be a character vector, not .*"
    )
  })

  test_that("`package` must have length 1", {
    expect_error(
      expression |>
        rlang::call_modify(package = letters) |>
        rlang::eval_tidy(),
      sprintf("`package` must have length 1, not %i.", length(letters)),
      fixed = TRUE
    )
  })

  test_that("`package` must not be NA", {
    expect_error(
      expression |>
        rlang::call_modify(package = NA_character_) |>
        rlang::eval_tidy(),
      "`package` must not contain NAs.",
      fixed = TRUE
    )
  })
}

test_param_version <- function(expression) {
  expression <- rlang::enquo(expression)

  test_that("`version` must be a character vector", {
    expect_error(
      expression |>
        rlang::call_modify(version = 1) |>
        rlang::eval_tidy(),
      "`version` must be a character vector, not .*"
    )
    expect_error(
      expression |>
        rlang::call_modify(version = list()) |>
        rlang::eval_tidy(),
      "`version` must be a character vector, not .*"
    )
  })

  test_that("`version` must have length 1", {
    expect_error(
      expression |>
        rlang::call_modify(version = letters) |>
        rlang::eval_tidy(),
      sprintf("`version` must have length 1, not %i.", length(letters)),
      fixed = TRUE
    )
  })

  test_that("`version` must not be NA", {
    expect_error(
      expression |>
        rlang::call_modify(version = NA_character_) |>
        rlang::eval_tidy(),
      "`version` must not contain NAs.",
      fixed = TRUE
    )
  })
}

test_param_repos <- function(expression) {
  expression <- rlang::enquo(expression)

  test_that("`repos` must be a character vector", {
    expect_error(
      expression |>
        rlang::call_modify(repos = 1) |>
        rlang::eval_tidy(),
      "`repos` must be a character vector, not .*"
    )
    expect_error(
      expression |>
        rlang::call_modify(repos = list()) |>
        rlang::eval_tidy(),
      "`repos` must be a character vector, not .*"
    )
  })

  test_that("`repos` must not be empty", {
    expect_error(
      expression |>
        rlang::call_modify(repos = character()) |>
        rlang::eval_tidy(),
      "`repos` must not be empty.",
      fixed = TRUE
    )
  })

  test_that("`repos` must not be NA", {
    expect_error(
      expression |>
        rlang::call_modify(repos = c(letters, NA_character_)) |>
        rlang::eval_tidy(),
      "`repos` must not contain NAs.",
      fixed = TRUE
    )
  })

  test_that("`repos` must be unique", {
    expect_error(
      expression |>
        rlang::call_modify(repos = c("h", letters)) |>
        rlang::eval_tidy(),
      "`repos` must not contain duplicate values.",
      fixed = TRUE
    )
  })
}

test_param_packages <- function(expression) {
  expression <- rlang::enquo(expression)

  test_that("`packages` must be a character vector", {
    expect_error(
      expression |>
        rlang::call_modify(packages = 1) |>
        rlang::eval_tidy(),
      "`packages` must be a character vector, not .*"
    )
    expect_error(
      expression |>
        rlang::call_modify(packages = list()) |>
        rlang::eval_tidy(),
      "`packages` must be a character vector, not .*"
    )
  })

  test_that("`packages` must not be NA", {
    expect_error(
      expression |>
        rlang::call_modify(packages = c(letters, NA_character_)) |>
        rlang::eval_tidy(),
      "`packages` must not contain NAs.",
      fixed = TRUE
    )
  })

  test_that("`packages` must be unique", {
    expect_error(
      expression |>
        rlang::call_modify(packages = c("h", letters)) |>
        rlang::eval_tidy(),
      "`packages` must not contain duplicate values.",
      fixed = TRUE
    )
  })
}

test_param_runiverse <- function(expression) {
  expression <- rlang::enquo(expression)

  test_that("`universe` must be a character vector", {
    expect_error(
      expression |>
        rlang::call_modify(universe = 1) |>
        rlang::eval_tidy(),
      "`universe` must be a character vector, not .*"
    )
    expect_error(
      expression |>
        rlang::call_modify(universe = list()) |>
        rlang::eval_tidy(),
      "`universe` must be a character vector, not .*"
    )
  })

  test_that("`universe` must have length 1", {
    expect_error(
      expression |>
        rlang::call_modify(universe = letters) |>
        rlang::eval_tidy(),
      sprintf("`universe` must have length 1, not %i.", length(letters)),
      fixed = TRUE
    )
  })

  test_that("`universe` must not be NA", {
    expect_error(
      expression |>
        rlang::call_modify(universe = NA_character_) |>
        rlang::eval_tidy(),
      "`universe` must not contain NAs.",
      fixed = TRUE
    )
  })
}

test_param_url_repo <- function(expression) {
  expression <- rlang::enquo(expression)

  test_that("`repository` must be a character vector", {
    expect_error(
      expression |>
        rlang::call_modify(repository = 1) |>
        rlang::eval_tidy(),
      "`repository` must be a character vector, not .*"
    )
    expect_error(
      expression |>
        rlang::call_modify(repository = list()) |>
        rlang::eval_tidy(),
      "`repository` must be a character vector, not .*"
    )
  })

  test_that("`repository` must have length 1", {
    expect_error(
      expression |>
        rlang::call_modify(repository = letters) |>
        rlang::eval_tidy(),
      sprintf("`repository` must have length 1, not %i.", length(letters)),
      fixed = TRUE
    )
  })

  test_that("`repository` must not be NA", {
    expect_error(
      expression |>
        rlang::call_modify(repository = NA_character_) |>
        rlang::eval_tidy(),
      "`repository` must not contain NAs.",
      fixed = TRUE
    )
  })
}

test_param_paths <- function(expression) {
  expression <- rlang::enquo(expression)

  test_that("`paths` must be a character vector", {
    expect_error(
      expression |>
        rlang::call_modify(paths = 1) |>
        rlang::eval_tidy(),
      "`paths` must be a character vector, not .*"
    )
    expect_error(
      expression |>
        rlang::call_modify(paths = list()) |>
        rlang::eval_tidy(),
      "`paths` must be a character vector, not .*"
    )
  })

  test_that("`paths` must not be empty", {
    expect_error(
      expression |>
        rlang::call_modify(paths = character()) |>
        rlang::eval_tidy(),
      "`paths` must not be empty.",
      fixed = TRUE
    )
  })

  test_that("`paths` must not be NA", {
    expect_error(
      expression |>
        rlang::call_modify(paths = c(letters, NA_character_)) |>
        rlang::eval_tidy(),
      "`paths` must not contain NAs.",
      fixed = TRUE
    )
  })

  test_that("`paths` must be unique", {
    expect_error(
      expression |>
        rlang::call_modify(paths = c("h", letters)) |>
        rlang::eval_tidy(),
      "`paths` must not contain duplicate values.",
      fixed = TRUE
    )
  })

  test_that("`paths` cannot contain \"all\" mixed with paths", {
    expect_error(
      expression |>
        rlang::call_modify(paths = c("all", letters)) |>
        rlang::eval_tidy(),
      "`paths` must not contain both \"all\" and paths.",
      fixed = TRUE
    )
  })

  test_that("`paths` cannot contain non-existent directories", {
    expect_error(
      expression |>
        rlang::call_modify(paths = c("inst", "nonexistent")) |>
        rlang::eval_tidy(),
      "`paths` must contain only valid paths.",
      fixed = TRUE
    )
  })
}

test_param_bioc_release <- function(expression) {
  expression <- rlang::enquo(expression)

  test_that("`release` must be a character vector", {
    expect_error(
      expression |>
        rlang::call_modify(release = 1) |>
        rlang::eval_tidy(),
      "`release` must be a character vector, not .*"
    )
    expect_error(
      expression |>
        rlang::call_modify(release = list()) |>
        rlang::eval_tidy(),
      "`release` must be a character vector, not .*"
    )
  })

  test_that("`release` must have length 1", {
    expect_error(
      expression |>
        rlang::call_modify(release = letters) |>
        rlang::eval_tidy(),
      sprintf("`release` must have length 1, not %i.", length(letters)),
      fixed = TRUE
    )
  })

  test_that("`release` must not be NA", {
    expect_error(
      expression |>
        rlang::call_modify(release = NA_character_) |>
        rlang::eval_tidy(),
      "`release` must not contain NAs.",
      fixed = TRUE
    )
  })

  test_that("`release` must be a release code or a keyword", {
    expect_error(
      expression |>
        rlang::call_modify(release = "1.10.0") |>
        rlang::eval_tidy(),
      "`release` must be a valid Bioconductor release code.",
      fixed = TRUE
    )
    expect_error(
      expression |>
        rlang::call_modify(release = "future") |>
        rlang::eval_tidy(),
      "`release` must be a valid Bioconductor release code.",
      fixed = TRUE
    )
  })
}

test_param_gh_user <- function(expression) {
  expression <- rlang::enquo(expression)

  test_that("`user` must be a character vector", {
    expect_error(
      expression |>
        rlang::call_modify(user = 1) |>
        rlang::eval_tidy(),
      "`user` must be a character vector, not .*"
    )
    expect_error(
      expression |>
        rlang::call_modify(user = list()) |>
        rlang::eval_tidy(),
      "`user` must be a character vector, not .*"
    )
  })

  test_that("`user` must have length 1", {
    expect_error(
      expression |>
        rlang::call_modify(user = letters) |>
        rlang::eval_tidy(),
      sprintf("`user` must have length 1, not %i.", length(letters)),
      fixed = TRUE
    )
  })

  test_that("`user` must not be NA", {
    expect_error(
      expression |>
        rlang::call_modify(user = NA_character_) |>
        rlang::eval_tidy(),
      "`user` must not contain NAs.",
      fixed = TRUE
    )
  })
}

test_param_include_forks <- function(expression) {
  expression <- rlang::enquo(expression)

  test_that("`include_forks` must be a logical vector", {
    expect_error(
      expression |>
        rlang::call_modify(include_forks = "TRUE") |>
        rlang::eval_tidy(),
      "`include_forks` must be a logical vector, not .*"
    )
    expect_error(
      expression |>
        rlang::call_modify(include_forks = list()) |>
        rlang::eval_tidy(),
      "`include_forks` must be a logical vector, not .*"
    )
  })

  test_that("`include_forks` must have length 1", {
    expect_error(
      expression |>
        rlang::call_modify(include_forks = c(TRUE, FALSE, FALSE)) |>
        rlang::eval_tidy(),
      "`include_forks` must have length 1, not 3.",
      fixed = TRUE
    )
  })

  test_that("`include_forks` must not be NA", {
    expect_error(
      expression |>
        rlang::call_modify(include_forks = NA) |>
        rlang::eval_tidy(),
      "`include_forks` must not contain NAs.",
      fixed = TRUE
    )
  })
}

test_param_tag <- function(expression) {
  expression <- rlang::enquo(expression)

  test_that("`tag` must be a character vector", {
    expect_error(
      expression |>
        rlang::call_modify(tag = 1) |>
        rlang::eval_tidy(),
      "`tag` must be a character vector, not .*"
    )
    expect_error(
      expression |>
        rlang::call_modify(tag = list()) |>
        rlang::eval_tidy(),
      "`tag` must be a character vector, not .*"
    )
  })

  test_that("`tag` must have length 1", {
    expect_error(
      expression |>
        rlang::call_modify(tag = letters) |>
        rlang::eval_tidy(),
      sprintf("`tag` must have length 1, not %i.", length(letters)),
      fixed = TRUE
    )
  })

  test_that("`tag` must not be NA", {
    expect_error(
      expression |>
        rlang::call_modify(tag = NA_character_) |>
        rlang::eval_tidy(),
      "`tag` must not contain NAs.",
      fixed = TRUE
    )
  })
}

test_param_which_deps <- function(expression) {
  expression <- rlang::enquo(expression)

  test_that("`which` must be a character vector", {
    expect_error(
      expression |>
        rlang::call_modify(which = 1) |>
        rlang::eval_tidy(),
      "`which` must be a character vector, not .*"
    )
    expect_error(
      expression |>
        rlang::call_modify(which = list()) |>
        rlang::eval_tidy(),
      "`which` must be a character vector, not .*"
    )
  })

  test_that("`which` must not be NA", {
    expect_error(
      expression |>
        rlang::call_modify(which = c(letters, NA_character_)) |>
        rlang::eval_tidy(),
      "`which` must not contain NAs.",
      fixed = TRUE
    )
  })

  test_that("`which` must be unique", {
    expect_error(
      expression |>
        rlang::call_modify(which = c("h", letters)) |>
        rlang::eval_tidy(),
      "`which` must not contain duplicate values.",
      fixed = TRUE
    )
  })

  test_that("`which` must not contain multiple keywords", {
    expect_error(
      expression |>
        rlang::call_modify(which = c("most", "strong")) |>
        rlang::eval_tidy(),
      "`which` must not contain multiple keywords.",
      fixed = TRUE
    )
  })

  test_that("`which` must be a subset of legal values", {
    expect_error(
      expression |>
        rlang::call_modify(which = c("Depends", "Imports", "Cracks")) |>
        rlang::eval_tidy(),
      "`which` must contain valid dependency types.",
      fixed = TRUE
    )
  })

  test_that("`which` must not mix dep types and keywords", {
    expect_error(
      expression |>
        rlang::call_modify(which = c("Depends", "strong")) |>
        rlang::eval_tidy(),
      "`which` must not mix dependency types and keywords.",
      fixed = TRUE
    )
  })
}
