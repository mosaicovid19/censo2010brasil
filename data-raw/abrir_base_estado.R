abrir_base_estado <- function(base, estado, censodir = "~/Downloads/Censo2010/") {
  arquivos <- c(
    Basico = file.path(censo_dir, paste0("Basico_", estado, ".xls")),
    Entorno = file.path(censo_dir, paste0("Entorno03_",estado,".xls")),
    Domicilio01 = file.path(censo_dir, paste0("Domicilio01_",estado,".xls")),
    Domicilio02 = file.path(censo_dir, paste0("Domicilio02_",estado,".xls")),
    Pessoa = file.path(censo_dir, paste0("Pessoa03_",estado,".xls")),
    Dom.Renda = file.path(censo_dir, paste0("DomicilioRenda_",estado,".xls")),
    Resp.Alfa = file.path(censo_dir, paste0("Responsavel02_",estado,".xls"))
  )
  b <- readxl::read_excel(arquivos[base], na = "X")
  print(paste(estado, base, arquivos[base]))
  b %>%
    # fix Entorno03
    mutate(Cod_UF = estado) %>%
    # fix Responsavel02_SP2
    mutate(across(starts_with("V"), as.numeric))
}
