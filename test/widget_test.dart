import 'package:flutter_test/flutter_test.dart';

import 'package:aliusman_portfolio/main.dart';

void main() {
  testWidgets('Portfolio shows title', (WidgetTester tester) async {
    await tester.pumpWidget(const PortfolioApp());
    // Ambient hero gradient repeats forever; avoid pumpAndSettle.
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 800));

    expect(find.textContaining('Ali Usman'), findsWidgets);
  });
}
