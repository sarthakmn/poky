import cv2
import numpy as np
import os

TARGET_W, TARGET_H = 800, 480  # enforce fixed size

def fade_in(image, frames=30):
    h, w, c = image.shape
    black = np.zeros((h, w, c), dtype=np.uint8)
    return [cv2.addWeighted(image, i/frames, black, 1 - i/frames, 0) for i in range(1, frames+1)]

def fade_out(image, frames=30):
    h, w, c = image.shape
    black = np.zeros((h, w, c), dtype=np.uint8)
    return [cv2.addWeighted(image, 1 - i/frames, black, i/frames, 0) for i in range(1, frames+1)]

def zoom_effect(image, frames=30, zoom_factor=1.5):
    h, w = image.shape[:2]
    frames_list = []
    for i in range(frames):
        scale = 1 + (zoom_factor - 1) * (i / (frames - 1))
        resized = cv2.resize(image, (int(w*scale), int(h*scale)))
        x = (resized.shape[1] - w) // 2
        y = (resized.shape[0] - h) // 2
        cropped = resized[y:y+h, x:x+w]
        fixed = cv2.resize(cropped, (TARGET_W, TARGET_H))
        frames_list.append(fixed)
    return frames_list

def rotate_effect(image, frames=30):
    h, w = image.shape[:2]
    center = (w//2, h//2)
    frames_list = []
    for i in range(frames):
        angle = (i / frames) * 360
        M = cv2.getRotationMatrix2D(center, angle, 1.0)
        rotated = cv2.warpAffine(image, M, (w, h), borderValue=(0,0,0))
        fixed = cv2.resize(rotated, (TARGET_W, TARGET_H))
        frames_list.append(fixed)
    return frames_list

def bgr_to_rgb565(frame):
    """Convert BGR888 (OpenCV) to RGB565 raw bytes with correct channel order (little-endian)."""
    rgb = cv2.cvtColor(frame, cv2.COLOR_BGR2RGB)  # fix channel order
    r = (rgb[:, :, 0] >> 3).astype(np.uint16)
    g = (rgb[:, :, 1] >> 2).astype(np.uint16)
    b = (rgb[:, :, 2] >> 3).astype(np.uint16)
    rgb565 = (r << 11) | (g << 5) | b
    # Ensure little-endian output for Pi framebuffer
    return rgb565.astype('<u2').tobytes()

def save_frames(frames, prefix="frame"):
    outdir = "frames"
    if not os.path.exists(outdir):
        os.makedirs(outdir)

    for idx, frame in enumerate(frames, start=1):
        raw_path = os.path.join(outdir, f"{prefix}{idx}.raw")
        raw_bytes = bgr_to_rgb565(frame)
        with open(raw_path, "wb") as f:
            f.write(raw_bytes)

def menu():
    print("\nChoose animation effect:")
    print("1. Fade In")
    print("2. Fade Out")
    print("3. Zoom Effect")
    print("4. Rotate Effect")
    print("5. Exit")
    return input("Enter your choice: ")

if __name__ == "__main__":
    image = cv2.imread("logo.png")
    if image is None:
        print("Error: logo.png not found!")
        exit(1)

    # resize input once to enforce consistency
    image = cv2.resize(image, (TARGET_W, TARGET_H))

    while True:
        choice = menu()
        if choice == "1":
            frames = fade_in(image)
            save_frames(frames)
            print("✅ Fade-in frames saved as frame1.raw ... frame30.raw in frames/")
        elif choice == "2":
            frames = fade_out(image)
            save_frames(frames)
            print("✅ Fade-out frames saved as frame1.raw ... frame30.raw in frames/")
        elif choice == "3":
            frames = zoom_effect(image)
            save_frames(frames)
            print("✅ Zoom frames saved as frame1.raw ... frame30.raw in frames/")
        elif choice == "4":
            frames = rotate_effect(image)
            save_frames(frames)
            print("✅ Rotation frames saved as frame1.raw ... frame30.raw in frames/")
        elif choice == "5":
            print("Exiting...")
            break
        else:
            print("❌ Invalid choice, try again.")

