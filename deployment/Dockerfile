FROM dart:stable AS build

WORKDIR /workspace

COPY . .

RUN dart pub get
RUN dart pub global activate melos
RUN melos bootstrap

WORKDIR /workspace/apps/damo_io_server

RUN mkdir /build
RUN dart compile exe main.dart -o /build/server

FROM scratch

COPY --from=build /runtime/ /
COPY --from=build /build/server /app/server
COPY --from=build /workspace/apps/damo_io_server/public /app/public/
COPY --from=build /workspace/apps/damo_io_server/resources /app/resources/

WORKDIR /app

CMD ["./server"]
