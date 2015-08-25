.onAttach <- function(libname, pkgname) {
    packageStartupMessage(
        paste("\nThis is ProteomicsAnnotationHubData version",
              packageVersion("ProteomicsAnnotationHubData"), "\n",
            " Read 'ProteomicsAnnotationHubData()' to get started.\n"))

    if (interactive() && .Platform$OS.type == "windows" &&
        .Platform$GUI == "Rgui") {
        Biobase::addVigs2WinMenu("ProteomicsAnnotationHubData")
    }
}
