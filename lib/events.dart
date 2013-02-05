part of dart_mv;

/// Event implementation.
abstract class BaseEvent implements Event {
  bool bubbles = false;
  bool cancelable = false;
  bool cancelBubble = false;
  Clipboard clipboardData;
  EventTarget currentTarget;
  bool defaultPrevented = false;
  int eventPhase;
  bool returnValue = false;
  EventTarget target;
  int timeStamp;
  void $dom_initEvent(String _a, bool _b, bool _c) {}
  void preventDefault() {}
  void stopImmediatePropagation() {}
  void stopPropagation() {}
}

/// Events implementation.
abstract class BaseEvents implements Events {}

/// EventListenerList implementation.
abstract class BaseEventListenerList implements EventListenerList {
  var listeners = [];

  add(fn, [bool useCapture=false]) {
    listeners.add(fn);
  }

  EventListenerList remove(EventListener listener, [bool useCapture=false]) {
    throw new UnsupportedError("Planned in a future release");
  }

  bool dispatch(Event event) {
    listeners.forEach((fn) { fn(event); });
    return true;
  }
}