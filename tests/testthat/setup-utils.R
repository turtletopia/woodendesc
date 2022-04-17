read_to_string <- function(...) {
  path <- system.file(..., package = "woodendesc")
  readChar(path, nchar = file.info(path)[["size"]])
}
