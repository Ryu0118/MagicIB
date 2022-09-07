BINARY_PATH = ./.build/x86_64-apple-macosx/release/MagicIBCLI
.PHONY: release
release:
	mkdir -p release
	swift build -c release
	cp $(BINARY_PATH) release/magicib
