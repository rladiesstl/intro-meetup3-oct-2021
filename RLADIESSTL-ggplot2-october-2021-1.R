## R-Ladies St. Louis - ggplot and Data Visualization workshop
##Rebecca Winkler, University of Missouri - Saint Louis 


##ggplot can be used in R to make graphs and visualize data. ggplot implements the grammar of graphic:
## a system for describing and building graphs. 

##ggplot is a package within tidyverse. tidyverse needs to be loaded into R to access the datatset we will cover 

library(tidyverse)

##if you run into an error code, you might need to first install tidyverse.
install.packages("tidyverse")

#you only need to install the package once, but it will need to be re-loaded every session. 

#
#
#
#
#
#
#
#
#
#

##for this session, we will use the 'diamonds' dataset that is pre-loaded into R. This dataset is already 
##recognized within R.


##I will name our dataset to bring it into the global environment
diamonds=diamonds


##after clicking on the dataset in the global environment, we can see all the observations and variable values for 
##each observation. 

##to gain a better understanding of what each variable is, we can search 'diamonds' in the 'help' tab to the right -->
## or by running this code:
?diamonds



## a data frame allows us to see the first few observations in our dataset in the console.
ggplot2::diamonds



#
#
#
#
#
#
#
#
#
#


#to start visualizing the data, we can create graphs. Let's start with one variable from the 'diamonds' dataset.
##Categorical variables take one of a small set of values (example: Cut has 5 conditions -- fair, good, very good, 
## premium, & ideal)



##start by telling R what program we want to run and for what dataset. To begin a plot, use the function ggplot()
##ggplot() creates the base coordinate system to add layers to. 

##the first augment in the function is to include the dataset.
ggplot(diamonds) 
##creates an empty graph

##the function geom_bar() adds layers to the graph, creating a bar graph (bar graphs are great for categorical variables)
## Each geom function in ggplot defines how the variables are visualized. This is paired with aes() to define x
## and y variables. Because 'cut' is a categorical variable, we only need to define it as an x variable.

ggplot(diamonds)+
  geom_bar(aes(x=cut))
##when using the bar graph to visualize a set of data, the Y axis will represent the number, or "count" of things
## the X axis displays the categories of different diamonds cuts.
## because "count" isn't an actual vector, we don't need to include it and R will assume we want the count


#R can tell us the exact 'count' of diamonds that fall into each category by running a summary of the data.
#the code for this would be ---- summary(dataset$vector). The '$' "calls" a specific vector in the dataset.
summary(diamonds$cut)


#
#
#
#
#
#
#
#
#
#

##Next, we can add frequency labels to the graph using the "text" function
##the 'stat' function = statistical transformation, 
##we are using the 'count' stat to grab the frequency of each cut category

##this 'geom_text' function allows us to add text to the graph. by including the 'stat=count' & aes(label=)
##codes, it adds the frequency to each bar graph. 

##it's useful to use the 'label' function to label individual observations or groups of observations.
##use 'geom_text(aes(label=)' to make this possible
#I'm using the '..count..' code to display the count number for each category

ggplot(data=diamonds, aes(x=cut)) +
  geom_bar(aes(x=cut)) +
  geom_text(stat='count', aes(label=..count..)) 

##"..count.." is shorthand for count of the # of diamonds within each cut category. This function finds the group
## in X category and develops the frequency count 



##this puts the frequency on the graph, but it can be hard to see with the way it's adjusted.
##using the 'vjust' function allows you to move the text on the graph. 
ggplot(data=diamonds, aes(x=cut)) +
  geom_bar(aes(x=cut)) +
  geom_text(stat='count', aes(label=..count..), vjust=-1) 

#
#
#
#
#
#
#
#
#
#

##add a color key. Using the color command will outline the bars
##because this is transforming the bars themselves, we use this line of code in the 'geom_bar()' parentheses. 
ggplot(data=diamonds, aes(x=cut)) +
  geom_bar(aes(x=cut, color=cut)) +
  geom_text(stat='count', aes(label=..count..), vjust=-1)

