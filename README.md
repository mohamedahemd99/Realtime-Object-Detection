
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
    













