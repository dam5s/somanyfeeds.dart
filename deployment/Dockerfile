FROM dart:stable AS build

WORKDIR /workspace

COPY . .

RUN dart pub get
RUN dart pub global activate melos
RUN melos bootstrap

WORKDIR /workspace/apps/damo_io_server

RUN mkdir /build
RUN dart compile exe bin/server.dart -o /build/server

FROM scratch

COPY --from=build /runtime/ /
COPY --from=build /build/server /app/server
COPY --from=build /workspace/apps/damo_io_server/public /app/public/

WORKDIR /app

CMD ["./server"]
