import 'dart:html';
import '../lib/dart_mv.dart';
import 'views.dart';

void main() {
  Model model = new Model();


  Map viewOptions = new Map();
  viewOptions['el'] = query('#view-01');
  viewOptions['model'] = model;
  ListView view = new ListView(viewOptions);

  List<String> userList = [];
  userList.add('bob');
  userList.add('joe');

  model.set('userList', userList);
}

