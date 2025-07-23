FROM gitpod/workspace-full:latest

# تثبيت التبعيات الأساسية
RUN sudo apt-get update && \
    sudo apt-get install -y \
    unzip \
    zip \
    libglu1-mesa \
    xz-utils \
    lib32z1 \
    libncurses5 \
    libx11-6

# تثبيت Flutter
RUN git clone https://github.com/flutter/flutter.git -b stable --depth 1 /home/gitpod/flutter

# إعداد متغيرات البيئة
ENV PATH="$PATH:/home/gitpod/flutter/bin"
ENV ANDROID_SDK_ROOT="/home/gitpod/android-sdk"
ENV ANDROID_HOME="/home/gitpod/android-sdk"

# تثبيت Android SDK
RUN mkdir -p ${ANDROID_HOME}/cmdline-tools && \
    wget https://dl.google.com/android/repository/commandlinetools-linux-9477386_latest.zip -O /tmp/cmdline-tools.zip && \
    unzip -q /tmp/cmdline-tools.zip -d ${ANDROID_HOME}/cmdline-tools && \
    mv ${ANDROID_HOME}/cmdline-tools/cmdline-tools ${ANDROID_HOME}/cmdline-tools/latest && \
    rm /tmp/cmdline-tools.zip

# قبول التراخيص وتثبيت الحزم
RUN yes | ${ANDROID_HOME}/cmdline-tools/latest/bin/sdkmanager --licenses && \
    ${ANDROID_HOME}/cmdline-tools/latest/bin/sdkmanager \
    "platform-tools" \
    "platforms;android-33" \
    "build-tools;33.0.2" \
    "emulator" \
    "system-images;android-33;google_apis;x86_64"

# إعداد Flutter
RUN flutter config --enable-android && \
    flutter precache
