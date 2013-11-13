import '../lib/dart_mv.dart' as mv;
import 'views.dart';

void onRouteChange(List<String> args) {
  print('onRouteChanged: ${args.join(',')}');
}

void main() {
  var router, subscription, model, view, dataList;

  router = new mv.Router({
    '(\\w+)(\\d+)?': onRouteChange
  });

  // Can also listen for changes with Streams
  subscription = router.on('change').listen((value) {
    print('router onChange: ${value}');
  });
  subscription.onError((err) => print('value: ${err}'));

  model = new mv.Model();

  view = new ListView(
    id: '#view-01',
    data: model
  );

  dataList = [];
  dataList.add('JavaScript');
  dataList.add('Dart');
  dataList.add('TypeScript');
  dataList.add('CoffeeScript');
  dataList.add('LiveScript');

  model.set('dataList', dataList);
}

