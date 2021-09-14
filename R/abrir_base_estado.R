#' @title FUNCTION_TITLE
#' @description FUNCTION_DESCRIPTION
#' @param base PARAM_DESCRIPTION
#' @param estado PARAM_DESCRIPTION
#' @param censo_dir PARAM_DESCRIPTION, Default: '~/Downloads/Censo2010/'
#' @return OUTPUT_DESCRIPTION
#' @details DETAILS
#' @examples
#' \dontrun{
#' if(interactive()){
#'  #EXAMPLE1
#'  }
#' }
#' @seealso
#'  \code{\link[readxl]{read_excel}}
#' @rdname abrir_base_estado
#' @export
#' @import readxl
#' @import dplyr
#' @import bit64
abrir_base_estado <- function(base, estado, censo_dir = "~/Downloads/Censo2010/") {
  arquivo <- file.path(censo_dir, paste0(base, "_", estado, ".xls"))

  b <- readxl::read_excel(arquivo, na = "X")

  b %>%
    # fix Basico: substitui Cod_UF pelo código (numérico)
    # Assume que Cod_meso sempre existe na base em que Cod_UF existe e
    # toma os 2 primeiros dígitos de um número de 4 dígitos
    mutate( across(any_of("Cod_UF"), ~ Cod_meso %/% 100) ) %>%
    # Todos os códigos como int
    mutate(
      # Cod_setor excede o limite de int, precisamos int64
      Cod_setor = as.integer64(Cod_setor),
      `Cod_Grandes Regiões` = as.integer(`Cod_Grandes Regiões`),
      Cod_UF = as.integer(Cod_UF),
      Cod_meso = as.integer(Cod_meso),
      Cod_micro = as.integer(Cod_micro),
      Cod_RM = as.integer(Cod_RM),
      Cod_municipio = as.integer(Cod_municipio),
      Cod_distrito = as.integer(Cod_distrito),
      # Cod_subdistrito excede o limite de int, precisamos int64
      Cod_subdistrito = as.integer64(Cod_subdistrito),
      Cod_bairro = as.integer(Cod_micro),
      Situacao_setor = as.integer(Situacao_setor),
    ) %>%
    # fix Responsavel02_SP2
    mutate(across(starts_with("V"), as.numeric))
}
