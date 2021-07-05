abrir_base_estado <- function(base, estado, censodir = "~/Downloads/Censo2010/") {
  arquivo <- file.path(censo_dir, paste0(base, "_", estado, ".xls"))
  b <- readxl::read_excel(arquivo, na = "X")
  print(paste(estado, base, arquivo))
  b %>%
    # fix Entorno03
    mutate(Cod_UF = estado) %>%
    # fix Responsavel02_SP2
    mutate(across(starts_with("V"), as.numeric))
}
