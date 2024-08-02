from flask import Flask, Response
import cv2

app = Flask(__name__)

def find_camera_index():
    # Try device indices from 0 to 9 in typical Linux route /dev/video{i}
    for i in range(10):
        try_device_index = f"/dev/video{i}"
        cap = cv2.VideoCapture(try_device_index)
        ret, frame = cap.read()
        cap.release()  # Release the camera capture object
        if ret:
            print(f"Found camera at Linux index {i}: {try_device_index}")
            return try_device_index  # Return the found device path
        else:
            print(f"No camera found at Linux index {i}")
    
    # Try device indices for Windows
    for i in range(10): 
        cap = cv2.VideoCapture(i)
        ret, frame = cap.read()
        cap.release()  # Release the camera capture object
        if ret:
            print(f"Found camera at Windows index {i}: {i}")
            return i  # Return the found device index
        else:
            print(f"No camera found at Windows index {i}")
   
    # If no camera is found after trying all indices
    print("No camera found.")
    return None

def generate_frames():
    camera_index = find_camera_index()
    if camera_index is None:
        return
    
    cap = cv2.VideoCapture(camera_index)
    if not cap.isOpened():
        print("Error: Could not open webcam.")
        return

    while True:
        ret, frame = cap.read()
        if not ret:
            print("Error: Could not read frame.")
            break
        
        # Encode frame as JPEG
        ret, buffer = cv2.imencode('.jpg', frame)
        frame = buffer.tobytes()

        yield (b'--frame\r\n'
               b'Content-Type: image/jpeg\r\n\r\n' + frame + b'\r\n')

    cap.release()

@app.route('/video_feed')
def video_feed():
    return Response(generate_frames(),
                    mimetype='multipart/x-mixed-replace; boundary=frame')

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)

