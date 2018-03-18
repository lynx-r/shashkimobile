import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class BoardPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var side = min(size.width, size.height / 2);
    var rect = new Offset(0.0, 0.0) & new Size(side, side);
    var paint = new Paint();
    paint.strokeWidth = 4.0;
    paint.color = new Color(0xFFAA00FF);
    paint.style = PaintingStyle.stroke;
    canvas.drawRect(rect, paint);

    var rows = 8;
    var squareWidth = side / rows;
    var squareSize = new Size(squareWidth, squareWidth);
    var paintSquare = new Paint();
    var black = new Color(0xFF000000);
    var white = new Color(0xFFFFFFFF);

//    for(var i = 0; i < rows; i++) {
//      for (var j = 0; j < rows; j++) {
//        paint.color = (j % 2 == 0) ? black : white;
//        var rect = new Offset(i * squareWidth, j * squareWidth) & squareSize;
//        print(rect);
//        canvas.drawRect(rect, paintSquare);
//      }
//    }
  }

  @override
  SemanticsBuilderCallback get semanticsBuilder {
    return (Size size) {
      // Annotate a rectangle containing the picture of the sun
      // with the label "Sun". When text to speech feature is enabled on the
      // device, a user will be able to locate the sun on this picture by
      // touch.
      var rect = Offset.zero & size;
      var width = size.shortestSide * 0.4;
      rect = const Alignment(0.8, -0.9).inscribe(new Size(width, width), rect);
      return [
        new CustomPainterSemantics(
          rect: rect,
          properties: new SemanticsProperties(
            label: 'Sun',
            textDirection: TextDirection.ltr,
          ),
        ),
      ];
    };
  }

  // Since this Sky painter has no fields, it always paints
  // the same thing and semantics information is the same.
  // Therefore we return false here. If we had fields (set
  // from the constructor) then we would return true if any
  // of them differed from the same fields on the oldDelegate.
  bool shouldRepaint(BoardPainter oldDelegate) => false;

  bool shouldRebuildSemantics(BoardPainter oldDelegate) => false;
}
