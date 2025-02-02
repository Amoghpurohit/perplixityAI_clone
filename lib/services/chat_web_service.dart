import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:web_socket_client/web_socket_client.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class ChatWebService {
  WebSocket? _socket;

  ChatWebService._internal();

  static final _instance = ChatWebService._internal();

  factory ChatWebService() => _instance;

  final _searchResultController = StreamController<Map<String, dynamic>>();
  final _contentController = StreamController<Map<String,dynamic>>();

  Stream<Map<String, dynamic>> get getSearchResultController => _searchResultController.stream;
  Stream<Map<String, dynamic>> get getContentController => _contentController.stream;
  
  void connect() {
    _socket = WebSocket(Uri.parse(kIsWeb ? "ws://localhost:8000/ws/chat" : "ws://10.0.2.2:8000/ws/chat"));

    _socket!.messages.listen((message) {
      final data = jsonDecode(message);
      if(data['type'] == 'search_result'){
        _searchResultController.add(data);
      }
      else if(data['type'] == 'LLM response'){
        _contentController.add(data);
      }         //message is a json that was sent by the server
    });
  }

  void chat(String query) {
    _socket!.send(jsonEncode({"query":query}));
  }
}
