## Convert biopax to sif

library(here)
library(paxtoolsr)
library(igraph)

#TODO: change to ".dotenv"
ini_filepath <- here(".ini")
config <- ini::read.ini(ini_filepath)

biopax_filepath <- normalizePath(
    file.path(config$folders$dna_folder, config$folders$biopax_filename)
    )

# convert and write to sif
sif_filepath <- paste0(biopax_filepath, ".sif") # already normalized
sif_att_filepath <- paste0(biopax_filepath, ".att") # already normalized
sif <- toSifnx(
    inputFile = biopax_filepath, outputFile = sif_filepath,
    idType = "hgnc"
    )

write.table(
    sif[["nodes"]], file = sif_att_filepath,
    quote = F, sep = "\t", row.names = F
    )

#TODO: modify "toSifnx" in order to include other paxtools optional arguments
# as "exclude=neighbor_of"

#TODO: collapse "in-complex-with" into a single node

# convert to igraph
sif_graph <- graph.edgelist(as.matrix(sif[["edges"]][, c(1, 3)]), directed = T)

# rank-order distribution
degree_in <- degree(sif_graph, mode = "in")
start_nodes <- names(degree_in[degree_in == 0])
degree_out <- degree(sif_graph, mode = "out")
terminal_nodes <- names(degree_out[degree_out == 0])
isolated_nodes <- intersect(start_nodes, terminal_nodes)

cat("Isolated nodes: ", isolated_nodes)
