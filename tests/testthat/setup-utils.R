read_to_string <- function(...) {
  path <- system.file(..., package = "woodendesc")
  readChar(path, nchar = file.info(path)[["size"]])
}

local_fake_library <- function(fake_pkgs = "fakepackage") {
  lib_dir <- file.path(tempdir(), "test_dir")
  withr::local_tempdir(tmpdir = lib_dir)

  for (pkg in fake_pkgs) {
    dir.create(file.path(lib_dir, pkg))
    file.create(file.path(lib_dir, pkg, "DESCRIPTION"))
  }

  lib_dir
}
