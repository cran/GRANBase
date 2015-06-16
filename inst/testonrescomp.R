library(GRANBase)
repo = loadRepo("/gne/research/apps/gran/2014-04-09/x86_64-linux-2.6-rhel6/GRANRepos/devel/repo.R")

pkg = "igis"

scm_auths = list(resscm = c("resgran", "resgran"),
    bioconductor = c("readonly", "readonly"))

res = makeRepo(repo, build_pkgs = pkg, scm_auths = scm_auths, cores = 3L)


sortvers = function(allvers) {
    done = TRUE
    ord = seq(along= allvers)
    i =  1
    while(TRUE) {
        if(i == length(allvers)) {
            if(done)
                return(ord)
            i = 1
            done = TRUE
            print(ord)
        }
        val1 = allvers[ord[i]]
        val2 = allvers[ord[i+1]]
        if(compareVersion(val1, val2) == 1){
            tmp = ord[i]
            ord[i] = ord[i+1]
            ord[i+1] = tmp
            done = FALSE
        }
        i = i + 1
    }
}
        
fils3 = tapply( seq(along = fils2), pkgnames, function(x, allfils, allvers) {
    myfils = allfils[x]
    ord = sortvers(allvers[x])
    myfils[ord]
}, allfils = fils2, allvers = vers)
        

gztests = mapply( function(x, nm) {
    fil = x[length(x)]
    dir = tempdir()
    desc = tryCatch(untar(fil, files = paste(nm, "DESCRIPTION", sep="/"), exdir=dir, compressed=TRUE), error = function(e) e)
    if(is(desc, "error"))
        return(desc())
    
    tryCatch(read.dcf(file.path(dir, paste(nm,"DESCRIPTION", sep="/"))), error = function(e) e)
}, x = fils3, nm = names(fils3))
    
fils4 = lapply(fils3, function(x) x[file.exists(x)])

lapply(fils4, function(x) {
    x = x[-length(x)]
    if(!file.exists("/gne/research/apps/gran/2014-04-09/x86_64-linux-2.6-rhel6/tmprepo/devel/Archive"))
        dir.create("/gne/research/apps/gran/2014-04-09/x86_64-linux-2.6-rhel6/tmprepo/devel/Archive")
    sapply(x,
           function(y) file.rename(y to = file.path("/gne/research/apps/gran/2014-04-09/x86_64-linux-2.6-rhel6/tmprepo/devel/Archive", basename(y)) ))
})
