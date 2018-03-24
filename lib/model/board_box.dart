import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:json_annotation/json_annotation.dart';
import 'package:shashkimobile/config/config.dart';
import 'package:shashkimobile/model/board.dart';
import 'package:shashkimobile/model/draught.dart';
import 'package:shashkimobile/model/notation.dart';
import 'package:shashkimobile/model/square.dart';
import 'package:shashkimobile/utils/custom_http_clent.dart';
import 'package:shashkimobile/utils/utils.dart';

part 'board_box.g.dart';

@JsonSerializable()
class BoardBox extends Object with _$BoardBoxSerializerMixin {
  BoardBox(this.id, this.articleId, this.boardId, this.board, this.notation);

  String id;
  String articleId;
  String boardId;

  Board board;
  Notation notation;

  @override
  String toString() {
    return toJson().toString();
  }

  factory BoardBox.fromJson(Map<String, dynamic> json) =>
      _$BoardBoxFromJson(json);

  static var _httpClient = new CustomHttpClient();

  static Future<BoardBox> highlight(BoardBox inBoardBox, Square square) async {
    print('HIGHLIGHTING SQUARE: $square');

    var json = JSON.encode(inBoardBox);
    var boardBox = new BoardBox.fromJson(JSON.decode(json));
    var uri = '$BOARD_SERVICE_URL/board/highlight';
    boardBox.board.selectedSquare = square;
    boardBox.board.squares = null;
    json = JSON.encode(boardBox.toJson());
    var response = await _httpClient.postUrl(Uri.parse(uri), json);
    if (response.statusCode == HttpStatus.OK) {
      var json = await response.transform(UTF8.decoder).join();
      var decoded = JSON.decode(json);
      var body = decoded['body'] as Map;
      return new BoardBox.fromJson(body);
    } else {
      throw new Exception('HttpError status: ${response.statusCode}');
    }
  }
}
