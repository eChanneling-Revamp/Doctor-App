/// ZEGOCLOUD configuration for teleconsultation.
///
/// In production, DO NOT ship `appSign` in the client. Use a token server and
/// pass the `token` to the SDK instead. This file reads values from
/// --dart-define so you can run locally without committing secrets.
///
/// Example run (local only):
/// flutter run \
///   --dart-define=ZEGO_APP_ID=123456789 \
///   --dart-define=ZEGO_APP_SIGN=your_app_sign
///
/// For production: set only ZEGO_APP_ID and fetch token from your backend.
class ZegoConfig {
  /// Your ZEGOCLOUD AppID. Required.
  static const int appId = int.fromEnvironment('1061345971', defaultValue: 0);

  /// Development-only appSign (avoid using in production).
  static const String appSign = String.fromEnvironment('718c5d4aa48289b1d9b4786a347723cf600566c4884555ae8c9dbbaddb2d935b', defaultValue: '');

  /// Whether we should fetch a token from backend instead of using appSign.
  /// If `ZEGO_USE_TOKEN=true` is provided, we prefer token flow.
  static const bool useToken = bool.fromEnvironment('ZEGO_USE_TOKEN', defaultValue: true);

  /// Base URL of your token server (set via --dart-define). Example:
  /// --dart-define=ZEGO_TOKEN_SERVER=https://your.api/tokens
  static const String tokenServer = String.fromEnvironment('3be748d51d64e19c7a8631cafdbeaa21', defaultValue: '');
}
