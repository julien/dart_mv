library views;

import 'dart:html';
import '../lib/dart_mv.dart';

class ListView extends View {

  Model model;

  ListView({String id, dynamic data}) : super(id: id) {
    model = data as Model;
    if (model != null) {
      model.on.listen((e) => render());
    }
  }

  void render() {
    var dataList, name, span;

    if (model != null) {
      el.innerHtml = '';

      if (model.get('dataList') != null) {

        dataList = model.get('dataList');

        for (name in dataList) {
          span = new Element.html('<span>${name}</span>')
            ..classes.add('block')
            ..classes.add('viewing')
            ..onClick.listen(onSpanClick)
            ..onBlur.listen(onSpanBlur);
          el.append(span);
        }
      }
    }
  }

  void onSpanBlur(e) {
    var target = e.currentTarget as Element;
    target.contentEditable = 'inherit';
    target.classes.remove('editing');
    target.classes.add('viewing');
  }

  void onSpanKeyDown(KeyboardEvent e) {
    var target, index, userList;
    target = e.currentTarget as Element;
    index = el.children.indexOf(target);

    if (e.keyCode == KeyCode.ENTER) {

      target.contentEditable = 'inherit';
      target.classes.remove('editing');
      target.classes.add('viewing');

      userList = model.get('userList');
      userList[index] = target.innerHtml;
      model.set('userList', userList);
    }
  }

  void onSpanClick(e) {
    var target = e.currentTarget as Element;
    if (target.contentEditable != 'true') {
      target.contentEditable = 'true';
      target.classes.remove('viewing');
      target.classes.add('editing');
      target.onKeyDown.listen(onSpanKeyDown);
    }
  }

}

