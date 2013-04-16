import '../packages/unittest/unittest.dart';
import 'dart:json' as JSON;
import '../lib/models.dart';

void main() {

  group('mv.Model', () {
    var model;
    model = new Model();

    test('add new attributes', () {
      model.set('name', 'Dart');
      model.set('description', 'Structured Web Apps');
      
      expect(model.get('name'), equals('Dart'));
      expect(model.get('description'), equals('Structured Web Apps'));
    });

    test('change exsting attributes', () {
      model.set('name', 'DartLang');
      model.set('description', 'none');

      expect(model.get('name'), equals('DartLang'));
      expect(model.get('description'), equals('none'));
    });

    test('remove an attribute', () {
      model.set('name', null);
      model.set('description', null);

      expect(model.get('name'), equals(null));    
      expect(model.get('description'), equals(null));    
    });

    test('should have [] operator', () {
      model.set('name', 'DartLang');
      model.set('target', 'Web');

      expect(model['name'], equals('DartLang'));
      expect(model['target'], equals('Web'));
    });

    test('should return attributes as JSON', () {
      expect(model.toJSON(), equals('{"target":"Web","name":"DartLang"}'));
    });

     test('remove all attributes', () {
      model.reset();
      expect(model.toJSON(), equals('{}'));
    });

    
    test('broadcast events when attribute added or changed', () {
      var subscription = model.stream.listen(null);
      
      subscription.onData((value) {
        var data = value[0];

        expect(data.containsKey('key'), equals(true));
        expect(data.containsKey('value'), equals(true));
        expect(data['key'], equals('version'));
        expect(data['value'], equals('0.0.x'));

        subscription.cancel();
      });
      model.set('version', '0.0.x');
    });

    test('broadcasts when attribute changes', () {
      var subscription = model.stream.listen(null);
      
      subscription.onData((value) {
        var data = value[0];

        expect(data.containsKey('key'), equals(true));
        expect(data.containsKey('value'), equals(true));
        expect(data.containsKey('oldValue'), equals(true));

        expect(data['key'], equals('version'));
        expect(data['value'], equals('0.0.z'));
        expect(data['oldValue'], equals('0.0.x'));

        subscription.cancel();
      });
      model.set('version', '0.0.z');
    });

  });
}
