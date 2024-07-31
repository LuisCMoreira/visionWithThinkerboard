import cv2
import threading
import paho.mqtt.publish as publishToMqtt

# MQTT setup
BROKER_ADDRESS = "localhost"
BROKER_PORT = 1883

def publish_variables(variable1, variable2):

    publishToMqtt("X", str(variable1), BROKER_ADDRESS, BROKER_PORT, 'faceTracking')
    publishToMqtt("Y", str(variable2), BROKER_ADDRESS, BROKER_PORT, 'faceTracking')

def capture_frames():
    global frame
    while True:
        ret, frame = cap.read()
        if not ret:
            print("Error: Couldn't read frame")
            break

def main():
    global frame

    # Load Haar Cascades
    face_cascade = cv2.CascadeClassifier(cv2.data.haarcascades + 'haarcascade_frontalface_default.xml')
    eye_cascade = cv2.CascadeClassifier(cv2.data.haarcascades + 'haarcascade_eye.xml')

    # RTSP URL of your IP camera
    rtsp_url = 'rtsp://admin:admin@10.1.1.245/2'
    cap = cv2.VideoCapture(rtsp_url)

    frame_thread = threading.Thread(target=capture_frames)
    frame_thread.daemon = True
    frame_thread.start()

    while True:
        if frame is not None:
            gray = cv2.cvtColor(frame, cv2.COLOR_BGR2GRAY)
            faces = face_cascade.detectMultiScale(gray, scaleFactor=1.1, minNeighbors=5, minSize=(30, 30))

            for (x, y, w, h) in faces:
                cv2.rectangle(frame, (x, y), (x + w, y + h), (255, 0, 0), 2)
                roi_gray = gray[y:y + h, x:x + w]
                eyes = eye_cascade.detectMultiScale(roi_gray, scaleFactor=1.1, minNeighbors=10, minSize=(20, 20))
                
                for (ex, ey, ew, eh) in eyes:
                    cv2.rectangle(frame, (x + ex, y + ey), (x + ex + ew, y + ey + eh), (0, 255, 0), 2)

                # Publish the coordinates of the center of the face
                face_center_x = x + w / 2
                face_center_y = y + h / 2
                publish_variables(face_center_x, face_center_y)

        if cv2.waitKey(1) & 0xFF == ord('q'):
            break

    cap.release()
    cv2.destroyAllWindows()

if __name__ == "__main__":
    main()
