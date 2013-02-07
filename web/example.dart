import 'dart:html';
import '../lib/dart_mv.dart' as mv;
import 'views.dart';


void onRouteChange(List<String> args) {
  print('onRouteChanged: ${args.join(',')}');
}

void initialize() {
  // print('initializing app');
  mv.Model model = new mv.Model();

  ListView view = new ListView({
    'el': query('#view-01'),
    'model': model
  });

  List<String> userList = [];
  userList.add('bob');
  userList.add('joe');
  model.set('userList', userList);
}

void main() {
  mv.Router router = new mv.Router({
    '(\\w+)(\\d+)?': onRouteChange
  });
  router.initialize = initialize;
}

