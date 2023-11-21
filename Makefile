.PHONY: setup install format test cyclic_dependency_checks check dev

setup:
	dart pub get
	dart pub global activate melos
	dart pub global activate dart_frog_cli
	melos bootstrap

install:
	melos run install

format:
	melos run format

test:
	melos test

cyclic_dependency_checks:
	dart run cyclic_dependency_checks -p packages/async_support
	dart run cyclic_dependency_checks -p packages/networking_support
	dart run cyclic_dependency_checks -p packages/prelude
	dart run cyclic_dependency_checks -p apps/damo_io_server
	dart run cyclic_dependency_checks -p apps/damo_io_frontend

check: format test cyclic_dependency_checks

dev:
	melos run dev
