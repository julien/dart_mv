import '../packages/unittest/unittest.dart';
import '../packages/unittest/html_enhanced_config.dart';
import 'dart:html';
import 'dart:json' as JSON;
import '../lib/dart_mv.dart';

void main() {
  useHtmlEnhancedConfiguration();

  group('models', () {
    var model;

    model = new Model();

    test('broadcasts when attribute added', () {
      var subscription = model.stream.listen(null);
      subscription.onData((value) {
        var data = value[0];

        expect(data.containsKey('key'), equals(true));
        expect(data['key'], equals('name'));
        expect(data.containsKey('value'), equals(true));
        expect(data['value'], equals('Dart'));

        subscription.cancel();
      });
      subscription.onError((err) => print('Error :${err}'));
      model.set('name', 'Dart');
    });

    test('broadcasts when attribute changes', () {
      var subscription = model.stream.listen(null);
      subscription.onData((value) {
        var data = value[0];

        expect(data.containsKey('key'), equals(true));
        expect(data['key'], equals('name'));
        expect(data.containsKey('value'), equals(true));
        expect(data['value'], equals('DartLang'));
        expect(data.containsKey('oldValue'), equals(true));
        expect(data['oldValue'], equals('Dart'));

        subscription.cancel();
      });
      subscription.onError((err) => print('Error :${err}'));
      model.set('name', 'DartLang');
    });

    test('remove an attribute', () {
      model.set('name', null);
      expect(model.get('name'), equals(null));
    });

    test('should have [] operator', () {
      model.set('name', 'DartLang');
      expect(model['name'], equals('DartLang'));
      model.set('target', 'Web');
      expect(model['target'], equals('Web'));
    });

    test('should return attributes as JSON', () {
      var m = new Model({'name': 'Dart'});
      expect(m.toJSON(), equals('{"name":"Dart"}'));
    });

     test('remove all attributes', () {
      model.reset();
      expect(model.toJSON(), equals('{}'));
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

    test('broadcasts an "initialize" event', () {
      var subscription = view.stream.listen(null), onData;
      onData = (value) {
        expect(value is Map, equals(true));
        subscription.cancel();
      };
      subscription.onData(onData);
    });

  });
}
