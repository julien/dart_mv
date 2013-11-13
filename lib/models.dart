part of dart_mv;

class Model {

  EventEmitter _emitter;

  /// A map of attributes.
  Map _attributes = new Map();

  Model([Map attributes]) {

    _emitter = new EventEmitter();

    if (attributes != null) {
      _attributes = new Map.from(attributes);
      _attributes.forEach((k, v) => set(k, v));
    }
  }

  Model set(String key, dynamic value) {
    var data, type;

    data = {};

    if (_attributes.containsKey(key)) {
      // "Nulling" the value means removing the
      // attribute
      if (value == null) {
        _attributes.remove(key);
        data = {'key': key, 'value': value };
        _emitter.publish('remove', data);
        return this;
      }

      if (_attributes[key] != value) {
        data = {'key': key, 'oldValue': get(key), 'value': value };
        type = 'change';
      }

    } else {
      data = {'key': key, 'value': value };
      type = 'add';
    }

    _attributes[key] = value;
    _emitter.publish(type, data);
    return this;
  }

  get(String key) {
    if (_attributes.containsKey(key)) {
      return _attributes[key];
    }
  }

  /// Resets all of the attributes
  void reset() => _attributes.clear();

  /// [] Operator overloading, to be
  /// able to use the model like and "array"
  /// for attributes access.
  operator [](String key) => get(key);

  /// Returns a [Model] created with
  /// 2 models who's attributes get merged.
  Model operator +(Model m) {
    m.attributes.forEach((key, value) {
      _attributes.putIfAbsent(key, () {
        return value;
      });
    });
    return new Model(_attributes);
  }

  /// Attributes as JSON string.
  toJson() => JSON.encode(_attributes);

  Map<String, dynamic> get attributes => _attributes;

  Stream on(String name) => _emitter.on(name);

}
