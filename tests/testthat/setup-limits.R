over_gh_limit <- function(num_necessary = 1) {
  limit <- httr2::request("https://api.github.com") |>
    httr2::req_url_path_append("rate_limit") |>
    httr2::req_perform() |>
    httr2::resp_body_json()
  limit$resources$core$remaining < num_necessary
}
