### ver 0.0.0
- iOS:    firebaset storageが導入前で一旦導入したい
以下で　　ログイン機能いらないって言われるから,splashの後、home画面に飛ばす
Guideline 5.1.1(v) - Data Collection and Storage
5.1.1(v) Account Sign-In If your app doesn’t include significant account-based features, let people use it without a login. If your app supports account creation, you must also offer account deletion within the app. Apps may not require users to enter personal information to function, except when directly relevant to the core functionality of the app or required by law. If your core app functionality is not related to a specific social network (e.g. Facebook, WeChat, Weibo, Twitter, etc.), you must provide access without a login or via another mechanism. Pulling basic profile information, sharing to the social network, or inviting friends to use the app are not considered core app functionality. The app must also include a mechanism to revoke social network credentials and disable data access between the app and social network from within the app. An app may not store credentials or tokens to social networks off of the device and may only use such credentials or tokens to directly connect to the social network from the app itself while the app is in use.

Issue Description

- Andoroid:   テスターがめっちゃ数多く必要だから、iosでアップデートをある程度繰り返した後に テスター作業を発注してからリリースする方針とした。
