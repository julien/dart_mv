import '../packages/unittest/unittest.dart';
import '../packages/unittest/html_enhanced_config.dart';
import 'dart:html';
import 'dart:json' as JSON;
import '../lib/dart_mv.dart';

void main() {
  useHtmlEnhancedConfiguration();

  group('models', () {

    test('broadcasts when attribute added', () {
      var model, subscription;
      model = new Model();
      subscription = model.on('add').listen(null);
      subscription.onData((Map value) {
        expect(value.containsKey('key'), equals(true));
        expect(value['key'], equals('name'));
        expect(value.containsKey('value'), equals(true));
        expect(value['value'], equals('Dart'));
        subscription.cancel();
      });

      subscription.onError((err) => print('Error :${err}'));
      model.set('name', 'Dart');
    });

    test('broadcasts when attribute changes', () {
      var model, subscription;
      model = new Model();
      subscription = model.on('change').listen(null);
      subscription.onData((value) {
        expect(value.containsKey('key'), equals(true));
        expect(value['key'], equals('name'));
        expect(value.containsKey('value'), equals(true));
        expect(value['value'], equals('DartLang'));
        expect(value.containsKey('oldValue'), equals(true));
        expect(value['oldValue'], equals('Dart'));

        subscription.cancel();
      });
      subscription.onError((err) => print('Error :${err}'));
      model.set('name', 'Dart');
      model.set('name', 'DartLang');
    });

    test('remove an attribute', () {
      var model = new Model();
      model.set('name', null);
      expect(model.get('name'), equals(null));
    });

    test('should have [] operator', () {
      var model = new Model();
      model.set('name', 'DartLang');
      expect(model['name'], equals('DartLang'));
      model.set('target', 'Web');
      expect(model['target'], equals('Web'));
    });

    test('should return attributes as JSON', () {
      var model = new Model({'name': 'Dart'});
      expect(model.toJson(), equals('{"name":"Dart"}'));
    });

     test('remove all attributes', () {
      var model = new Model();
      model.reset();
      expect(model.toJson(), equals('{}'));
    });
  });

  group('views', () {
    var view = new View();

    test('creates an element', () {
      expect(view.el != null, equals(true));
    });

    test('element is an instance of DivElement', () {
      expect(view.el is DivElement, equals(true));
    });

    test('element "tagName" is "div"', () {
      expect(view.el.tagName.toLowerCase(), equals('div'));
    });

  });
}
