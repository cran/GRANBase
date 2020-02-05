## ----setup, include = FALSE----------------------------------------------
knitr::opts_chunk$set(collapse = TRUE, comment = "#>")

## ----init_granbase, include = FALSE--------------------------------------
suppressPackageStartupMessages(library(GRANBase))
chooseCRANmirror(ind=1L)
options(error=traceback)

## ----makerepo, echo = TRUE, eval = TRUE, results = "hide", warning = FALSE, message = FALSE, error = TRUE----
testpkgs <- list.files(system.file("testpkgs", package = "GRANBase"),
                       full.names = TRUE)
man <- PkgManifest(name = basename(testpkgs),
                  url = testpkgs, type = "local")
repdir <- file.path(tempdir(), "repos")
if(!file.exists(repdir)) dir.create(repdir)
repo <- makeRepo(man,
                repo_name= "stable",
                basedir = repdir,
                destination = repdir,
                cores = 1L,
                install_test = TRUE,
                check_test = FALSE)

## ----availpkgs, echo = TRUE, eval = TRUE---------------------------------
available.packages(repo, type="source")

## ----makestablerepo, echo = TRUE, eval = FALSE---------------------------
#  repo <- makeRepo(file.path(repdir, "stable"), cores=1L)

## ----makestablerepo2, echo = TRUE, eval = FALSE--------------------------
#  repo2 <- makeRepo(repo,
#                    build_pkgs = basename(testpkgs)[1],
#                    cores = 1L)

## ----clear, echo=TRUE----------------------------------------------------
repo2 <- clear_temp_files(repo, checkout = FALSE, logs = FALSE)
repo2 <- clear_repo(repo2, checkout = TRUE)
repo_results(repo2)

## ----makeagain, echo=TRUE------------------------------------------------
repo3 <- makeRepo(repo, install_test = FALSE, check_test = FALSE)

