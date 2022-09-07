BINARY_PATH = ./.build/x86_64-apple-macosx/release/MagicIBCLI
.PHONY: run
run:
	mkdir -p release
	swift build -c release
	cp $(BINARY_PATH) release/magicib
	./release/magicib /Users/shibuya/Swift-Application/MyPackage/IBLinkTest
