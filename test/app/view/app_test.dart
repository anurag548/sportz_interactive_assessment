import 'package:flutter_test/flutter_test.dart';
import 'package:sportz_interactive_assessment/app/app.dart';
import 'package:sportz_interactive_assessment/counter/counter.dart';

void main() {
  group('App', () {
    testWidgets('renders CounterPage', (tester) async {
      await tester.pumpWidget(const App());
      expect(find.byType(CounterPage), findsOneWidget);
    });
  });
}
