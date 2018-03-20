import 'dart:async';
import 'dart:math';
import 'dart:ui' as ui;
import 'package:flutter/painting.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:shashkimobile/model/board_box.dart';
import 'package:shashkimobile/model/rules.dart';
import 'package:shashkimobile/model/square.dart';

class BoardPainter extends CustomPainter {
  BoardPainter(this._images, this._boardBox) {
    _updateBoard();
  }

  static const ALPH = const {
    1: 'a',
    2: 'b',
    3: 'c',
    4: 'd',
    5: 'e',
    6: 'f',
    7: 'g',
    8: 'h',
    9: 'i',
    10: 'j',
  };

  int _boardDim;

  var _boardLength;

  List<Square> _squares;

  BoardBox _boardBox;

  Map<String, ui.Image> _images = {};

  @override
  void paint(Canvas canvas, Size size) {
    if (_boardBox == null)
      return;
    print(_images);
    var black = Colors.black54;
    var white = Colors.white70;
    var side = size.shortestSide;
    var numWidth = _boardDim > 9 ? 5.0 : 15.0;
    var shiftTop = 10.0;
    var shiftLeft = numWidth / 1.5;
    var squareWidth = (side / _boardDim);
    var textStyle = new TextStyle(color: Colors.black87, fontSize: 14.0);
    var rect = new Offset(squareWidth - shiftLeft, shiftTop) &
        new Size(side - squareWidth, side - squareWidth);
    var paint = new Paint();
    paint.strokeWidth = 2.0;
    paint.color = black;
    paint.style = PaintingStyle.stroke;
    canvas.drawRect(rect, paint);

    var squareSize = new Size(squareWidth, squareWidth);
    paint.style = PaintingStyle.fill;

    for (var i in _boardLength) {
      var square = _squares[i];
      if (square != null) {
        print(square.draught);
        paint.color = black;
        var h = square.h + 1;
        var v = square.v;
        var width = squareWidth * h - shiftLeft;
        var offset = new Offset(width, v * squareWidth + shiftTop);
        var rect = offset & squareSize;
        canvas.drawRect(rect, paint);
        var draught = square.draught;
        if (draught != null) {
          paint.color = draught.black ? black : white;
          var rang = draught.queen ? 'queen' : 'draught';
          var color = draught.black ? 'black' : 'white';
          var image = _images['${color}_$rang'];
          print(image);
          if (image == null)
            continue;
          var div = image.width / rect.width;
          var scale = 1 / div;
          canvas.translate(offset.dx, offset.dy);
          canvas.scale(scale, scale);
          canvas.drawImage(image, Offset.zero, paint);
          canvas.scale(div, div);
          canvas.translate(-offset.dx, -offset.dy);
        }
      } else {
        var t, offset;
        var h = i % _boardDim;
        if (h == 0 && (_boardLength.length - i) != _boardDim) {
          // num left
          var row = _boardDim - i / _boardDim - 1;
          t = new TextSpan(text: '${row.toInt()}', style: textStyle);
          var row0 = row - 1;
          var shiftBefore10For10Dim = (row < 10 ? (_boardDim >= 10 ? 5.0 : 0) : 0);
          offset = new Offset(shiftLeft + shiftBefore10For10Dim,
              row0 * squareWidth + squareWidth / 3.5 + shiftTop);
        }
        if (h != 0 && _boardLength.length - i <= _boardDim) {
          // ALPH bottom
          var col = (_boardLength.length - i - _boardDim) * -1;
          t = new TextSpan(text: ALPH[col], style: textStyle);
          offset = new Offset(col * squareWidth - shiftLeft + squareWidth / 2.5,
              squareWidth * (_boardDim - 1) + squareWidth / 6 + shiftTop);
        }
        if (t != null) {
          var painter =
              new TextPainter(text: t, textDirection: TextDirection.ltr);
          painter.layout();
          painter.paint(canvas, offset);
        }
      }
    }
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
  bool shouldRepaint(BoardPainter oldDelegate) => true;

  bool shouldRebuildSemantics(BoardPainter oldDelegate) => true;

  void _updateBoard() {
    if (_boardBox != null) {
      var rules = Rules.fromString(_boardBox.board.rules);
      _boardDim = rules.dimension + 1;
      _boardLength = Rules.getAllBoardLength(_boardDim);
      _squares = [];
      var index = 0;
      for (var v = 0; v < _boardDim; v++) {
        for (var h = 0; h < _boardDim; h++) {
          if (h == 0) {
            _squares.add(null);
          } else if (v == _boardDim - 1) {
            _squares.add(null);
          } else {
            _squares.add(_boardBox.board.squares[index]);
            index++;
          }
        }
      }
    }
  }
}
