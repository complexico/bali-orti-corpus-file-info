library(tidyverse)
library(fs)

year_folder <- dir(path = "G:/Other computers/My MacBook Air/Documents/Corpora/_corpusbali/Surat Kabar/Orti Bali", pattern = "^20",
                   full.names = TRUE)

corpus_file_info <- vector(mode = "list", length = length(year_folder))
names(corpus_file_info) <- str_c("y_", basename(year_folder), sep = "")

for (i in seq_along(year_folder)) {
  
  corpus_file_info[[i]] <- dir(year_folder[i], full.names = TRUE) |> 
    map(file_info) |> 
    list_rbind() |> 
    mutate(year_folder = basename(year_folder[i]),
           path = basename(path))
  
}

corpus_file_info |> 
  list_rbind() |> 
  group_by(year_folder) |> 
  arrange(modification_time) |> 
  mutate(user = "Gede Primahadi W. Rajeg",
         group = "CompLexico") |> 
  write_tsv("baliorti_file_info.tsv")
