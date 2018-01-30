## Convert biopax to sif

library(here)
library(paxtoolsr)
library(igraph)

#TODO: change to ".dotenv"
ini_filepath <- here(".ini")
config <- ini::read.ini(ini_filepath)
source(here("preprocess_sif.R"))

biopax_filepath <- normalizePath(
    file.path(config$folders$dna_folder, config$folders$biopax_filename)
    )

# convert and write to sif, see http://www.pathwaycommons.org/pc2/formats
sif_filepath <- paste0(biopax_filepath, ".sif_edges") # already normalized
sif_att_filepath <- paste0(biopax_filepath, ".sif_nodes") # already normalized
sif_raw <- toSifnx(
    inputFile = biopax_filepath, outputFile = sif_filepath,
    idType = "hgnc"
    )

write.table(
    sif_raw[["nodes"]], file = sif_att_filepath,
    quote = F, sep = "\t", row.names = F
    )

#TODO: modify "toSifnx" in order to include other paxtools optional arguments
# as "exclude=neighbor_of"

#TODO: collapse "in-complex-with" into a single node

## SIF filtering ---------------------------------------------------------------
s <- preprocess_sifnx(sif_raw)
