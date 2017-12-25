sudo find / -name "*opencv*"
/home/asilla/abr/dataset/lassic/review_20171108/video/M03.mp4


*) remove opencv

- check version
pkg-config --modversion opencv

- check libopencv
dpkg -l libopencv*


*) remove
- remove lib
sudo apt-get purge libopencv*


- Remove OpenCV Debian Package(Custom Built from OpenCV Source code)
sudo dpkg -r opencv


- If installed using sudo make install (Built from OpenCV Source code)
cd dir/opencv/build/
sudo make uninstall


If created with make install then make uninstall
Else if created with checkinstall then dpkg -r release
Else sudo apt-get purge libopencv* && sudo apt-get autoremove

Additional files to remove:
sudo rm -rf /usr/local/include/opencv/
sudo rm -rf /usr/local/include/opencv2/
sudo rm -rf /usr/local/share/OpenCV/
sudo find /var/cache/apt/archives/ -name \*opencv\* -exec rm -rf {} \;
sudo find /usr/local/lib/ -name \*opencv\* -exec rm -rf {} \;
sudo find /usr/local/bin/ -name \*opencv\* -exec rm -rf {} \;

*) install new version
- download lib
wget -O 3.2.0.zip https://github.com/Itseez/opencv/archive/3.2.0.zip
unzip 3.2.0.zip

wget -O opencv_contrib.zip https://github.com/Itseez/opencv_contrib/archive/3.2.0.zip
unzip opencv_contrib.zip

- install lib
sudo apt-get upgrade
sudo apt-get install libavcodec-dev libavformat-dev libswscale-dev libv4l-dev
sudo apt-get install libxvidcore-dev libx264-dev libgtk-3-dev
sudo apt-get install libjpeg8-dev libtiff5-dev libjasper-dev libpng12-dev
sudo apt-get install libatlas-base-dev python3-numpy
sudo apt-get -y install libgtk2.0-dev python-dev python-numpy libgstreamer0.10-0-dbg libgstreamer0.10-0 libgstreamer0.10-dev libgstreamer-plugins-base0.10-dev libunicap2 libunicap2-dev libdc1394-22-dev libdc1394-22 libdc1394-utils libv4l-0 libv4l-dev libavcodec-dev libavformat-dev libswscale-dev libdc1394-22-dev libdc1394-utils libjpeg-dev libpng-dev  libtiff5-dev libopenexr-dev libjasper-dev

sudo apt-get -y install libx264-dev libxext-dev libxfixes-dev zlib1g-dev
 sudo apt-get install liblapacke-dev checkinstall

- install ffmpeg
sudo add-apt-repository ppa:jonathonf/ffmpeg-3
sudo apt update
sudo apt install ffmpeg libav-tools x264 x265

- install opencv
cd opencv-3.2.0/
mkdir build
cd build/
cmake -D CMAKE_BUILD_TYPE=RELEASE \
      -D CMAKE_INSTALL_PREFIX=/usr/local \
      -D CUDA_GENERATION=Kepler \
      -D WITH_TBB=ON \
      -D BUILD_NEW_PYTHON_SUPPORT=ON \
      -D WITH_V4L=ON \
      -D INSTALL_C_EXAMPLES=ON \
      -D INSTALL_PYTHON_EXAMPLES=ON \
      -D BUILD_EXAMPLES=ON \
      -D WITH_QT=OFF \
      -D WITH_OPENGL=ON \
      -D BUILD_TIFF=ON \
      -D OPENCV_EXTRA_MODULES_PATH= /home/asilla/setup/opencv_contrib-3.2.0/modules \
      -D WITH_FFMPEG=ON ..

make -j4
sudo make install
sudo ldconfig -v
find /usr/local/lib/ -type f -name "cv2*.so"
cd /usr/local/lib/python3.5/dist-packages/
sudo ln -s cv2.cpython-36m-x86_64-linux-gnu.so cv2.so


*) python code for test
import cv2 as cv
video = cv.VideoCapture('.../video/M03.mp4')
success, image = video.read()
print(success, image)


