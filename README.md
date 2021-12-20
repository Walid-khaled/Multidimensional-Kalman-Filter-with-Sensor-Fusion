## Multidimensional-Kalman-Filter-with-Sensor-Fusion
In this repository, Multidimensional Kalman Filter and sensor fusion are implemented to predict the trajectories for constant velocity model. Data is extracted from GPS and Accelerometer using mobile phone. It is apart of Assignment3 in Sensing, Perception and Actuation course for ROCV master's program at Innopolis University.

---
### Task description
Take your smart phone and run for about 100 meters with a constant speed approximately. Your task is to estimate the trajectory where you ran with your phone. To estimate the trajectory, you are asked to incorporate sensor measurements that are available in your mobile phone (e.g., accelerometer, gyroscope, GPS sensor, etc). You need to implement Multidimensional Kalman filter with sensor fusion in order to solve this task. In the report clearly explain all the assumptions you made.

---
### Table of Content 
```
├── src            <- directory for source files
|    ├── main.m    <- contains main script
|             
├── acc_data.xlsx  <- contains accelerometer data
├── GPS_data.xlsx  <- contains GPS data
├── Report.pdf                        
└── Readme.md
```

<p align="center">Kalman Filter Loop</p>

<p align="center"><img src="https://user-images.githubusercontent.com/90580636/146700185-9d656892-e439-4ca5-adf7-998fe47b04ac.png" /></p>
