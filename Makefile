.PHONY: setup check dev container

setup:
	dart pub get
	dart pub global activate melos
	dart pub global activate jaspr_cli
	melos bootstrap

check:
	melos run format
	melos test
	melos run cyclic_dependency_checks

dev:
	cd apps/damo_io_server; USE_HOTRELOAD=true dart run --enable-vm-service bin/server.dart

container:
	docker build -t damo_io -f deployment/Dockerfile .
