# Smartphone-User-Trace-Analytics-I
Plotting traces of different smartphone users.

The dataset is initilly subseted using plyr package in R used to split up a big data structure into homogeneous pieces, apply functions 
to each piece and then combine all the results back together. 
Ffunction ddply which is available in plyr library is used to calculate the mean & standard deviation of pressure for every user and
display it altogether.

Analysis of Dataset:-
The components of the dataset that contributed for the analysis are phone ID ranging from 1 to 5, user ID (0 to 40), X and Y coordinates 
of every user’s traces on smartphone. It is important to consider the orientation of the phone to recognize the pattern of a particular 
user. Here, the orientation are of two types – Landscape and Portrait.
Moreover, the user’s pressure applied and area covered by the finger touch for every action performed are captured in the dataset. 
The actions considered are touch up, touch down and finger movement. 

The diagram (diagram.png)in the figure 1 depicts that the key components such as the pressure or orientation are plotted against the 
xy coordinates. The patterns can be extracted for each and every user based on different components such as action performed on 
smartphones, type of document accessed and so on.

Following packages are mandatory:-
  1. gdata
  2. ggplot2
  3. plyr
  4. plotly

The graphs are plotted using ggplot2 and plotly packages.
The graphs plotted using plotly package are reactive, so they are made available in cloud. The following are the links to plots:-

https://plot.ly/~niranjana88/50/pressure-plot-of-users-for-a-random-of-100-training-sets/

https://plot.ly/~niranjana88/44/traces-of-user-id-36-in-various-applications/

https://plot.ly/~niranjana88/30/touch-traces-of-user-id-36-in-nexus-1-experimenter-e/?share_key=NqeZl8zuXU74pk04nrYiIR
