# Construct a matrix with 3 rows that contain the numbers 1 up to 9
matrix(1:9, byrow=TRUE, nrow=3)

# Box office Star Wars (in millions!)
new_hope <- c(460.998, 314.4)
empire_strikes <- c(290.475, 247.900)
return_jedi <- c(309.306, 165.8)

# Construct matrix
star_wars_matrix <- matrix(c(new_hope, empire_strikes, return_jedi), nrow = 3, byrow = TRUE)

# Print out star_wars_matrix
star_wars_matrix






# Vectors region and titles, used for naming
region <- c("US", "non-US")
titles <- c("A New Hope", "The Empire Strikes Back", "Return of the Jedi")

# Name the columns with region
colnames(star_wars_matrix)<-region

# Name the rows with titles
rownames(star_wars_matrix)<-titles

# Print out star_wars_matrix
star_wars_matrix






# Construct star_wars_matrix
box_office <- c(460.998, 314.4, 290.475, 247.900, 309.306, 165.8)
star_wars_matrix <- matrix(box_office, nrow = 3, byrow = TRUE,
                           dimnames = list(c("A New Hope", "The Empire Strikes Back", "Return of the Jedi"), 
                                           c("US", "non-US")))

# Calculate worldwide box office figures - calculates row wise sum
worldwide_vector <- rowSums(star_wars_matrix)
# similarly, colSums also exists
# total_revenue_vector <- colSums(all_wars_matrix)

# Bind the new variable worldwide_vector as a column to star_wars_matrix
# add new columns
all_wars_matrix <- cbind(star_wars_matrix, worldwide_vector)

#displaying
all_wars_matrix





# star_wars_matrix and star_wars_matrix2 are available in your workspace
star_wars_matrix  
star_wars_matrix2 

# Combine both Star Wars trilogies in one matrix
# add new rows
all_wars_matrix <- rbind(star_wars_matrix,star_wars_matrix2)







# all_wars_matrix is available in your workspace
all_wars_matrix

# Select the non-US revenue for all movies
non_us_all <- all_wars_matrix[,2]
# as only one column is passed on, it is now converted to a 1D vector
  
# Average non-US revenue
mean(non_us_all)
  
# Select the non-US revenue for first two movies
non_us_some <- non_us_all[1:2] 
# as it is one D vector, only one dimension is accepted
  
# Average non-US revenue for first two movies
mean(non_us_some)




# Estimate the visitors
visitors <- all_wars_matrix/5  
# Print the estimate to the console
visitors





# all_wars_matrix and ticket_prices_matrix are available in your workspace
all_wars_matrix
ticket_prices_matrix

# Estimated number of visitors
visitors <- all_wars_matrix/ticket_prices_matrix

# US visitors
us_visitors <- visitors[,1]

# Average number of US visitors
mean(us_visitors)


