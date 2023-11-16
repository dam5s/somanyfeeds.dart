.PHONY: damo_io_server/install damo_io_server/check damo_io_server/dev

damo_io_server/install:
	cd damo_io_server; dart pub global activate dart_frog_cli
	cd damo_io_server; dart pub get

damo_io_server/check:
	cd damo_io_server; dart format lib --line-length 100 --set-exit-if-changed
	cd damo_io_server; dart test
	cd damo_io_server; dart run cyclic_dependency_checks .

damo_io_server/dev:
	cd damo_io_server; dart_frog dev
