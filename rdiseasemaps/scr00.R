# we need the development version of paxtoolsr
# the "reelase" version stored in Bioconductor does not allow for hgnc-based
# attribute extraction

devtools::install_github("BioPAX/paxtoolsr")
require("igraph")
require(".ini")
