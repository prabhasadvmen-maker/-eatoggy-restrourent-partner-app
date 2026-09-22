/// Separate dummy data model for the Splash screen.
class SplashModel {
  const SplashModel({
    required this.appTitle,
    required this.tagline,
    required this.versionInfo,
    required this.nextRoute,
    required this.logoAsset,
    this.delayMilliseconds = 2600,
  });

  final String appTitle;
  final String tagline;
  final String versionInfo;
  final String nextRoute;
  final String logoAsset;
  final int delayMilliseconds;

  /// Default dummy data representing the Eatoggy Restaurant Partner brand configuration.
  static const dummy = SplashModel(
    appTitle: 'EATOGGY',
    tagline: 'Your Kitchen Partner',
    versionInfo: 'v2.4.1 Premium Edition',
    nextRoute: '/login',
    logoAsset: 'assets/images/logo.png',
    delayMilliseconds: 2600,
  );

  SplashModel copyWith({
    String? appTitle,
    String? tagline,
    String? versionInfo,
    String? nextRoute,
    String? logoAsset,
    int? delayMilliseconds,
  }) {
    return SplashModel(
      appTitle: appTitle ?? this.appTitle,
      tagline: tagline ?? this.tagline,
      versionInfo: versionInfo ?? this.versionInfo,
      nextRoute: nextRoute ?? this.nextRoute,
      logoAsset: logoAsset ?? this.logoAsset,
      delayMilliseconds: delayMilliseconds ?? this.delayMilliseconds,
    );
  }
}
