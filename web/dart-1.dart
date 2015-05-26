// Copyright (c) 2015, <your name>. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.
library react;

import 'dart:async';
import 'dart:html' as html;
import 'dart:math';
import 'dart:js';

final BoxesView = context['React'].callMethod('createClass', [
  newJsObj()
    ..['render'] = new JsFunction.withThis((JsObject jsThis) {
      var N = 250;
      var boxes = new JsArray();
      var propsCount = jsThis['props']['count'];
      for (var i = 0; i < N; i++) {
        var count = propsCount + i;
        boxes.add(context['React']['DOM'].callMethod('div', [
          newJsObj()
            ..['className'] = 'box-view'
            ..['key'] = i,
          new JsArray.from([
            context['React']['DOM'].callMethod('div', [
              newJsObj()
                ..['className'] = 'box'
                ..['style'] = (newJsObj()
                  ..['top'] = sin(count / 10) * 10
                  ..['left'] = cos(count / 10) * 10
                  ..['background'] = 'rgb(0, 0,${count % 255})'),
              count % 100
            ])
          ])
        ]));
      }
      return context['React']['DOM'].callMethod('div', [null, boxes]);
    })
]);

var counter = 0;
reactAnimate() {
  context['React'].callMethod('render', [
    context['React'].callMethod(
        'createElement', [BoxesView, newJsObj()..['count'] = counter++]),
    html.document.getElementById('example-container')
  ]);
  new Timer(Duration.ZERO, reactAnimate);
}

main() {
  new Timer(Duration.ZERO, reactAnimate);
}
final _obj = context['Object'];
JsObject newJsObj() => new JsObject(_obj);
