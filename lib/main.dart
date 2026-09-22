import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sizer/sizer.dart';
import 'core/router/app_router.dart';
import 'core/theme/app_theme.dart';

final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey =
    GlobalKey<ScaffoldMessengerState>();
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    const ProviderScope(
      child: EatoggyPartnerApp(),
    ),
  );
}

/// Root widget for Eatoggy Restaurant Partner App.
class EatoggyPartnerApp extends StatelessWidget {
  const EatoggyPartnerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, screenType) {
        return MaterialApp.router(
          title: 'Eatoggy Partner',
          debugShowCheckedModeBanner: false,
          theme: AppTheme.darkTheme,
          routerConfig: appRouter,
        );
      },
    );
  }
}
