# Hello.
# Learn Association Rules Mining while listening
# Giovanni Allevi (Italian Pianist and Composer)

# Introduction
# Association Rule Mining is a data mining technique
# that has the aim to find frequent patterns,
# associations, correlations, or causal structures
# among sets of items or objects in transaction
# databases, relational databases, and other information repositories.

# you will need below packages
# install.packages('arules')
library(arules)
# install.packages('arulesViz')
library(arulesViz)

# We are going to perform Association Rule Mining
# on the dataset called NLTCS related to
# records of each person’s disability in sixteen tasks
# of daily living: Eating, Dressing, Bathing, Cooking,
# and Telephoning are some of the task examples.
# We are going to analyse correlations between
# disabilities and mine rules between inabilities and abilities
# in elderly people.

# Read the data
dat<-read.table("http://mathsci.ucd.ie/~brendan/data/Old/nltcs.txt",header=TRUE)

# data summary
str(dat)  # 3152  of  18 variables
# tail(dat)
# sum(dat$COUNT) #how many people under analysis
# 21574

# NLTCS has been then formatted into a matrix where each
# row indicates the disabilities of 21574 elderly people.
M <- nrow(dat)
indices <- 1:M
counts <- dat$COUNT
rowindices <- rep(indices,counts)
nltcsmat <- dat[rowindices,]
head(nltcsmat)
nltcsmat <- nltcsmat[,-(17:18)]
nltcsmat <- nltcsmat[,16:1]
nltcsmat <- as.matrix(nltcsmat)
head(nltcsmat)

# mapping the data in y and n from 1 and 0 
nltcsmat[nltcsmat==1] <- "y"
nltcsmat[nltcsmat==0] <- "n"
head(nltcsmat)
tail(nltcsmat)

# analyze only when a disaiblity occurs
disab<- 1*(nltcsmat=="y")
colnames(disab) <- paste("Yes",1:16,sep="")
head(disab)

# transaction format to perform association rules mining technique
# for people with disability
nltcs <- as(disab,"transactions")
head(nltcs) # transactions in sparse format with
# we are considering 16 disabilities

# perform association rules using apriori algorithm
fit=apriori(nltcs,parameter = list(support=0.4,confidence=0.5))
# we found 8 rules. 
# If you decrease the support value,
# you will get more rules but less interesting ones

fit<-sort(fit,by="support")

inspect(fit) # have a look at the rules mined
# Yes 11 = grocery shopping
# Yes 7 = heavy work
# Yes 13 = taking medicine
# Yes 12 = cooking

# we are going to show the associations among these
# pair of items/disabilities through an interactive scatter plot
# with confidence and support level as axis,
# and on the right side the level of lift measure.
# The intensity of red colour identifies
# the level of importance of an association.

plot(fit,interactive = T)

# The most interesting rule is given by
#                                        Sup   Conf   Lift
# { grocery shopping } → { heavy work}  0.445  0.92   1.35

# Yes 11 = grocery shopping
# Yes 7 = heavy work

# this rule present a quite high lift value (1.35). Generally, a lift
# value higher than 1 indicates the degree to which antecedent
# and consequent are dependent on one another,
# and makes the rules useful to predict the consequent in future datasets.
# On the other hand, lift value = 1 suggests that
# the probability of occurrence of the antecedent and the
# probability of consequent are independent of each other.
# The above rule suggests that 92% of
# elderly, who are unable to do grocery shopping,
# are also unable to do heavy work. Note that all 6
# association rules mined do not overcome 0.48 support level. 

# other fancy ways to plot the rules
plot(fit,method='paracoord')
plot(fit,method='graph', main = ' You are listening: Notte ad Harlem')

# again:
# { grocery shopping } → { heavy work}  0.445  0.92   1.35

# Yes 11 = grocery shopping
# Yes 7 = heavy work


# please see in the video description some more infos.

print ('Thanks for watching and listening')
print ('Jabraghe')
