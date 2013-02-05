part of dart_mv;

/// Events implementation
class ModelEvent extends BaseEvent {
  String type;
  dynamic data;

  ModelEvent(this.type,[this.data]);
}

class ModelEventListenerList extends BaseEventListenerList { }

class ModelEvents extends BaseEvents {

  ModelEventListenerList _change = new ModelEventListenerList();

  EventListenerList operator [] (String type) {
    if (type == 'change') return _change;

    return new ModelEventListenerList();
  }

  ModelEventListenerList get change => _change;
}

/// Model implementation
class Model {
  /// A map of attributes.
  Map _attributes = new Map();

  /**
   *  A ModelEvents instance allowing
   *  to dispatch and listen for changes
   */
  ModelEvents on = new ModelEvents();

  Model([Map attributes]) {
    if (attributes != null) {
      _attributes = attributes;
    }
  }

  Map get attributes => _attributes;

  Model set(String key, dynamic value) {

    ModelEvent event = new ModelEvent('change');

    if (_attributes.containsKey(key)) {
      _attributes[key] = value;

      event.data = {
        'key': key,
        'oldValue': get(key),
        'value': value
      };

    } else {
      event.data = {
        'key': key,
        'value': value
      };
    }
    _attributes[key] = value;
    on.change.dispatch(event);
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