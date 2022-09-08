BINARY_PATH = ./.build/x86_64-apple-macosx/release/MagicIBCLI
VERSION = 0.0.1

.PHONY: release
release:
	mkdir -p release
	swift build -c release
	cp $(BINARY_PATH) release/magicib
	zip release/MagicIB_$(VERSION).zip release/magicib
