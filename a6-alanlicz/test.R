result <-
  midwest %>% 
  arrange(desc(poptotal)) %>%
  select(county, state, poptotal) %>%
  top_n(10)

