part of dart_mv;

class View {
  /// The default tag "name" for this view's element.
  const String DEFAULT_TAG = 'div';

  StreamController _streamCtrl = new StreamController();
  
  /// The options map, passed when initializing this view
  /// accepts an "el" and "tagName"
  /// property for now (will add more soon).
  Map _options = new Map();

  Element el;
  Model model;

  /**
   * Checks of our the passed "Element" exists, and
   * if not creates a new one.
   */
  void _ensureElement([Element e]) {
    var tag = _options.containsKey('tagName') ?
        _options['tagName'] : DEFAULT_TAG;

    el = (e is Element) ? e : new Element.tag(tag);
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
  void initialize() {  
    _streamCtrl.add({type: 'initialize'});  
  }

  Stream get stream => _streamCtrl.stream;
}


