.First <- function() {
  add_asdf_lib_paths <- function(asdf_dir, r_version) {
    # List of R versions installed by asdf
    asdf_versions <- dir(asdf_dir)

    # Extract minor verions from asdf versions
    target_versions <- asdf_versions[startsWith(asdf_versions, r_minor_version)]

    # Sort the current version first, then the others in ascending order
    sorted_versions <- unique(c(r_version, sort(target_versions)))

    target_libs <- sapply(sorted_versions, function(x) {
      paste0(asdf_dir, "/", x, "/lib/R/library")
    }, USE.NAMES = FALSE)

    Sys.setenv(R_LIBS_USER = target_libs[1])
    .libPaths(target_libs)
  }

  switch_base_lib_paths <- function(r_minor_version) {
    # Extract platform (e.g. x86_64-pc-linux-gnu)
    platform <- Sys.getenv("R_PLATFORM")

    # Create lib path (e.g. ~/.R/x86_64-pc-linux-gnu/4.1)
    path <- paste(Sys.getenv("HOME"), ".R", platform, r_minor_version, sep = "/")

    if (!dir.exists(path)) {
      dir.create(path, recursive = TRUE)
    }

    Sys.setenv(R_LIBS_USER = path)
    .libPaths(path)
  }

  # Current R version (e.g. 4.1.2)
  r_version <- paste(R.version$major, R.version$minor, sep = ".")

  # Current minor version (e.g. 4.1)
  r_minor_version <- paste(R.version$major, sub("\\..*$", "", R.version$minor), sep = ".")

  # asdf installation directory
  asdf_dir <- paste0(Sys.getenv("HOME"), "/.asdf/installs/r")

  # Change .libPaths() based on R.home()
  if (startsWith(R.home(), asdf_dir)) {
    # For asdf, add the same minor version library
    add_asdf_lib_paths(asdf_dir, r_version)
  } else {
    # For base, add R_LIBS_USER to match the version
    switch_base_lib_paths(r_minor_version)
  }

  # Browser settings
  set_default_browser <- function() {
    os <- Sys.info()[["sysname"]]

    if (os == "Windows") return(NULL)
    if (os == "Darwin") return(NULL)

    if (os == "Linux") {
      path <- "/usr/bin/google-chrome-stable"
      if (!file.exists(path)) return(NULL)
    }

    options(browser = path)
  }
  set_default_browser()

  # Set default options
  options(
    repos = "http://cran.rstudio.com/",
    max.print = 1000L,
    width = 120L,
    # help use browser
    # help_type = "html",
    devtools.name = "Shun Asai",
    devtools.desc.author = 'c(person(given = "Shun", family = "Asai",
                              email = "shun.asai@tmkc.co.jp",
                              role = c("aut", "cre")))',
    devtools.desc.license = "MIT + file LICENSE",
    # devtools.install.args = c("--no-lock"),
    usethis.full_name = "Shun Asai",
    blogdown.author	= "Shun Asai",
    blogdown.ext = ".Rmd"
  )
}
