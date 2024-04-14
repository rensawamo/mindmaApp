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