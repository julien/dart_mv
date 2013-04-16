import 'dart:html';
import '../lib/dart_mv.dart' as mv;
import 'views.dart';

void onRouteChange(List<String> args) {
  print('onRouteChanged: ${args.join(',')}');
}

void main() {
  var router, subscription, model, view, userList;

  router = new mv.Router({
    '(\\w+)(\\d+)?': onRouteChange
  });

  // Can also listen for changes with Streams
  subscription = router.stream.listen(null);
  subscription.onData((value) {
    print('onData: ${value}');
  });
  subscription.onError((err) => print('value: ${err}'));


  model = new mv.Model();

  view = new ListView({
    'el': query('#view-01'),
    'model': model
  });

  userList = [];
  userList.add('bob');
  userList.add('joe');

  model.set('userList', userList);
}

