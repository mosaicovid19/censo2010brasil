#' @title FUNCTION_TITLE
#' @description FUNCTION_DESCRIPTION
#' @param base PARAM_DESCRIPTION
#' @param estados PARAM_DESCRIPTION, Default: NULL
#' @param censo_dir PARAM_DESCRIPTION, Default: '~/Downloads/Censo2010'
#' @param cores PARAM_DESCRIPTION, Default: 1
#' @return OUTPUT_DESCRIPTION
#' @details DETAILS
#' @examples
#' \dontrun{
#' if(interactive()){
#'  #EXAMPLE1
#'  }
#' }
#' @seealso
#'  \code{\link[foreach]{foreach}}
#' @rdname abrir_base
#' @export
#' @import foreach
#' @import dplyr
abrir_base <- function(base, estados = NULL, censo_dir = "~/Downloads/Censo2010", cores = 1) {

  estados_full <- c("AC", "AL", "AM", "AP", "BA", "CE", "DF", "ES", "GO", "MA",
                    "MG", "MS", "MT", "PA", "PB", "PE", "PI", "PR", "RJ", "RN",
                    "RO","RR", "RS", "SC", "SE", "SP1", "SP2", "TO")

  if (is.null(estados)) {
    estados <- estados_full
  }

  estados <- match.arg(estados, estados_full, several.ok = TRUE)

  # doParallel::registerDoParallel(cores = cores)

  e <- NULL # iterador

  b <- foreach::foreach(
    e = estados,
    .combine = dplyr::bind_rows,
    .packages = c("readxl"),
    .export = c("abrir_base_estado")
    ) %do% # %dopar% # processamento paralelo com dopar
    abrir_base_estado(base, e, censo_dir)

    # stopCluster(cl)
  # doParallel::stopImplicitCluster()

  b
}
