import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:restrorent_partner_app/main.dart';

void main() {
  testWidgets('App smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(
      const ProviderScope(
        child: EatoggyPartnerApp(),
      ),
    );
    expect(find.byType(EatoggyPartnerApp), findsOneWidget);
    // Advance timer past splash duration (2600ms)
    await tester.pump(const Duration(milliseconds: 3000));
    await tester.pumpAndSettle();
  });
}
