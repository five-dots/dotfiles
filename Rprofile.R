
.switchLibPath <- function() {
  version <- paste(R.version$major,
                   sub("\\..*$", "", R.version$minor),
                   sep=".")
  if (Sys.info()["sysname"] == "Windows") {
    path <- paste0("~/Dropbox/R/win-library/", version)
  } else {
    path <- paste0("~/Dropbox/R/x86_64-pc-linux-gnu-library/", version)
  }
  Sys.setenv(R_LIBS_USER = path)
  .libPaths(path)
}

.getGlobalIp <- function() {
  system("curl inet-ip.info", intern = TRUE, ignore.stderr = TRUE)
}

.First <- function() {
  # Change R_LIBS_USER based on OS and R version
  .switchLibPath()

  # Set default options
  options(
    ## repos = "http://cran.rstudio.com/",
    ## stringsAsFactors = FALSE,
    max.print = 1000,
    devtools.name = "Shun Asai",
    devtools.desc.author = 'c(person(given = "Shun", family = "Asai",
                              email = "syun.asai@gmail.com",
                              role = c("aut", "cre")))',
    devtools.desc.license = "MIT + file LICENSE",
    ## devtools.install.args = c("--no-lock"),
    usethis.full_name = "Shun Asai",
    blogdown.author	= "Shun Asai",
	  blogdown.ext = ".Rmd",
    ## help use browser
    help_type = "html",
    ## ProjectTemplate templates
    ProjectTemplate.templatedir = "~/Dropbox/repos/github/five-dots/ProjectTemplateTemplates"
  )

  ## Load libraries
  ## suppressMessages(library(pacman))
  ## p_load(stats) # Must be loaded before dplyr
  ## p_load(
    ## Backtest,
    ## MarketData,
    ## Utils,
    ## devtools,
    ## fs,
    ## glue,
    ## hms,
    ## lubridate,
    ## magrittr,
    ## rlang,
    ## tidyverse # ggplot2, dplyr, tidyr, readr, purrr, tibble, stringr, forcat
  ## )
}

## Shared vars
.nodename <- Sys.info()["nodename"]
.home     <- Sys.getenv()["HOME"]
.dropbox  <- paste(.home, "Dropbox", sep = "/")
.github   <- paste(.dropbox, "repos/github/five-dots", sep = "/")
.mkt_data <- paste(.dropbox, "market_data", sep = "/")

## Load security info
source(paste0(.home, "/.secret.R"))

## Store settings
settings <- as.environment(list())
settings$quandl_key <- .quandl_key
settings$polygon_key <- .polygon_key

### MSSQL DB settings
## From home
if (.nodename == "DESK1") {
  .mssql_server <- paste0("127.0.0.1", ";")
## From GCP instance
} else if (.nodename == "remoter01") {
  .mssql_server <- paste0(.home_gip, ";")
## From notebook
} else {
  ## From home
  ## if (.getGlobalIp() == .home_gip) {
  ##   .mssql_server <- paste0(.desk1_lip, ";")
  ## ## From outside
  ## } else {
  ##   .mssql_server <- paste0(.home_gip, ";")
  ## }
  .mssql_server <- paste0(.home_gip, ";")
}

## Switch driver based on OS
if (startsWith(.home, "/")) {
  .mssql_driver <- "ODBC Driver 17 for SQL Server;"
} else {
  .mssql_driver <- "SQL Server;"
}

.masql_base <- paste0("driver=", .mssql_driver, "server=", .mssql_server,
                      "Uid=", .mssql_user, "Pwd=", .mssql_passwd, "Database=")

settings$strategy.db <- paste0(.masql_base, "strategy;")

### SQLite DB settings
settings$sharadar.sqli   <- paste0(.home, "/Dropbox/sqlite/sharadar.sqlite3")
settings$quotemedia.sqli <- paste0(.home, "/Dropbox/sqlite/quotemedia.sqlite3")
settings$strategy.sqli   <- paste0(.home, "/Dropbox/sqlite/strategy.sqlite3")
settings$trading.sqli    <- paste0(.home, "/Dropbox/sqlite/trading.sqlite3")

## Plus DB
.plus_date <- "2019-01-11"
settings$sharadar_plus.sqli <- paste0(.home,
                                      "/Dropbox/sqlite/sharadar_plus_",
                                      .plus_date,
                                      ".sqlite3")

settings$sharadar_plus_20181214.sqli <- paste0(
  .home, "/Dropbox/sqlite/sharadar_plus_2018-12-14.sqlite3")

### IB setings
settings$ib_tws_ports     <- .ib_tws_ports
settings$ib_account_pers  <- .ib_account_pers
settings$ib_account_corp  <- .ib_account_corp
settings$ib_account_demo  <- .ib_account_demo
settings$ib_fq_token_pers <- .fq_token_pers
settings$ib_fq_token_corp <- .fq_token_corp

### Google setings
settings$gmail_address <- .gmail_address
settings$gmail_app_pwd <- .gmail_app_pwd

### Github personal access token
settings$github_pat <- .github_pat

