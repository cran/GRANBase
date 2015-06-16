### R code from vignette source 'GRAN-Overview.Rnw'

###################################################
### code chunk number 1: GRAN-Overview.Rnw:12-13
###################################################
BiocStyle::latex()


###################################################
### code chunk number 2: GRAN-Overview.Rnw:51-53
###################################################
suppressPackageStartupMessages(library(GRANBase))
options(error=traceback)


###################################################
### code chunk number 3: GRAN-Overview.Rnw:56-65
###################################################

testpkgs = list.files(system.file("testpkgs", package = "GRANBase"), full.names = TRUE)
man = PkgManifest(name = basename(testpkgs), 
    url =  testpkgs, type = "local")
repdir = file.path(tempdir(), "repos")
dir.create(repdir)
repo = makeRepo(man, repo_name= "stable", basedir = repdir,
    destination = repdir,
    cores = 1L, install_test = FALSE, check_test = FALSE)


###################################################
### code chunk number 4: GRAN-Overview.Rnw:77-78
###################################################
available.packages(repo, type="source")


###################################################
### code chunk number 5: GRAN-Overview.Rnw:87-88 (eval = FALSE)
###################################################
## repo = makeRepo(file.path(repdir, "stable"), cores=1L)


###################################################
### code chunk number 6: GRAN-Overview.Rnw:93-95 (eval = FALSE)
###################################################
## repo2  = makeRepo(repo, build_pkgs=basename(testpkgs)[1],
##     cores = 1L)


