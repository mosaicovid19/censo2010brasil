abrir_base <- function(base, estados = NULL, censo_dir, cores = 1) {

  require(doParallel) # construto %dopar%

  estados <- match.arg(estados, several.ok = TRUE)
  if (is.null(estados)) {
    estados <- c("AC", "AL", "AM", "AP", "BA", "CE", "DF", "ES", "GO", "MA",
                 "MG", "MS", "MT", "PA", "PB", "PE", "PI", "PR", "RJ", "RN", "RO",
                 "RR", "RS", "SC", "SE", "SP1", "SP2", "TO")
  }

  # cores <- detectCores() %/% 2
  # cores <- 2
  # cl <- makePSOCKcluster(detectCores())
  # registerDoParallel(cl)
  doParallel::registerDoParallel(cores = cores)

  b <- foreach::foreach(
    e = estados,
    .combine = bind_rows,
    .packages = c("readxl"),
    .export = c("abrir_base_estado")
    ) %dopar%
    abrir_base_estado(base, e, censo_dir)

    # stopCluster(cl)
  doParallel::stopImplicitCluster()

  b
}
