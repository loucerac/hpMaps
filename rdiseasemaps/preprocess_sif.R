## SIF preprocessing, requires and extended SIF

here()
source(here("aux_functions.R"))

preprocess_sifnx <- function(sif){
    graphi <- .to_igraph(sif)
    graphi <- .remove_neighbor_of(graphi)
    graphi <- .remove_small_molecules(graphi)
}

.to_igraph <- function(sif){
    node_df <- sif$nodes
    edge_df <- sif$edges
    colnames(node_df)[colnames(node_df) == 'PARTICIPANT'] <- 'name'
    colnames(edge_df)[colnames(edge_df) == 'PARTICIPANT_A'] <- 'from'
    colnames(edge_df)[colnames(edge_df) == 'PARTICIPANT_B'] <- 'to'
    edge_df <- edge_df[, c(1, 3, 2, 4, 5, 6)]

    graph_from_data_frame(edge_df, directed = TRUE, vertices = node_df)
}

.remove_neighbor_of <- function(graph_in){
    pattern <- "neighbor-of"

    delete.edges(graph_in, which(E(graph_in)$INTERACTION_TYPE == pattern))
}

.remove_small_molecules <- function(graph_in){
    pattern <- "SmallMoleculeReference"

    delete.vertices(graph_in, which(V(graph_in)$PARTICIPANT_TYPE == pattern))
}

.collapse_complexes <- function(graph_in){
    complex_list <- .get_complex_list(graph_in)
}

.get_complex_list <- function(graph_in){
    pattern <- "in-complex-with"
    in_complex_ids <- which(V(graph_in)$PARTICIPANT_TYPE == pattern)

}
