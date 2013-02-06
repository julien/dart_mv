import 'dart:html';
import '../packages/unittest/unittest.dart';
// import '../packages/unittest/html_enhanced_config.dart';
import '../lib/dart_mv.dart';

void main() {
  // this fails ...
  // useHtmlEnhancedConfiguration();

  group('model tests', () {
    Model model = new Model();
    bool dispatched = false;

    void onModelChange(e) {
      dispatched = true;
    }


    test('models shoud dispatch a "change" when attributes are set event', () {
      model.set('name', 'Dart');
      expect(model.get('name'), equals('Dart'));
    });
  });

}