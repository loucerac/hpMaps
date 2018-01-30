## Auxiliar functions

.gen_id_from_sequence <- function(n){
    ids <- sprintf("complex_%0*d", nchar(n), 1:n)
    return(ids)
}
