##read the first few lines of buoy data to decide how to read in
##read in file without headers
file <- "http://www.ndbc.noaa.gov/view_text_file.php?filename=44025h2011.txt.gz&dir=data/historical/stdmet/"
readLines(file, n = 4)
buoy44025 <- read_table(file, 
                        col_names = FALSE,
                        skip = 2)

##read in headers as a list using scan
measure_units <- scan("http://www.ndbc.noaa.gov/view_text_file.php?filename=44025h2011.txt.gz&dir=data/historical/stdmet/",
                      nlines = 2,
                      what = "")
measure_units


