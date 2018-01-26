library(paxtoolsr)
library(rJava)

to_sif <- function(inputFile, outputFile = NULL)
{
    inputFile <- checkInputFile(inputFile)
    outputFile <- checkOutputFile(outputFile)
    command <- "toSif exclude=neighbor_of"
    commandJStr <- .jnew("java/lang/String", command)
    inputJStr <- .jnew("java/lang/String", inputFile)
    outputJStr <- .jnew("java/lang/String", outputFile)
    argsList <- list(commandJStr, inputJStr, outputJStr)
    .jcall("org/biopax/paxtools/PaxtoolsMain", "V", command,
           .jarray(argsList, "java/lang/String"))
    .jcheck()
    results <- readSif(outputFile)
    return(results)
}
