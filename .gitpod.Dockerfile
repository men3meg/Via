FROM gitpod/workspace-full

# تثبيت JDK 11
USER root
RUN apt-get update && apt-get install -y openjdk-11-jdk wget unzip

# تحميل أدوات سطر الأوامر لـ Android SDK
RUN wget https://dl.google.com/android/repository/commandlinetools-linux-10406996_latest.zip -O cmdline-tools.zip && \
    unzip cmdline-tools.zip -d /opt/android-sdk/ && \
    mkdir -p /opt/android-sdk/cmdline-tools && \
    mv /opt/android-sdk/cmdline-tools/* /opt/android-sdk/cmdline-tools/latest

ENV ANDROID_SDK_ROOT=/opt/android-sdk
ENV JAVA_HOME=/usr/lib/jvm/java-11-openjdk-amd64
ENV PATH=$JAVA_HOME/bin:$ANDROID_SDK_ROOT/cmdline-tools/latest/bin:$PATH

# تثبيت الأدوات الرئيسية للـ SDK
RUN yes | sdkmanager --sdk_root=$ANDROID_SDK_ROOT --licenses || true
RUN sdkmanager --sdk_root=$ANDROID_SDK_ROOT "platform-tools" "platforms;android-33" "build-tools;33.0.2"
