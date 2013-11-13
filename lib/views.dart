part of dart_mv;

class View {
  static const String DEFAULT_TAG = 'div';

  Element _el;
  EventEmitter _emitter;

  dynamic data;

  Element _createElement([String id = '', String tagName = '', String className = '']) {
    var tag;
    if (id != null && querySelector(id) != null) {
      _el = querySelector(id);
    } else {
      tag = (tagName == null) ? DEFAULT_TAG : tagName;
      _el = new Element.tag(tag);
      if (className != null) {
        _el.classes.add(className);
      }
    }
    return _el;
  }

  View({String id, String tagName, String className, dynamic this.data, String html}) {
    _createElement(id, tagName, className);

    if (html != null) {
      template(html);
    }
    _emitter = new EventEmitter();
  }

  View template(String html) {
    var element, fragment;
    element = new Element.html(html);
    fragment = document.createDocumentFragment();
    _el.append(fragment.append(element));
    return this;
  }

  /// Wrapper methods for the underlying [Element]
  /// might be removed ...
  void appendTo(Element parent) {
    var fragment;
    if (!document.body.contains(_el)) {
      fragment = document.createDocumentFragment();
      fragment.append(_el);
      parent.append(fragment);
    }
  }

  void remove() {
    _el.remove();
  }

  Element get el => _el;
  EventEmitter get emitter => _emitter;
}

