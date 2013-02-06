part of dart_mv;

class Router {
  Map<String, dynamic> _routes = new Map<String, dynamic>();

  void _initialize() {
    window.onHashChange.listen(onHashChange);
  }

  Router([Map<String, dynamic> routes]) {
    if (?routes) {
      _routes = routes;
    }
    _initialize();
  }

  get routes => _routes;

  onHashChange(e) {
    String hash = window.location.hash;
    hash = hash.slice(1);
    List<String> args = new List<String>();

    for (String route in _routes.keys) {
      RegExp regexp = new RegExp(route);
      regexp.allMatches(hash).forEach((Match match) {
        args.add(match.str.substring(match.start, match.end));
      });
      if (_routes[route] is Function) {
        _routes[route](args);
        return;
      }
    }
  }
}



