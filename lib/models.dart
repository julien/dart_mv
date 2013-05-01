part of dart_mv;

class Model {

  Streams _streams;

  /// A map of attributes.
  Map _attributes = new Map();

  Model([Map attributes]) {

    _streams = new Streams();

    if (attributes != null) {
      _attributes = new Map.from(attributes);
      _attributes.forEach((k, v) => set(k, v));
    }
  }

  Model set(String key, dynamic value) {
    var data;

    data = {};

    if (_attributes.containsKey(key)) {
      // "Nulling" the value means removing the
      // attribute
      if (value == null) {
        _attributes.remove(key);
        data = {'type': 'remove', 'key': key, 'value': value };
        _streams.add(data);
        return this;
      }

      if (_attributes[key] != value) {
        data = {'type': 'change', 'key': key, 'oldValue': get(key), 'value': value };
      }

    } else {
      data = {'type': 'add', 'key': key, 'value': value };
    }

    _attributes[key] = value;
    _streams.add(data);
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
  toJson() => JSON.stringify(_attributes);

  Map<String, dynamic> get attributes => _attributes;

  Stream<Map> get on => _streams.on;
}
