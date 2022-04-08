wood_tempdir <- function() {
  dir_path <- file.path(tempdir(), "woodendesc")
  if (!dir.exists(dir_path)) {
    dir.create(dir_path)
  }
  dir_path
}

wood_clear_cache <- function() {
  unlink(file.path(wood_tempdir(), "*"))
}
