FROM gitpod/workspace-full

# تثبيت Flutter
RUN sudo apt-get update && \
    sudo apt-get install -y clang cmake ninja-build && \
    git clone https://github.com/flutter/flutter.git -b stable --depth 1 /home/gitpod/flutter

# إعداد البيئة
ENV PATH="$PATH:/home/gitpod/flutter/bin"
RUN flutter config --enable-web && \
    flutter doctor
RUN sudo apt-get install -y android-sdk