##using the fill command will fill the bars completely
ggplot(data=diamonds, aes(x=cut)) +
  geom_bar(aes(x=cut, fill=cut)) +
  geom_text(stat='count', aes(label=..count..), vjust=-1)

##this especially comes in handy when trying to display additional variables, like the color of the diamonds for example.
##instead of filling in the bars with the cut variable ('fill=cut'), we can add another variable layer
## ('fill=color') to the graph

ggplot(data=diamonds, aes(x=cut)) +
  geom_bar(aes(x=cut, fill=color)) +
  geom_text(stat='count', aes(label=..count..), vjust=-1)
##this will display each category and stack the bars, with each colored rectangle representing a different combination
## of cut and color.
##this will also still show the total frequency of diamonds for each category of cut, not how many of each color are 
##in each category. 


##note that this can only be used on other categorical variables. For example, we couldn't do this with carat,
##which is a continuous variable.
ggplot(data=diamonds, aes(x=cut)) +
  geom_bar(aes(x=cut, fill=carat)) +
  geom_text(stat='count', aes(label=..count..), vjust=-1)



#the position adjustment 'position=fill' function works like stacking, but makes each set of stacked bars the same
##height, which makes it easy to compare PROPORTIONS (percentages) across groups. 
ggplot(data=diamonds, aes(x=cut)) +
  geom_bar(aes(x=cut, fill=clarity), position="fill")

ggplot(data=diamonds, aes(x=cut)) +
  geom_bar(aes(x=cut, fill=color), position="fill")

##the frequency counts displayed on the graph here aren't necessary since now we are looking at proportions

#the 'position=dodge' function places overlapping objects beside one another, making it easier to compare
##individual values. 
ggplot(data=diamonds, aes(x=cut)) +
  geom_bar(aes(x=cut, fill=color), position="dodge")

ggplot(data=diamonds, aes(x=cut)) +
  geom_bar(aes(x=cut, fill=clarity), position="dodge")

#
#
#
#
#
#
#
#
#
#
#
#
#




##Continuous variables take any of an infinite set of ordered values (Carat or Price can range all across the board)
##line graphs work well for this to reveal continuous change, but maybe not so much for 54,000 observation data-sets:

ggplot(diamonds)+
  geom_line(aes(x=price, y=carat))

##scatterplots work great for continuous variables to show the relationship between two variables. 

ggplot(diamonds)+
  geom_point(aes(x=carat, y=price))

##since there are nearly 54,000 observations, this graph looks a little busy, but we can see a sort of exponential 
## relationship between carat and price.

##our graph shows a few points that fall outside the general trend (upper right corner of the graph)
##how might we explain this variation? Maybe the cut or color of the diamond is of higher quality?
## we can add a third variable, such as color or cut, to our scatterplot by mapping the function in our aes() argument.
##this works by using a similar function with the bar graph, the 'color' function.

ggplot(diamonds)+
  geom_point(aes(x=carat, y=price, color=cut))

ggplot(diamonds)+
  geom_point(aes(x=carat, y=price, color=color))

##this function in ggplot will automatically assign a color to each value within a vector. 
##the colors reveal that the outliers are actually categorized as 'fair' diamonds with the lowest color quality 'J'. 
##these also happen to be the diamonds with the highest weight. 



##other functions, such as changing the point size or shape to indicate differences, can be done in ggplot as well. 

ggplot(diamonds)+
  geom_point(aes(x=carat, y=price, size=cut))

ggplot(diamonds)+
  geom_point(aes(x=carat, y=price, size=color))

#####

ggplot(diamonds)+
  geom_point(aes(x=carat, y=price, shape=cut))

ggplot(diamonds)+
  geom_point(aes(x=carat, y=price, shape=color))

##these functions clearly are not ideal for datasets with 54,000 observations.

