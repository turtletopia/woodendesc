omit_na <- function(object) {
  object[!is.na(object)]
}

read_to_string <- function(...) {
  path <- system.file(..., package = "woodendesc")
  readChar(path, nchar = file.info(path)[["size"]])
}

silence <- function(expr) {
  # suppressMessages silences message()
  # invisible(capture.output()) silences print()
  invisible(capture.output(suppressMessages(expr)))
}

local_fake_library <- function(fake_pkgs = "fakepackage",
                               true_pkgs = "woodendesc",
                               path = "test_dir") {
  lib_dir <- file.path(tempdir(), path)
  withr::local_tempdir(tmpdir = lib_dir)

  for (pkg in fake_pkgs) {
    withr::with_dir(lib_dir, {
      silence(usethis::create_package("fakepackage"))
    })
  }
  for (pkg in true_pkgs) {
    file.copy(from = file.path(.libPaths()[1], pkg),
              to = lib_dir,
              recursive = TRUE)
    withr::with_dir(file.path(lib_dir, pkg), {
      silence(usethis::use_version("major"))
    })
  }

  lib_dir
}
