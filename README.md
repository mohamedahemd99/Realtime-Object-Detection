- Flutter Object Detection App

- Project Description
  Flutter application integrating object detection, real-time user guidance, and image capture.

- Features

1. ARCore and Marker Placement
   Real-time placement of visual markers on detected objects in 3D space.
   Dynamic marker adjustment based on camera movements.
2. Object Detection with YOLOv8
   Integrated YOLOv8 for local object detection in real-time.
   Capable of detecting various objects in diverse environments
3. Photo Management
   Capture photos while the confidence is >0.7.
   View photos in a new screen with metadata of the image captured (Type of object, confidence,date,
   and timestamp)
4. project Architecture
    Using MVVM to handel the project architecture

- Technologies Used
    1. Flutter for cross-platform development
    2. ARCore for augmented reality
    3. YOLOv8 for object detection using tflite_v2

- packages Used
    1. search_choices: for search with label to get a label that you want to detect
    2. flutter_screenutil: to make the app responsive
    3. intl: to formate the DateTime
    4. tflite_v2 as for to load the model and recognise the object
    5. camera for Camera preview and get frames to detect
    6. image: for converter frame to image to use in captured screen
    7. provider is a stateMangement  
    
- Screen Shots
 
![1](https://github.com/user-attachments/assets/561e5601-383e-47d2-a533-2204753d8d8d)


![2](https://github.com/user-attachments/assets/5426eb8d-9bf5-4e1d-aff7-90cfdab009d9)

![3](https://github.com/user-attachments/assets/c23f15ff-c2b9-4951-ae70-50f959968663)

![4](https://github.com/user-attachments/assets/1ee76010-be83-408d-96ed-7fb9c1ba779b)

![5](https://github.com/user-attachments/assets/19cd42c0-deae-46d0-9958-91067c2d41a8)

![6](https://github.com/user-attachments/assets/c4a8b8a5-ccab-4132-936b-7e12d8e39cb5)


![7](https://github.com/user-attachments/assets/962fdecb-6e01-4878-9b9a-60734d9831cc)


![8](https://github.com/user-attachments/assets/2e84eed4-d02e-4644-b3a6-ade8e23d0f73)

![9](https://github.com/user-attachments/assets/df0e1aa9-4877-4744-a0ba-020fece94465)





