
.First <- function() {
  # 現在の R バージョン (4.1.3 など)
  r_version <- paste(R.version$major, R.version$minor, sep = ".")

  # マイナーバージョン (4.1 など)
  r_minor_version <- paste(R.version$major, sub("\\..*$", "", R.version$minor), sep = ".")

  # asdf のインストール場所
  asdf_dir <- paste0(Sys.getenv("HOME"), "/.asdf/installs/R")

  add_asdf_lib_paths <- function() {
    # asdf でインストールした R の全リスト
    asdf_versions <- dir(asdf_dir)

    # 現在のマイナーバージョンだけ抜き出す
    target_versions <- asdf_versions[startsWith(asdf_versions, r_minor_version)]

    # 現在のバージョンを先頭にしつつ、それ以外を昇順に並び替える
    sorted_versions <- unique(c(r_version, sort(target_versions)))

    target_libs <- sapply(sorted_versions, function(x) {
      paste0(asdf_dir, "/", x, "/lib/R/library")
    }, USE.NAMES = FALSE)

    .libPaths(target_libs)
  }

  switch_base_lib_paths <- function() {
    # R.version から major.minor バージョンを抜き出す (4.1 など)
    version <- paste(R.version$major, sub("\\..*$", "", R.version$minor), sep = ".")

    # Platform = x86_64-pc-linux-gnu など
    platform <- Sys.getenv("R_PLATFORM")

    # /home/shun/.R/x86_64-pc-linux-gnu/4.2 など
    path <- paste(Sys.getenv("HOME"), ".R", platform, version, sep = "/")

    if (!dir.exists(path)) {
      dir.create(path, recursive = TRUE)
    }

    Sys.setenv(R_LIBS_USER = path)
    .libPaths(path)
  }

  # R の動作環境に合わせて .libPaths() を変更する
  if (startsWith(R.home(), asdf_dir)) {
    # asdf の場合は、同じマイナーバージョンの library を追加する
    add_asdf_lib_paths()
  } else {
    # base の場合は、バージョンに合わせて R_LIBS_USER を追加する
    switch_base_lib_paths()
  }

  # ブラウザを設定 (ドキュメントなどのリンク用)
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

  # グローバル IP を取得
  get_global_ip <- function() {
    if (Sys.which("curl") == "") {
      return(NA_character_)
    }
    system("curl inet-ip.info", intern = TRUE, ignore.stderr = TRUE)
  }

  # vscode-R の Session Watcher 機能を "self-managed R sessions" に対して有効にする
  # ~/.vscode-R/init.R 経由で以下のファイルを読み込む
  # ~/.vscode/extensions/reditorsupport.r-2.5.3/R/session/init.R
  activate_vsc_session_watcher <- function() {
    if (interactive() && Sys.getenv("RSTUDIO") == "") {
      home <- Sys.getenv(ifelse(.Platform$OS.type == "windows", "USERPROFILE", "HOME"))
      vsc_init_file <- file.path(home, ".vscode-R", "init.R")
      if (file.exists(vsc_init_file)) {
        source(vsc_init_file)
      }
    }
  }
  activate_vsc_session_watcher()

  # Set default options
  options(
    repos = "http://cran.rstudio.com/",
    max.print = 1000L,
    width = 120L,

    devtools.name = "Shun Asai",
    devtools.desc.author = 'c(person(given = "Shun", family = "Asai",
                              email = "syun.asai@gmail.com",
                              role = c("aut", "cre")))',
    devtools.desc.license = "MIT + file LICENSE",
    # devtools.install.args = c("--no-lock"),

    usethis.full_name = "Shun Asai",
    blogdown.author	= "Shun Asai",
    blogdown.ext = ".Rmd",

    # help use browser
    #help_type = "html",

    # ProjectTemplate templates
    ProjectTemplate.templatedir = "~/repos/github/five-dots/ProjectTemplateTemplates"
  )
}
