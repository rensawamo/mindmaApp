
.PHONY: clean-get
clean-get:
	flutter clean && flutter pub get && cd ios/ && pod install 



.PHONY: build-ios-prd
build-ios-prd:
	cd ios/ && pod install && cd ..
	flutter build ios --release --no-codesign  --dart-define=FLAVOR=prd --target lib/main.dart


.PHONY: upload-ios-prd
cd ios && fastlane ios prod_upto_appstore
