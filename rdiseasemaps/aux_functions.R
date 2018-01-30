## Auxiliar functions

gen_id_from_sequence <- function(n){
    ids <- sprintf("complex_%0*d", nchar(n), 1:n)
    return(ids)
}

detachAllPackages <- function() {
    # See: https://stackoverflow.com/questions/7505547/detach-all-packages-while-working-in-r

    basic.packages <- c("package:stats","package:graphics","package:grDevices","package:utils","package:datasets","package:methods","package:base")
    condition <- ifelse(unlist(gregexpr("package:",search())) == 1, TRUE, FALSE)
    package.list <- search()[condition]

    package.list <- setdiff(package.list,basic.packages)

    if (length(package.list) > 0) {
        for (package in package.list) detach(package, character.only = TRUE)
    }

}
