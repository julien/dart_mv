library views;

import 'dart:html';
import '../lib/dart_mv.dart';


class ListView extends View {
  ListView([Map options]) : super(options);

  void render() {
    if (model != null) {
      el.innerHtml = '';

      if(model.attributes.containsKey('userList')) {
        List<String> userList = model.attributes['userList'];
        for (String name in userList) {
          SpanElement span = new Element.html('<span>${name}</span>')
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
    Element target = e.currentTarget as Element;
    target.contentEditable = 'inherit';
    target.classes.remove('editing');
    target.classes.add('viewing');
  }

  void onSpanKeyDown(KeyboardEvent e) {
    Element target = e.currentTarget as Element;
    int index = el.children.indexOf(target);

    if (e.keyCode == KeyCode.ENTER) {

      target.contentEditable = 'inherit';
      target.classes.remove('editing');
      target.classes.add('viewing');

      List<String> userList = model.get('userList');
      userList[index] = target.innerHtml;
      model.set('userList', userList);
    }
  }

  void onSpanClick(e) {
    // print('ListView onSpanClick: ${e.currentTarget}');
    Element target = e.currentTarget as Element;

    if (target.contentEditable != 'true') {
      target.contentEditable = 'true';
      target.classes.remove('viewing');
      target.classes.add('editing');
      target.onKeyDown.listen(onSpanKeyDown);
    }
  }

  void onModelChange(e) {
    // print('ListView onModelChange: ${e.data}');
    render();
  }

  void initialize() {
    // Check Model existence and set up event listeners.
    if (model != null) {
      model.on.change.add(onModelChange);
    }
  }
}

