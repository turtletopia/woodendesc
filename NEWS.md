# woodendesc (development version)

* Explicitly stated {curl} as a dependency for tests (precisely, for `skip_if_offline()` checks).

# woodendesc 0.2.1

* Fixed GitLab being missing as an option for `wood_packages()`, `wood_dependencies()`, and `wood_versions()`.
* Modified tests to avoid storing whole CRAN package list _twice_.

# woodendesc 0.2.0

* Reimplemented the code, replacing {httr} with {httr2}.
* Updated code to reflect API changes in Bioconductor and R-universe.
* Added support for GitLab.
* Bioconductor data for releases 1.5-1.7 is no longer available.
* Dropped support for older R versions (< 4.1.0) because they increased maintenance complexity significantly.

# woodendesc 0.1.0

* Added a `NEWS.md` file to track changes to the package.
