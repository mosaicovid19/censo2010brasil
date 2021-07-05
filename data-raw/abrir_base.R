abrir_base <- function(base, estados = c("AC", "AL", "AM", "AP", "BA", "CE", "DF", "ES", "GO", "MA",
                                         "MG", "MS", "MT", "PA", "PB", "PE", "PI", "RJ", "RS", "SP1",
                                         "SP2", "TO"), censo_dir, cores = 1) {

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

  b <- b %>%
    arrange(Cod_UF)
}
