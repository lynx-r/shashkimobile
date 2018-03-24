import 'dart:ui' as ui;
import 'package:collection/collection.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:shashkimobile/model/board_box.dart';
import 'package:shashkimobile/model/rules.dart';
import 'package:shashkimobile/model/square.dart';

class BoardPainter extends ChangeNotifier implements CustomPainter {
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

  Offset _point;

  Map<String, ui.Image> _images = {};
  var strokes = new List<List<Offset>>();

  Square _clickedSquare;

  BoardPainter(this._point, this._boardBox, this._images) {
    this._updateBoard(_boardBox);
  }

  @override
  void paint(Canvas canvas, Size size) {
    if (_boardBox == null) {
      return;
    }
    var black = Colors.black54;
    var white = Colors.white70;
    var highlighted = Colors.lightBlue;
    var side = size.shortestSide;
    var squareWidth = (side / _boardDim);
    var textStyle = new TextStyle(color: Colors.black87, fontSize: 14.0);
    var rect = new Offset(squareWidth, 0.0) &
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
        _drawSquare(paint, highlighted, black, white, square, squareWidth,
            squareSize, canvas);
      } else {
        _drawCoords(i, textStyle, rect, squareWidth, canvas);
      }
    }
    if (_clickedSquare != null) {
      if (_clickedSquare.draught != null) {
        // highlight
        BoardBox.highlight(_boardBox, _clickedSquare).then((boardBox) {
          _point = _clickedSquare = null;
          _updateBoard(boardBox);
          notifyListeners();
        }).catchError((err) {
          print(err);
        });
      } else {
        // move

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
  bool shouldRepaint(BoardPainter oldDelegate) {
    return oldDelegate._point != _point ||
        oldDelegate._boardBox != _boardBox ||
        !new MapEquality().equals(oldDelegate._images, _images);
  }

  bool shouldRebuildSemantics(BoardPainter oldDelegate) =>
      shouldRepaint(oldDelegate);

  @override
  bool hitTest(ui.Offset position) => null;

  _drawSquare(
      ui.Paint paint,
      ui.Color highlighted,
      ui.Color black,
      ui.Color white,
      Square square,
      double squareWidth,
      ui.Size squareSize,
      ui.Canvas canvas) {
    paint.color = black;
    if (square.highlighted) {
      paint.color = highlighted;
    }
    var h = square.h + 1;
    var v = square.v;
    var width = squareWidth * h;
    var offset = new Offset(width, v * squareWidth);
    var rect = offset & squareSize;
    canvas.drawRect(rect, paint);

    var draught = square.draught;
    if (draught != null) {
      var rang = draught.queen ? 'queen' : 'draught';
      var color = draught.black ? 'black' : 'white';
      var image = _images['${color}_$rang'];
      if (image == null) return;

      paint.color = draught.black ? black : white;
      var blendModeOld = paint.blendMode;
      var blendMode = BlendMode.plus;
      if (_point != null &&
          rect.contains(_point) &&
          draught.black == _boardBox.board.black) {
        paint.blendMode = blendMode;
        _clickedSquare = square;
      }
      if (draught.black == _boardBox.board.black &&
          draught == _boardBox.board.selectedSquare?.draught) {
        paint.blendMode = blendMode;
      }
      var div = image.width / rect.width;
      var scale = 1 / div;
      canvas.translate(offset.dx, offset.dy);
      canvas.scale(scale, scale);
      canvas.drawImage(image, Offset.zero, paint);
      canvas.scale(div, div);
      canvas.translate(-offset.dx, -offset.dy);

      paint.blendMode = blendModeOld;
    }
  }

  void _drawCoords(i, TextStyle textStyle, ui.Rect rect, double squareWidth,
      ui.Canvas canvas) {
    var t, offset;
    var h = i % _boardDim;
    if (h == 0 && (_boardLength.length - i) != _boardDim) {
      // num left
      var row = _boardDim - i / _boardDim - 1;
      var num = _boardDim - row.toInt();
      t = new TextSpan(text: '$num', style: textStyle);
      var row0 = row - 1;
      var width = textStyle.fontSize;
      width += width / 2.5;
      var shiftBefore10For10Dim =
          (num < 10 ? (_boardDim >= 10 ? textStyle.fontSize / 4.0 : 0) : 0);
      offset = new Offset(rect.left - width + shiftBefore10For10Dim,
          row0 * squareWidth + squareWidth / 3.5);
    }
    if (h != 0 && _boardLength.length - i <= _boardDim) {
      // ALPH bottom
      var col = (_boardLength.length - i - _boardDim) * -1;
      t = new TextSpan(text: ALPH[col], style: textStyle);
      offset = new Offset(col * squareWidth + squareWidth / 2.5,
          squareWidth * (_boardDim - 1) + textStyle.fontSize / 2);
    }
    if (t != null) {
      var painter = new TextPainter(text: t, textDirection: TextDirection.ltr);
      painter.layout();
      painter.paint(canvas, offset);
    }
  }

  void _updateBoard(boardBox) {
    this._boardBox = boardBox;

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
