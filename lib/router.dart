part of dart_mv;

class Router {

  StreamController _streamCtrl = new StreamController.broadcast();
  Map<String, dynamic> routes;

  Router([Map<String, dynamic> this.routes]) {
    window.onHashChange.listen(onHashChange);
  }

  void onHashChange(e) {
    var hash, args, route, regexp;
    hash = window.location.hash;
    hash = hash.slice(1);
    args = [];

    for (route in routes.keys) {
      regexp = new RegExp(route);
      
      regexp.allMatches(hash).forEach((match) {
        args.add(match.str.substring(match.start, match.end));
      });

      _streamCtrl.add({ 'route': route, 'args': args });

      if (routes[route] is Function) {
        routes[route](args);
        return;
      }
    }
  }

  Stream get stream => _streamCtrl.stream;
}



