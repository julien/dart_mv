import 'dart:html';
import '../lib/dart_mv.dart';
import 'views.dart';

void main() {

  Model model = new Model();
  model.on.change.add((e) {
    print('model change: ${e.data}');
  });
  model.set('name', 'bob');
  model.set('name', 'joe');


  Map viewOptions = new Map();
  viewOptions['el'] = query('#view-01');

  ListView view = new ListView(viewOptions);
}

