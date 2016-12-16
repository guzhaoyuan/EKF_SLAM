#This is a demo for slam, used for understanding basic slam algorithm

all the process should be done in a 2D platform.

there are several static points as land marks.

##Landmarks
---
there are 4 landmarks for demo. Later, it should be able to use random points as landmarks.

Landmark1:[5,5]'
Landmark2:[-5,5]'
Landmark3:[-5,-5]'
Landmark4:[5,-5]'

##Wall
---
This wall should be set as a square.

the four corner is:

Corner1:[10,10]'
Corner2:[-10,10]'
Corner3:[-10,-10]'
Corner4:[10,-10]'

## the Mobile Robot
---
this robot has a init position [4,0,3*pi/4]
it goes in a inversed square with 4 waypoint

waypoint1:[4,0,3*pi/4]'
waypoint2:[0,4,5*pi/4]'
waypoint3:[-4,0,-pi/4]'
waypoint4:[0,-4,pi/4]'


##tasks
---

- finish the motion model
- finish the observation model
- finish the EKF process