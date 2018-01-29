# Manipulate a SIF file

transform_sif <- function(sif){
    sif <- remove_neighbor_of(sif)
    return(sif)
}

remove_neighbor_of <- function(sif){
    pattern <- "neighbor-of"
    ids2remove <- sif$edges[, "INTERACTION_TYPE"] == pattern
    sif$edges <- sif$edges[-ids2remove, ]
    return(sif)
}

