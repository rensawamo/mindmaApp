ビルド
```sh
$ flutter run --dart-define=FLAVOR=prd  
```

google 申請用の App Bundleの aab ビルド
```sh
$ flutter build  appbundle --dart-define=FLAVOR=prd --release

Font asset "MaterialIcons-Regular.otf" was tree-shaken, reducing it from 1645184 to 3208 bytes (99.8% reduction). Tree-shaking can be disabled by providing the --no-tree-shake-icons flag when building your app.
Running Gradle task 'bundleRelease'...                             91.2s
√ Built build\app\outputs\bundle\release\app-release.aab (23.3MB).
```


### ver 0.0.0
![screenshot_20240414-182518_720](https://github.com/rensawamo/mindmaApp/assets/106803080/99912d92-d239-4ab2-999a-01ac7c9ebcf3)
![screenshot_20240414-182538_720](https://github.com/rensawamo/mindmaApp/assets/106803080/48cc9f0f-7daa-4a91-ac88-2b2c41621e14)
![screenshot_20240414-183124_720](https://github.com/rensawamo/mindmaApp/assets/106803080/8a2181b2-f51a-4532-9621-62fa557d21fe)
![screenshot_20240414-183002_720](https://github.com/rensawamo/mindmaApp/assets/106803080/d2fa47a3-a277-431d-888e-7872e92f0bce)
