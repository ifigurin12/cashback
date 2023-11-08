import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:cashback_info/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('AddCardTest', () {
    testWidgets("test login form ", (WidgetTester tester) async {
      app.main();

      await tester.pump();

      await tester.tap(find.byIcon(Icons.add));

      await tester.pump();

      await tester.enterText(find.widgetWithText(TextFormField, 'Введите название карты'), 'test1');

      await tester.pump();

      // await tester.tap(find.widgetWithText(DropdownMenuItem, 'Duty Free'));
      // await tester.tap(find.widgetWithText(DropdownMenuItem, 'Авиабилеты'));

      // await tester.pump();

      // await tester.tap(find.widgetWithText(DropdownMenuItem, 'Duty Free'));
      // await tester.tap(find.widgetWithText(DropdownMenuItem, 'Аренда Авто'));

      // await tester.pump();

      // await tester.tap(find.widgetWithText(DropdownMenuItem, 'Duty Free'));
      // await tester.tap(find.widgetWithText(DropdownMenuItem, 'Автоуслуги'));

      // await tester.pump();

      // tester.tap(find.byType(ElevatedButton));

      // await tester.pump();

      // final successSnackBarAct = find.widgetWithText(SnackBar, 'Карта успешно добавлена');

      // expect(successSnackBarAct, findsOneWidget);
    });
  });
}
