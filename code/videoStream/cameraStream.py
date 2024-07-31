import cv2

# this method will iterate to find a cmaera index
def find_camera_index():
    # Try device indices from 0 to 9 in linux tipical route /dev/video{i}
    for i in range(10):
        try_device_index = f"/dev/video{i}"
        cap = cv2.VideoCapture(try_device_index)
        ret, frame = cap.read()
        if ret:
            print(f"Found camera at Linux index {i}: {try_device_index}")
            cap.release()  # Release the camera capture object
            return i  # Return the found device index
        else:
            print(f"No camera found Linux at index {i}")
    # try device indices for windows
    for i in range(10): 
        try_device_index = i
        cap = cv2.VideoCapture(try_device_index)
        ret, frame = cap.read()
        if ret:
            print(f"Found camera at Windows index {i}: {try_device_index}")
            cap.release()  # Release the camera capture object
            return i  # Return the found device index
        else:
            print(f"No camera found at Windows index {i}")
   
    # If no camera is found after trying all indices set the rtsp url
    print("No camera found.")
    return 0




cap = cv2.VideoCapture(find_camera_index())



if not cap.isOpened():
    print("Error: Could not open webcam.")
    exit()

while True:
    ret, frame = cap.read()
    
    if not ret:
        print("Error: Could not read frame.")
        break

    #cv2.imshow('Webcam Stream', frame)
    print("frame.")
    
    if cv2.waitKey(1) & 0xFF == ord('q'):
        break

cap.release()
#cv2.destroyAllWindows()
