mtcars
head(mtcars)
tail(mtcars)

# Investigate the structure of mtcars
str(mtcars)

# Definition of vectors
name <- c("Mercury", "Venus", "Earth", "Mars", "Jupiter", "Saturn", "Uranus", "Neptune")
type <- c("Terrestrial planet", "Terrestrial planet", "Terrestrial planet", 
          "Terrestrial planet", "Gas giant", "Gas giant", "Gas giant", "Gas giant")
diameter <- c(0.382, 0.949, 1, 0.532, 11.209, 9.449, 4.007, 3.883)
rotation <- c(58.64, -243.02, 1, 1.03, 0.41, 0.43, -0.72, 0.67)
rings <- c(FALSE, FALSE, FALSE, FALSE, TRUE, TRUE, TRUE, TRUE)

# Create a data frame from the vectors
planets_df <- data.frame(name,type, diameter, rotation, rings)

str(planets_df)

# Print out diameter of Mercury (row 1, column 3)
planets_df[1,3]
# Print out data for Mars (entire fourth row)
planets_df[4,]

# Print out data for Mars and Jupiter (entire fourth and fifth row)
planets_df[c(4,5),]

# printing first 3 rows of the second ( type ) column
planets_df[1:3,2]
planets_df[1:3,"type"]

# below 3 are equivalent
planets_df[,3]
planets_df[,"diameter"]
planets_df$diameter


# TO print planets with rings

# Select the rings variable from planets_df
rings_vector <- planets_df[,"rings"]
# display name of planets with rings
planets_df[rings_vector, "name"]


# SHORTCUT TO DO SAME
subset(planets_df, subset = rings)

# Select planets with diameter < 1
subset(planets_df, subset = (diameter < 1))


#SORTING

a <- c(100, 10, 1000)
order(a)
#displays the order of each element

# to actually sort it. use this
a[order(a)]

# planets_df is pre-loaded in your workspace

# Use order() to create positions
positions <-  order(planets_df$diameter)

# Use positions to sort planets_df
planets_df[positions,]