#Load required packages
  library("ggplot2")
  library("plotly")
  library("plyr")
  library("gdata")

#Removing unused variables from global environment
remove(list=ls())

#loading the dataset
dataset <- read.csv(file="data.csv",header = T, sep=",")

#check the data set
head(dataset,3)

#checking the levels
str(dataset)

#Orientation plots of a user
#Function call to get the various users pattern in landscape and portrait
#The function needs 2 input values:-
#   1. User id - values range from 0 to 40
#   2. Phone orientation - values can be 1 or 2

orientation <- function(userid,orient)
{
  #subset user with their respective ID
  user <- dataset[dataset$uid == userid,]  
qplot(data = user[(user$ph_ori == orient) ,], x = x_cord,
      main = toupper(orientname(orient)), 
      y= y_cord)
}

orientname <- function(orient){
  val1 <- NULL
  
  if(orient==1)
  {
   val1 = "portrait"
  }
  else
  {
    val1 = "landscape"
  }
  val1 = (paste(val1,"orientation plot"))
  return (val1)
}
 
#Orient = 1 : Phone is in portrait/vertical position
#Orient = 2 : Phone is in landscape position
orientation(1,2)
orientation(1,1)

#Sample data of 50000 training sets
smallset<-dataset[sample(nrow(dataset),50000),]

#Taking phone id and pressure
dataS1<-smallset[c(2,9)]  

#Calculate mean & standard deviation of pressure for every user
phset<-ddply(dataS1, .(uid), summarise, prsr_mean=mean(pressure), prsr_sd=sd(pressure))

#Plot mean & sd points of pressure for every users (ID: 0 to 40)
ggplot(dataS1, aes(x=uid, y=pressure)) + 
  labs(x = "User ID", y = "Pressure Deviation") +
  geom_point() + ggtitle("Pressure & Standard Deviation Points of all users")+
  geom_point(data=phset, aes(y=prsr_sd), color='blue', size=4) + 
  geom_point(data=phset, aes(y=prsr_mean), color='red', size=4)


#Subset dataset with phone id 1
ph1 <- dataset[dataset$p_id == 1,]

#Plot Pressure of users for a random of 100 training sets
ph1_s <- ph1[sample(nrow(ph1),100),]

plot_ly(ph1_s, x = x_cord , y = y_cord,main = "Pressure dots of users for a random of 100 training sets",
        text=paste("Pressure: ",pressure, "Area: ", area),
        mode="markers", color = uid, size=uid )


#Plot Touch Traces of users in Nexus 1-Experimenter E
#Roll the cursor over the graph to check pressure points
#Valid users for phone_id=1 are 36,5,39,16,18,12

user_finger_trace <- function(userid)
{
  set1 <- ph1[ph1$uid==userid,]
  
  
  for (i in 1:length(set1$action))
  {
    if(set1$action[i]==0)
      set1$action.name[i]="Touch Down Traces"
    else if(set1$action[i]==1)
      set1$action.name[i]="Touch Up Traces"
    else
      set1$action.name[i]="Finger Movement Traces"
  }
  
  p_set1 <- ggplot(data = set1, aes(x = x_cord, y = y_cord)) +
    ggtitle((paste("Touch Traces of User ID ",userid,
                   "in Nexus 1-Experimenter E"))) +
    labs(x="X Axis", y="Y Axis") +
    geom_point(aes(text = paste("Pressure :", pressure)), size = 4) +
    geom_smooth(aes(color = action.name, fill = action.name))	 + 
    facet_wrap(~ action.name)
  
  ggplotly(p_set1)
  
}

user_finger_trace(36)

#Plot traces of accessing wikipedia article & image comparison game 
#Valid users for phone_id=1 are 36,5,39,16,18,12
user_doc_traces <- function(userid)
{
  
set1 <- ph1[ph1$uid== userid,]

for (i in 1:length(set1$docid))
{
  if(set1$docid[i]==0)
    set1$doc.name[i]="Wikipedia Artice 1"
  else if(set1$docid[i]==1)
    set1$doc.name[i]="Wikipedia Article 2"
  else if(set1$docid[i]==2)
    set1$doc.name[i]="Wikipedia Article 3"
  else if(set1$docid[i]==3)
    set1$doc.name[i]="Image Comparion Game 1"
  else if(set1$docid[i]==4)
    set1$doc.name[i]="Image Comparion Game 2"
  else if(set1$docid[i]==5)
    set1$doc.name[i]="Wikipedia Article 4"
  else
    set1$doc.name[i]="Image Comparion Game 3"
}

p_doc <- ggplot(data = set1, aes(x = x_cord, y = y_cord)) +
  ggtitle((paste("Traces of User ID", userid,
                 "in various applications"))) +
  labs(x = "X Axis", y = "Y Axis") +
  geom_point(aes(text = paste( "Area :", area)), size = 4) +
  geom_smooth(aes(color = doc.name, fill = doc.name))	 + 
  facet_wrap(~ doc.name)

ggplotly(p_doc)

}
user_doc_traces(18)