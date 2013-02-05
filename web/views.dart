library views;

import 'dart:html';
import '../lib/dart_mv.dart';


class ListView extends View {
  ListView([Map options]) : super(options);

  onSpanClick(e) {
    print('ListView onSpanClick $e');
  }

  void initialize() {
    List<SpanElement> spans = el.queryAll('span');
    spans.forEach((span) {
      span.onClick.listen(onSpanClick);
    });
  }
}

