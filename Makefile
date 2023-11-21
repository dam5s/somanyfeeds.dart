.PHONY: install format test cyclic_dependency_checks check dev

install:
	cd packages/async_support; dart pub get
	cd packages/networking_support; dart pub get
	cd packages/prelude; dart pub get
	cd apps/damo_io_server; dart pub global activate dart_frog_cli
	cd apps/damo_io_server; dart pub get
	cd apps/damo_io_frontend; dart pub get

format:
	cd packages/async_support; dart format lib --line-length 100 --set-exit-if-changed
	cd packages/networking_support; dart format lib --line-length 100 --set-exit-if-changed
	cd packages/prelude; dart format lib --line-length 100 --set-exit-if-changed
	cd apps/damo_io_server; dart format lib --line-length 100 --set-exit-if-changed
	cd apps/damo_io_frontend; dart format lib --line-length 100 --set-exit-if-changed

test:
	cd packages/async_support; dart test
	cd packages/networking_support; dart test
	cd packages/prelude; dart test
	cd apps/damo_io_server; dart test
	cd apps/damo_io_frontend; flutter test

cyclic_dependency_checks:
	cd packages/async_support; dart run cyclic_dependency_checks .
	cd packages/networking_support; dart run cyclic_dependency_checks .
	cd packages/prelude; dart run cyclic_dependency_checks .
	cd apps/damo_io_server; dart run cyclic_dependency_checks .
	cd apps/damo_io_frontend; dart run cyclic_dependency_checks .

check: format test cyclic_dependency_checks

dev:
	cd apps/damo_io_server; dart_frog dev
