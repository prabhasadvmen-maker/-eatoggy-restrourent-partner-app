import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../features/splash/presentation/pages/splash_screen.dart';
import '../../features/auth/presentation/pages/login_screen.dart';
import '../../features/auth/presentation/pages/otp_screen.dart';
import '../../features/dashboard/presentation/pages/main_shell_screen.dart';
import '../../features/orders/presentation/pages/order_detail_screen.dart';
import '../../features/menu/presentation/pages/add_menu_item_screen.dart';

/// Route name constants — use these instead of raw strings.
abstract class AppRoutes {
  static const splash = '/';
  static const login = '/login';
  static const otp = '/otp';
  static const dashboard = '/dashboard';
  static const orderDetail = '/order-detail';
  static const addMenuItem = '/add-menu-item';
}

final GoRouter appRouter = GoRouter(
  initialLocation: AppRoutes.splash,
  debugLogDiagnostics: false,
  routes: [
    // ─── Splash ─────────────────────────────────────────────────────────────
    GoRoute(
      path: AppRoutes.splash,
      name: 'splash',
      builder: (context, state) => const SplashScreen(),
    ),

    // ─── Auth ────────────────────────────────────────────────────────────────
    GoRoute(
      path: AppRoutes.login,
      name: 'login',
      builder: (context, state) => const LoginScreen(),
    ),

    GoRoute(
      path: AppRoutes.otp,
      name: 'otp',
      builder: (context, state) {
        final phone = state.extra as String? ?? '';
        return OtpScreen(phoneNumber: phone);
      },
    ),

    // ─── Dashboard Shell ─────────────────────────────────────────────────────
    GoRoute(
      path: AppRoutes.dashboard,
      name: 'dashboard',
      builder: (context, state) => const MainShellScreen(),
    ),

    // ─── Order Detail ────────────────────────────────────────────────────────
    GoRoute(
      path: AppRoutes.orderDetail,
      name: 'orderDetail',
      builder: (context, state) {
        final orderId = state.extra as String? ?? '';
        return OrderDetailScreen(orderId: orderId);
      },
    ),

    // ─── Add Menu Item ───────────────────────────────────────────────────────
    GoRoute(
      path: AppRoutes.addMenuItem,
      name: 'addMenuItem',
      builder: (context, state) {
        final isEdit = state.extra as bool? ?? false;
        return AddMenuItemScreen(isEdit: isEdit);
      },
    ),
  ],

  // ─── Error page ─────────────────────────────────────────────────────────
  errorBuilder: (context, state) => Scaffold(
    body: Center(
      child: Text(
        'Page not found\n${state.error}',
        textAlign: TextAlign.center,
      ),
    ),
  ),
);
