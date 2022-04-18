read_to_string <- function(...) {
  path <- system.file(..., package = "woodendesc")
  readChar(path, nchar = file.info(path)[["size"]])
}

local_fake_library <- function() {
  lib_dir <- file.path(tempdir(), "test_dir")
  withr::local_tempdir(tmpdir = lib_dir)
  dir.create(file.path(lib_dir, "fakepackage"))
  file.create(file.path(lib_dir, "fakepackage", "DESCRIPTION"))
  lib_dir
}
