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
          SpanElement span = new Element.html('<span>${name}</span>');
          span.classes.add('block');
          span.classes.add('green');
          span.onClick.listen(onSpanClick);
          el.append(span);
        }
      }
    }
  }

  onSpanClick(e) {
    print('ListView onSpanClick: ${e.currentTarget}');
  }

  onModelChange(e) {
    print('ListView onModelChange: ${e.data}');
    render();
  }

  void initialize() {

    // Check Model existence and set up event listeners.
    if (model != null) {
      model.on.change.add(onModelChange);
    }
  }
}

