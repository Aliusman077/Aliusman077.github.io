import 'package:flutter_test/flutter_test.dart';

import 'package:aliusman_portfolio/main.dart';

void main() {
  testWidgets('Portfolio shows title', (WidgetTester tester) async {
    await tester.pumpWidget(const PortfolioApp());
    await tester.pump();

    expect(find.textContaining('Ali Usman'), findsWidgets);
  });
}
