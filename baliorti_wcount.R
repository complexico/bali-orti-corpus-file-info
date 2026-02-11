library(tidyverse)

wc_files <- dir(pattern = "word_counts")

wc_tb <- wc_files |> 
  map(read_lines) |> 
  map(~tibble(contents = .)) |> 
  map(~separate_wider_delim(., contents, delim = " words in ", names = c("word_count", "path"))) |> 
  map(~mutate(., word_count = as.integer(word_count)))
wc_tb |> 
  map2(.y = str_remove_all(wc_files, "(word_counts_|\\.txt$)"), 
       ~mutate(.x, year_folder = .y)) |>
  list_rbind() |> 
  mutate(year_folder = as.integer(year_folder)) |> 
  write_tsv("baliorti_wcount.tsv")
