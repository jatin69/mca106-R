# Vector with numerics from 1 up to 10
my_vector <- 1:10 

# Matrix with numerics from 1 up to 9
my_matrix <- matrix(1:9, ncol = 3)

# First 10 elements of the built-in data frame mtcars
my_df <- mtcars[1:10,]

# Construct list with these different elements:
my_list <- list(my_vector, my_matrix, my_df)

my_list


# Adapt list() call to give the components names
my_list <- list(vec=my_vector, mat=my_matrix, df=my_df)

# Print out my_list
my_list

# To access data from list
# these 3 are equivalent


shining_list <- list(moviename = mov, actors=act, reviews=rev)

shining_list[[3]]
shining_list[["reviews"]]
shining_list$reviews

# Access first element of the second component
shining_list[[2]][1]



# shining_list is already pre-loaded in the workspace

# Print out the vector representing the actors
shining_list[["actors"]]

# Print the second element of the vector representing the actors
shining_list[["actors"]][2]


# We forgot something; add the year to shining_list
shining_list_full <- c(shining_list, year=1980)

	
