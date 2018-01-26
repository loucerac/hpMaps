## Convert biopax to sif

library(paxtoolsr)
library(igraph)

config <- ini::read.ini(".ini")

biopax_filepath <- normalizePath(
    file.path(config$folders$dna_folder, config$folders$biopax_filename)
)

sif <- toSif(inputFile=biopax_filepath)
# convert to igraph
sif_graph <- graph.edgelist(as.matrix(sif[, c(1, 3)]), directed = T)

# rank-order distribution
degree_in <- degree(sif_graph, mode = "in")
start_nodes <- names(degree_in[degree_in == 0])
degree_out <- degree(sif_graph, mode = "out")
terminal_nodes <- names(degree_out[degree_out == 0])
isolated_nodes <- intersect(start_nodes, terminal_nodes)

cat("Isolated nodes: ", isolated_nodes)
