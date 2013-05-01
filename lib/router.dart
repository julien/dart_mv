part of dart_mv;

class Router {

  Streams _streams;

  Map<String, dynamic> routes;

  Router([Map<String, dynamic> this.routes]) {
    _streams = new Streams();

    window.onHashChange.listen(onHashChange);
  }

  void onHashChange(e) {
    var hash, args, route, regexp;
    hash = window.location.hash;
    hash = hash.substring(0, 1);
    args = [];

    for (route in routes.keys) {
      regexp = new RegExp(route);

      regexp.allMatches(hash).forEach((match) {
        args.add(match.str.substring(match.start, match.end));
      });

      _streams.add({ 'type:': 'change', 'route': route, 'args': args });

      if (routes[route] is Function) {
        routes[route](args);
        return;
      }
    }
  }

  Stream<Map> get on => _streams.on;
}



