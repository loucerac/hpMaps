## Convert biopax to sif

library(paxtoolsr)
library(igraph)

config <- ini::read.ini(".ini")

biopax_filepath <- normalizePath(
    file.path(config$folders$dna_folder, config$folders$biopax_filename)
)

# convert to sif
sif <- toSif(inputFile = biopax_filepath)

# write SIF
sif_file_path <- paste0(biopax_filepath, ".sif") # already normalized
write.table(sif, file = sif_file_path, sep = "\t", row.names = F, quote = F)

# convert to igraph
sif_graph <- graph.edgelist(as.matrix(sif[, c(1, 3)]), directed = T)

# rank-order distribution
degree_in <- degree(sif_graph, mode = "in")
start_nodes <- names(degree_in[degree_in == 0])
degree_out <- degree(sif_graph, mode = "out")
terminal_nodes <- names(degree_out[degree_out == 0])
isolated_nodes <- intersect(start_nodes, terminal_nodes)

cat("Isolated nodes: ", isolated_nodes)
