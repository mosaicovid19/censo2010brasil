abrir_base_estado <- function(base, estado, censo_dir = "~/Downloads/Censo2010/") {
  arquivo <- file.path(censo_dir, paste0(base, "_", estado, ".xls"))

  b <- readxl::read_excel(arquivo, na = "X")

  b %>%
    # fix Basico: substitui Cod_UF pelo código (numérico)
    # Assume que Cod_meso sempre existe na base em que Cod_UF existe e
    # toma os 2 primeiros dígitos de um número de 4 dígitos
    mutate( across(any_of("Cod_UF"), ~ Cod_meso %/% 100) ) %>%
    # fix Responsavel02_SP2
    mutate(across(starts_with("V"), as.numeric))
}
