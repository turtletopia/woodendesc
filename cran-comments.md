## R CMD check results

0 errors | 0 warnings | 2 notes

* This is a re-release after the package was archived (some 18 months ago) due to some tests being dependent on an inaccessible URL.
* Old tools were replaced by their newer counterparts (e.g. {httr} -> {httr2}).
* Most examples in the docs shouldn't be run on CRAN as they require internet connection to different services; some even use up a portion of certain API request limits. Obviously, I test them in my local CI/CD pipeline.
