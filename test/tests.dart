import 'dart:html';
import '../packages/unittest/unittest.dart';
import '../packages/unittest/html_enhanced_config.dart';
import '../lib/dart_mv.dart';

void main() {

  useHtmlEnhancedConfiguration();

  group('model tests', () {
    Model model = new Model();
    bool dispatched = false;

    test('models shoud dispatch a "change" when attributes are set event', () {
      model.onChange.listen((data) => dispatched = true );
      model.set('name', 'Dart');
      expect(model.get('name'), equals('Dart'));
      expect(dispatched, equals(true));
    });


  });

}
