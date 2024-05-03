.PHONY: clean-get
clean-get:
	flutter clean && flutter pub get && cd ios/ && pod install



.PHONY: build-ios-prd
build-ios-prd:
	cd ios/ && pod install && cd ..
	flutter build ios --release --no-codesign  --dart-define=FLAVOR=prd --target lib/main.dart


.PHONY: upload-ios-prd
cd ios && fastlane ios prod_upto_appstore
.DEFAULT_GOAL := help

.PHONY: help
help:
	@grep -E '^[a-zA-Z_-]+:.*?# .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":[^#]*? #| #"}; {printf "%-57s%s\n", $$1 $$3, $$2}'

# Bootstrap
.PHONY: dev
dev:
    flutter run --dart-define-from-file=dart_defines/prd.json