#ggplot also allows you to set the aesthetic properties of your geom points manually. This is done by including
## the 'color=' function OUTSIDE of the aes() parentheses. Also, because we are setting these geoms to a specific color,
## we must included the color option in quotations.
##this doesn't display any information about additional variables, it just changes the appearance of the plot. 

ggplot(diamonds)+
  geom_point(aes(x=carat, y=price), color=" dark green")

ggplot(diamonds)+
  geom_point(aes(x=carat, y=price), color="blue")



#
#
#
#
#
#
#
#
#
#
#
#
#




##histograms can display the distribution of a continuous variable express a vector (variable) 
##on the X axis (diamond carat) against the Y axis (count)

##histograms divide the x-axis into equal 'bins'. As with bar graphs, the tall bars in histograms show the 
##common values of a variable, whereas the shorter bars show less common values.

ggplot(diamonds)+
  geom_histogram(aes(x=carat), binwidth=0.5)

##the tallest bar in this graph shows that about 30,000 of the 54,000 diamonds have a carat value between
## 0.25 and 0.75 (the left and right edges of the bar). We know this is the value range because our binwidth 
## is 0.5. For example, if we know our binwidth is 0.5, when is measured in units of the x varaible, the first
## bar would be values ranging from -0.75 to +0.25. Therefore, the next bar would be values that fall within
## 0.25 carats and 0.75 carats, and so on.

##'bins' here are the number of observations, but it can be changed to change the width of the bars in the histogram.
##Always explore different binwidths, and they can reveal different patterns. 

ggplot(diamonds)+
  geom_histogram(aes(x=carat), binwidth=0.1)



##it doesn't make sense to add frequency count labels on continuous variable since there can be so many different
## observations
ggplot(data=diamonds, aes(x=carat)) +
  geom_histogram(aes(x=carat), binwidth=0.5) +
  geom_text(stat='count', aes(label=..count..), vjust=-1)



#
#
#
#
#
#
#
#
#
#



##to overlay multiple histograms in the same plot, use geom_freqpoly(). This is useful when wanting to explore
##the vectors across two variables, such as both 'carat' and 'cut'. 
##'frepoly' displays counts with lines rather than bars
ggplot(diamonds)+
  geom_freqpoly(aes(x=carat, color=cut), binwidth=0.1) ##this layers the cut varibale into the freqpoly

##this is a very skewed graph since there are values shown for 3-5 carats with few observations
##changing the binwidth can help with this a bit:

ggplot(diamonds)+
  geom_freqpoly(aes(x=carat, colour=cut), binwidth=0.5)

##but this shows less variation in the data. This is a limitation of this type of plot. 

#
#
#
#
#
#
#
#
#
#
#




##unusual values, such as outliers, are data points that don't fit the patterns. With 54,000 observations, 
## a few outliers can be hard to see in our data visualization. For example, let's look at the 'y' variable in the
## diamonds dataset.


##'Y' vector in diamonds data set represents the width of diamonds in mm (0-58.9)
ggplot(diamonds)+
  geom_histogram(aes(x=y), binwidth=0.5)


##in this chart, it is hard to see the outliers, but the only evidence that they exist is the wide limits on the X axis
##To make it easy to see unusual values, we need to zoom to small values of the y-axis with coord_cartesian()
##coord_cartesian augments the limits of the X and Y axes
##you can shrink the axes in order to better see unusual values

##we don't want to shrink our X axis because the value range is only from about 0 to 60, and we want to know
##what outlier observations are within that variable. Instead, we will shrink the Y axis, which is 'count', because
## we know that if any outliers exist, there will not be very many of those specific values. 


##our graph indicates that one of the highest 'counts' is around 12,000. We know that a ton of diamonds (12,000 of them)
##fall within this bin of 'y' values (remember, y variable represents width of diamonds in mm)


##the 'ylim=c(X,X)' function tells R we want to limit our Y axis to a specific value range
##lets start by cutting our y-axis in half.
ggplot(diamonds)+
  geom_histogram(aes(x=y), binwidth=0.5)+
  coord_cartesian(ylim=c(0,6000))


