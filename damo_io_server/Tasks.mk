.PHONY: install check dev

damo_io_server/install:
	cd damo_io_server; dart pub get

damo_io_server/check:
	cd damo_io_server; dart format lib --line-length 100 --set-exit-if-changed
	cd damo_io_server; dart test
	cd damo_io_server; dart run cyclic_dependency_checks .

damo_io_server/dev:
	cd damo_io_server; dart run dart_frog_cli:dart_frog dev
