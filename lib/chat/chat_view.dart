import 'dart:convert';
import 'dart:math';

import 'package:authenticity/chat/chat_controller.dart';
import 'package:authenticity/model/user_model.dart';
import 'package:authenticity/utility/app_bar_widget.dart';
import 'package:authenticity/utility/snackbar.dart';
import 'package:authenticity/utility/variables.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class ChatView extends StatefulWidget {
  const ChatView({super.key});

  @override
  State<ChatView> createState() => _ChatViewState();
}

class _ChatViewState extends State<ChatView> {
  var user = UserModel.empty();
  int section = 0;
  types.User serverUser =
      const types.User(id: "server", imageUrl: "https://i.pravatar.cc/300");
  var messages = <types.Message>[];
  IO.Socket? socket;
  final dio = Dio(BaseOptions(
      baseUrl: Variables.baseUrl,
      headers: {"Authorization": "${GetStorage().read('token')}"}));

  Future<UserModel> fetchUserDetails() async {
    try {
      final response = await dio.get("/auth/verify");
      if (response.statusCode == 200) {
        var responseBody = response.data;
        debugPrint(
            "User Details: ${responseBody} and user body ${responseBody["user"]}");
        final data = responseBody["user"];
        user = UserModel.fromMap(data);
        return user;
      } else {
        setSnackBar("ERROR:", response.data['message']);
        throw Exception("Failed to load user details");
      }
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }

  String generateRandomId() {
    final random = Random();
    final id = random.nextInt(100).toString();
    return id;
  }

  Future<void> connectToServer() async {
    socket = IO.io(Variables.host, <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': false,
    });

    socket?.onConnect((_) {
      debugPrint('connected to server');
      socket?.emit('init', user.id);
      socket?.on("backend", (data) {
        debugPrint("backend: ${data}");
        section = data["section"];
        getMessage(types.TextMessage(
            createdAt: DateTime.now().millisecondsSinceEpoch,
            author: serverUser,
            id: generateRandomId(),
            text: data["message"]));
      });
    });

    socket?.onError((data) => debugPrint("Error: ${data}"));

    socket?.connect();
  }

  void getMessage(types.Message message) {
    setState(() {
      messages.insert(0, message);
    });
  }

  void sendMessage(int section, String text) {
    final message = types.TextMessage(
      author: types.User(id: user.id),
      createdAt: DateTime.now().millisecondsSinceEpoch,
      id: generateRandomId(),
      text: text,
    );
    socket?.emit("clientside", {
      "section": section,
      "message": text, 
    });
    getMessage(message);
  }

  Future<UserModel> init() async {
    await fetchUserDetails();
    await connectToServer();
    return user;
  }

  Future<void> onSendPressed(types.PartialText message) async {
    sendMessage(section, message.text);
  }

  @override
  void initState() {
    init();
    
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: authentifyAppBar(),
      body: Chat(
              messages: messages,
              avatarBuilder: (author) => CircleAvatar(
                backgroundImage: NetworkImage(author.imageUrl!),
              ),
              onSendPressed: (PartialText) {
                onSendPressed(PartialText);
              },
              user: types.User(
                id: user.id,
                imageUrl: "https://i.pravatar.cc/300",
              ),
            ),
    );
  }
}
