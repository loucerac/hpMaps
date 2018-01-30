## Convert biopax to sif

library(here)
library(rBiopaxParser)
library(NetPathMiner)
library(igraph)

#TODO: change to ".dotenv"
ini_filepath <- here(".ini")
config <- ini::read.ini(ini_filepath)

biopax_filepath <- normalizePath(
    file.path(config$folders$dna_folder, config$folders$biopax_filename)
)

biopax = readBiopax(biopax_filepath)
g <- biopax2igraph(
    biopax,
    parse.as = c("signaling"),
    expand.complexes = FALSE, inc.sm.molecules = FALSE,
    verbose = TRUE
    )

pathway_ids <- listPathways(biopax)

p <- pathway2RegulatoryGraph(
    biopax,
    pathway_ids$id[1],
    expandSubpathways = TRUE,
    splitComplexMolecules = TRUE,
    useIDasNodenames = FALSE,
    verbose = TRUE
    )

plotRegulatoryGraph(p)

listPathwayComponents(biopax, id = pathway_ids$id[2])
