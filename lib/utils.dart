part of dart_mv;

class Streams {

  StreamController<dynamic> _controller;

  Streams() {
    _controller = new StreamController(
      onCancel: _onCancel
    );
  }

  void _onCancel() {
    print('onCancel');
  }

  void add(dynamic data) {
    var active = !_controller.isClosed || !_controller.isPaused;

    if (_controller.hasListener && active) {
      _controller.add(data);
    }
  }

  Stream get on => _controller.stream.asBroadcastStream();
}