##it is still difficult to see these outliers, but the skewed graph indicates that they exist.


ggplot(diamonds)+
  geom_histogram(aes(x=y), binwidth=0.5)+
  coord_cartesian(ylim=c(0,50))
 
##this graph shrunk the Y axis, so we are able to see the unusual values at 0, ~30, and ~60


##we can also change the limits of our x axis, which is shown here. I chose the 0-10 range since it looks like this
##is where most of our values fall. However, this augment wouldn't be helpful in trying to determine outliers. 
ggplot(diamonds)+
  geom_histogram(aes(x=y), binwidth=0.5)+
  coord_cartesian(xlim=c(0,10))





##coord_ systems also allow us to switch our X and Y axis. This is useful for boxplots or variables with long labels
##that overlap when on the x-axis. 

##a boxplot if a visual that shows a distribution of values. This is useful to display the distribution of a continuous
## variable (price) broken down by a categorical variable (cut). So this graph, instead of shwoing the 'Count' on the
## y-axis, we will display the price. 

##boxplots include a box that stretches from the 25th to 75th percentile. The 25th percentile is the point at which
##25% of the values fall below that range, and 75% lie above that range. 
##the 75th percentile is the point at while 25% of values lie above that range, and 75% of values fall below that range.
##The middle of the box includes a line that displays the median (50th percentile)

##these three lines give us an idea of the spread of the distribution.
## the lines (or whiskers) that extend from each end of the box goes to the farthest non-outlier
## point in the distribution
##points that fall outside our box and whisker would be considered outliers

ggplot(diamonds)+
  geom_boxplot(aes(x=cut, y=price))


##the 'coord_flip()' function allows us to flip the x and y axis, which sometimes comes in handy when looking at 
## boxplots. 

ggplot(diamonds)+
  geom_boxplot(aes(x=cut, y=price))+
  coord_flip()

#
#
#
#
#
#
#
#
#
#
#

##displaying two categorical variables (color and cut) against each other can be visualized with the 
##geom_count() function

ggplot(diamonds)+
  geom_count(aes(x=cut, y=color))

##the size of each circle in the plot displays how many observations occurred at each combination of specific values.

##it can be hard to distinguish between circle size, so we can use some additional functions to add a colored legend. 
##this can be done by adding the 'color=..n..' function inside our aes parentheses. 
## 'n' in our legend shows how many observations occured at a combination of values. 

##"..n.." is shorthand for count 

ggplot(diamonds)+
  geom_count(aes(x=cut, y=color, color=..n..))
##this adds a legend to show both size of circle and color.




##we can include a function for 'size' and 'guide' to combine the legends.
##Guides for each scale can be set with the 'guide' argument. For this graph, I will use the legend guide. This tells
## gpplot to display it as legend instead of a separate colorbar (default)

ggplot(diamonds)+
  geom_count(aes(x=cut, y=color, color=..n.., size=..n..))+
  guides(color='legend')



#
#
#
#
#
#
#
#
#
#
#


##labels and titling can be easily added to graphs using the 'labs()' function



ggplot(data=diamonds, aes(x=cut)) +
  geom_bar(aes(x=cut, fill=color), position="dodge")+
  labs(
  title = paste("Frequency of Diamonds by Cut"),
  subtitle = paste("Categorized by Color"),
  caption = paste("retrieved from R"),
  x = "Cut",
  y = "Count") ##sort of redundant but displayed here anyway. 


ggplot(data=diamonds, aes(x=cut)) +
  geom_bar(aes(x=cut, fill=clarity), position="dodge")+
  labs(
  title = paste("Frequency of Diamonds by Cut"),
  subtitle = paste("Categorized by Clairty"),
  caption = paste("retrieved from R"),
  x = "Cut",
  y = "Count") ##sort of redundant but displayed here anyway. 





























