BINARY_PATH = ./.build/x86_64-apple-macosx/release/MagicIBCLI
VERSION = 0.0.1

.PHONY: release
release:
	mkdir -p releases
	swift build -c release
	cp $(BINARY_PATH) magicib
	tar acvf releases/MagicIB_$(VERSION).tar.gz magicib
	cp magicib releases/magicib
	rm magicib
