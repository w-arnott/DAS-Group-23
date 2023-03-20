#data wrangling
#1.Create Response variable: Create a new variable indicating whether each item costs more than 1000 Saudi Riyals. Already done in the cleaning part
#2.
furniture <- read.csv("cleaned_data.csv")
furniture$price <- as.factor(furniture$price)
levels(furniture$price) <- c("Under", "Above")
furniture$category <- as.factor(furniture$category)
furniture$sellable_online <- as.factor(furniture$sellable_online)
furniture$other_colors <- as.factor(furniture$other_colors)

#relationships
#1.category
ggplot(furniture, aes(x= price,  y = ..prop.., group=category, fill=category)) + 
  geom_bar(position="dodge", stat="count") +
  labs(x= 'Price', y = "Proportion")
#result:category of sofas and armchairs has the most prop of the price above 1000

#2.sellable_online
ggplot(furniture, aes(x= price,  y = ..prop.., group=sellable_online, fill=sellable_online)) + 
  geom_bar(position="dodge", stat="count") +
  labs(x= 'Price', y = "Proportion")
#All unsellable online productions are under 1000

#3.other_colors
ggplot(furniture, aes(x= price,  y = ..prop.., group=other_colors, fill=other_colors)) + 
  geom_bar(position="dodge", stat="count") +
  labs(x= 'Price', y = "Proportion")
#looks like no relationship

#4.depth
ggplot(furniture, aes(x = price, y = depth, fill = price)) +
  geom_boxplot() +
  labs(x = "Price", y = "Depth")+ 
  theme(legend.position = "none")
#depth between 50 and 100 seems like more possible to have price over1000

#5.height
ggplot(furniture, aes(x = price, y = height, fill = price)) +
  geom_boxplot() +
  labs(x = "Price", y = "Height")+ 
  theme(legend.position = "none")
#...

#6.width
ggplot(furniture, aes(x = price, y = width, fill = price)) +
  geom_boxplot() +
  labs(x = "Price", y = "Width")+ 
  theme(legend.position = "none")
#...

#Seems like the bigger the furniture is, the higher the price is

# Fit a binary logistic regression model
model <- glm(price ~ category + sellable_online + other_colors + depth + height + width,
             data = furniture, family = binomial(link = "logit"))
#Model diagnosis: The model is diagnosed using the summary() function and the plot() function
# Summarize the model
summary(model)

#Explain results: Explain model coefficients and statistical significance, and explain the relationship between independent variables and response variables using odds ratio or other explanatory measures.
exp(coef(model))
#categoryNursery furniture and categoryRoom dividers are more possible to have th price under 1000(coeffcients < 0)

library(sjPlot)
plot_model(model, show.values = TRUE,
     title = "Odds of furniture price over 1000", show.p = FALSE)
#...



