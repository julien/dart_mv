part of dart_mv;




/// Model implementation
class Model extends EventEmitter {
  /// A map of attributes.
  Map _attributes = new Map();



  Model([Map attributes]) {
    // super();
    if (attributes != null) {
      _attributes = attributes;
    }
  }

  Map get attributes => _attributes;

  Model set(String key, dynamic value) {

    List<dynamic> data = [];

    if (_attributes.containsKey(key)) {
      _attributes[key] = value;

      data.add({
        'key': key,
        'oldValue': get(key),
        'value': value
      });

    } else {
      data.add({
        'key': key,
        'value': value
      });
    }
    _attributes[key] = value;

    emit('change', data);
    return this;
  }

  dynamic get(String key) {
    if (_attributes.containsKey(key)) {
      return _attributes[key];
    }
  }

  /// [] Operator overloading.
  operator [](String key) => get(key);
}