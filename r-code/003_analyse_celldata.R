# 003_analyse_celldata.R
#library(rstudioapi)
#print(rstudioapi::getSourceEditorContext()$path)
#browser() 




######################-celldata analytical functions ###########################
#
# join SA data to celldata for ggplot (incomplete)

#----------------------------------------

write_assignment_celldata <- function(folder="./data/",filename="assignment.celldata.RDS",tb) { 
#  browser()
  file_export <- file.path(folder, filename)
  saveRDS(tb,file_export)
}
#----------------------------------------
  get_cell_plotdata <- function(tb, sa, time_start, time_stop) {

#time_max = .Machine$integer.max
browser()
if (time_start > time_stop) {
  return(invisible(NULL))  # time range invalid
}

# tb rows within the time range (inclusive)
filtered_tb <- tb %>%
  filter(NZST >= time_start & NZST <= time_stop)

#  join between the filtered tb and sa based on the  SA and SA2 columns match
#  group by NZST and calculate the sum of the 'sum' column from tb
result <- filtered_tb %>%
  inner_join(sa, by = c("SA2" = "sa2"))

#  %>%    # Join on matching SA and SA2 columns
#    group_by(NZST) %>%                         # Group by NZST (time)
#    summarise(SA2 = min(SA2),                     # Keep the minimum SA value for each group
#S              total_sum = sum(sum))             # Sum the 'sum' column for each time entry

return(result)  # Return the resulting tibble
}
#----------------------------------------

#
#
##############################################################################


