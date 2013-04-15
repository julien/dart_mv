library views;

import 'dart:html';
import '../lib/dart_mv.dart';

class ListView extends View {
  ListView([Map options]) : super(options);

  void render() {
    var userList, name, span;

    if (model != null) {
      el.innerHtml = '';

      if (model.get('userList') != null) {

        userList = model.get('userList');

        for (name in userList) {
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
    target = e.currentTarget;
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

  void onModelChange(e) {
    render();
  }

  void initialize() {
    // Check Model existence and set up event listeners.
    if (model != null) {
      model.stream.listen(onModelChange);
    }
  }
}

