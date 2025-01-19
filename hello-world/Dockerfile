ARG alpineV=latest
FROM alpine:$alpineV

ARG clangV=19.1.4-r0
ENV clangV=$clangV
ARG llvmV=19.1.4-r0
ENV llvmV=$llvmV

LABEL maintainer="Zero <github.com/z-nerd>" 
LABEL description="Zero custom clang" 

RUN apk add --no-cache clang=${clangV} llvm=${llvmV} make

COPY docker-entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

RUN mkdir -p /app && \
  chmod -R 777 /app
WORKDIR /app

RUN adduser -D builder
USER builder

COPY . .

ENTRYPOINT ["/entrypoint.sh"]
