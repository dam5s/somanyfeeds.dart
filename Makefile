.PHONY: install format test cyclic_dependency_checks check dev

install:
	cd async_support; dart pub get
	cd networking_support; dart pub get
	cd prelude; dart pub get
	cd damo_io_server; dart pub global activate dart_frog_cli
	cd damo_io_server; dart pub get
	cd damo_io_frontend; dart pub get

format:
	cd async_support; dart format lib --line-length 100 --set-exit-if-changed
	cd networking_support; dart format lib --line-length 100 --set-exit-if-changed
	cd prelude; dart format lib --line-length 100 --set-exit-if-changed
	cd damo_io_server; dart format lib --line-length 100 --set-exit-if-changed
	cd damo_io_frontend; dart format lib --line-length 100 --set-exit-if-changed

test:
	cd async_support; dart test
	cd networking_support; dart test
	cd prelude; dart test
	cd damo_io_server; dart test
	cd damo_io_frontend; flutter test

cyclic_dependency_checks:
	cd async_support; dart run cyclic_dependency_checks .
	cd networking_support; dart run cyclic_dependency_checks .
	cd prelude; dart run cyclic_dependency_checks .
	cd damo_io_server; dart run cyclic_dependency_checks .
	cd damo_io_frontend; dart run cyclic_dependency_checks .

check: format test cyclic_dependency_checks

dev:
	cd damo_io_server; dart_frog dev
