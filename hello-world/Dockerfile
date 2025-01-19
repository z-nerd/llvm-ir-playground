ARG alpineV=latest
FROM alpine:$alpineV

ARG clangV=19.1.4-r0
ENV clangV=$clangV
ARG llvmV=19.1.4-r0
ENV llvmV=$llvmV
ARG NDK_VERSION=r28-beta3
ENV NDK_VERSION=$NDK_VERSION

ENV NDK_HOME=/opt/android-ndk

LABEL maintainer="Zero <github.com/z-nerd>" 
LABEL description="Zero custom clang" 

RUN apk add --no-cache clang=${clangV} llvm=${llvmV} make bash \
  curl unzip openjdk11-jdk libc6-compat libstdc++ libgcc \
  libunwind libffi

RUN mkdir -p $NDK_HOME && \
  curl -L "https://dl.google.com/android/repository/android-ndk-${NDK_VERSION}-linux.zip" -o /tmp/ndk.zip && \
  unzip /tmp/ndk.zip -d $NDK_HOME && \
  rm /tmp/ndk.zip

ENV NDK_PATH=$NDK_HOME/android-ndk-${NDK_VERSION}
ENV TOOLCHAIN=$NDK_PATH/toolchains/llvm/prebuilt/linux-x86_64

ENV PATH="$TOOLCHAIN/bin:$PATH"

COPY docker-entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

RUN mkdir -p /app && \
  chmod -R 777 /app
WORKDIR /app

RUN adduser -D builder
USER builder

COPY . .

ENTRYPOINT ["/entrypoint.sh"]
