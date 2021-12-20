## Multidimensional-Kalman-Filter-with-Sensor-Fusion
In this repository, 8-point algorithm is used to find the fundamental matrix based on SVD. Disparity map is generated from left and right images. In addition, RealSense depth camera 435i is used to estimate object center depth. Image thresholding and object detection are implemented. It is apart of Assignment3 in Sensing, Perception and Actuation course for ROCV master's program at Innopolis University.

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
