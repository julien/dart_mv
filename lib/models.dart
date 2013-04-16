part of dart_mv;

class Model {

  StreamController _streamCtrl = new StreamController();

  /// A map of attributes.
  Map _attributes = new Map();

  Model([Map attributes]) {
    if (attributes != null) {
      _attributes = attributes;
    }
  }

  Model set(String key, dynamic value) {
    var data;

    data = [];

    if (_attributes.containsKey(key)) {
      // "Nulling" the value means removing the
      // attribute
      if (value == null) {
        _attributes.remove(key);
        return this;
      }
      data.add({'key': key, 'oldValue': get(key), 'value': value });

    } else {
      data.add({'key': key, 'value': value });
    }

    _attributes[key] = value;

    _streamCtrl.add(data);
    return this;
  }

  get(String key) {
    if (_attributes.containsKey(key)) {
      return _attributes[key];
    }
  }

  void reset() => _attributes.clear();

  /// [] Operator overloading.
  operator [](String key) => get(key);

  toJSON() => JSON.stringify(_attributes);

  Stream get stream => _streamCtrl.stream.asBroadcastStream();
}
