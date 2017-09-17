vals <- c("high","low","medium",  "low")
vals_fct <- factor(vals, levels = c("low", "medium", "high"), ordered = TRUE)

vals_fct[1] 	
# high
vals_fct[2]
# low
vals_fct[3]
# medium
vals_fct[4]
# low

# retains the original vector


temp <- list(mar = 44)
c(temp, jul = 84)