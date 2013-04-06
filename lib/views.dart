part of dart_mv;

class View {
  /// A StreamController for this view
  StreamController _streamCtrl = new StreamController();

  /// The default tag "name" for this view's element.
  const String DEFAULT_TAG = 'div';

  /// The Element of this view.
  Element _el;
  /// The options map, passed when initializing this view
  /// accepts an "el" and "tagName"
  /// property for now (will add more soon).
  Map _options = new Map();

  /// The Model for this view.
  Model _model;

  /**
   * Checks of our the passed "Element" exists, and
   * if not creates a new one.
   */
  void _ensureElement([Element el]) {
    String tag = _options.containsKey('tagName') ?
        _options['tagName'] : DEFAULT_TAG;

    if (el is Element) {
      _el = el;
    } else if (el == null) {
      _el = new Element.tag(tag);
    }
  }


  View([Map options]) {
    if (?options) {
      _options = options;
    }
    _options.containsKey('el') ?
        _ensureElement(_options['el']) : _ensureElement();

    if (_options.containsKey('model')) {
      if (_options['model'] is Model) {
        model = _options['model'];
      }
    }
    initialize();
  }

  /**
   *  This method should be overwritten in subclasses.
   *  This is where subclasses setup event listeners, etc...
   */
  void initialize() { }

  /**
   * Returns the element of this view.
   */
  Element get el  => _el;

  /**
   * Sets the model for this view.
   */
  void set model(Model value) {
    if (_model != value) {
      _model = value;
    }
  }

  /**
   * Returns the model for this view.
   */
  Model get model => _model;

  Stream get stream => _streamCtrl.stream;
}


