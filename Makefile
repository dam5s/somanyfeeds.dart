.PHONY: setup check

setup:
	dart pub get
	dart pub global activate melos
	dart pub global activate dart_frog_cli
	melos bootstrap

check:
	melos run format
	melos test
	melos run cyclic_dependency_checks
