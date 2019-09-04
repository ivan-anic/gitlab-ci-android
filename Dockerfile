FROM ubuntu:18.04

ENV VERSION_SDK_TOOLS "3859397"

ENV ANDROID_HOME "/opt/android"
ENV PATH "$PATH:${ANDROID_HOME}/tools"
ENV DEBIAN_FRONTEND noninteractive

RUN apt update \
  && apt install default-jdk \
  && wget https://dl.google.com/android/repository/sdk-tools-linux-4333796.zip \
  && unzip sdk-tools-linux-4333796.zip -d /opt/android \
  && rm android-sdk.zip \
  && echo "y" | sdkmanager --update \
  && echo "y" | sdkmanager --licenses \
  && echo "y" | sdkmanager "system-images;android-25;google_apis;armeabi-v7a" \
  && echo "y" | sdkmanager "emulator" \
  && echo "y" | sdkmanager "platform-tools" \
  && touch /home/ubuntu/.android/repositories.cfg \
  && mkdir /opt/android-sdk/platforms \
  && echo "no" | avdmanager -v create avd -f -n MyAVD -k "system-images;android-25;google_apis;armeabi-v7a" -p "/opt/android-sdk/avd" \
