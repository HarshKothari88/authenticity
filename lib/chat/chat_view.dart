import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:authenticity/chat/chat_controller.dart';
import 'package:authenticity/complete/completed_view.dart';
import 'package:authenticity/model/user_model.dart';
import 'package:authenticity/utility/app_bar_widget.dart';
import 'package:authenticity/utility/snackbar.dart';
import 'package:authenticity/utility/variables.dart';
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:open_filex/open_filex.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

class ChatView extends StatefulWidget {
  const ChatView({super.key});

  @override
  State<ChatView> createState() => _ChatViewState();
}

callclass _ChatViewState extends State<ChatView> {
  var user = UserModel.empty();
  int section = 0;
  String language = "";
  List<types.User> users = [];
  final GlobalKey<ChatState> _chatKey = GlobalKey();

  types.User serverUser = const types.User(
      id: "server",
      firstName: "Authentify",
      lastName: "Agent",
      imageUrl: "assets/images/authentify_logo.png");
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
        final success = data["success"] ?? null;
        getMessage(types.TextMessage(
            createdAt: DateTime.now().millisecondsSinceEpoch,
            author: serverUser,
            id: generateRandomId(),
            text: data["message"]));
        if (success != null && success) {
          Get.off(() => CompletedView());
          socket?.disconnect();
        }
        users = [];
        setState(() {});
      });
    });

    socket?.onError((data) => debugPrint("Error: ${data}"));

    socket?.connect();
  }

  void getMessage(types.Message message) {
    setState(() {
      messages.insert(0, message);
      users = messages.map((e) => e.author).toList();
    });
  }

  String generateRandomId() {
    final random = Random();
    final id = random.nextInt(100).toString();
    return id;
  }

  void sendMessage(int section, String text) {
    final message = types.TextMessage(
      author: types.User(id: user.id),
      createdAt: DateTime.now().millisecondsSinceEpoch,
      id: generateRandomId(),
      text: text,
    );
    if (section == 0) {
      language = text;
    }
    socket?.emit("clientside", {
      "section": section,
      "message": text,
      "language": language,
    });
    getMessage(message);
  }

  void sendImagesMessage(
      int section, types.Message message, String base64Image) {
    socket?.emit("clientside", {
      "section": section,
      "message": base64Image,
      "language": language,
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

  void _handleFileSelection() async {
// ask permissions for file

    await Permission.photos.request();
    await Permission.camera.request();

    final result = await FilePicker.platform.pickFiles(
      type: FileType.any,
      withData: true,
      withReadStream: true,
      allowMultiple: true
    );

    if (result != null && result.files.single.path != null) {
      debugPrint("File Path: ${result.files}");
      final message = types.FileMessage(
        author: types.User(id: user.id),
        createdAt: DateTime.now().millisecondsSinceEpoch,
        id: generateRandomId(),
        name: result.files.single.name,
        size: result.files.single.size,
        uri: result.files.single.path!,
      );

      sendImagesMessage(
          section, message, base64Encode(result.files.single.bytes!));
    }
  }

  @override
  void initState() {
    init();

    super.initState();
  }

  @override
  void dispose() {
    socket?.disconnect();
    super.dispose();
  }

  void _handleMessageTap(BuildContext _, types.Message message) async {
    if (message is types.FileMessage) {
      var localPath = message.uri;

      if (message.uri.startsWith('http')) {
        try {
          final index =
              messages.indexWhere((element) => element.id == message.id);
          final updatedMessage =
              (messages[index] as types.FileMessage).copyWith(
            isLoading: true,
          );

          setState(() {
            messages[index] = updatedMessage;
          });

          final client = http.Client();
          final request = await client.get(Uri.parse(message.uri));
          final bytes = request.bodyBytes;
          final documentsDir = (await getApplicationDocumentsDirectory()).path;
          localPath = '$documentsDir/${message.name}';

          if (!File(localPath).existsSync()) {
            final file = File(localPath);
            await file.writeAsBytes(bytes);
          }
        } finally {
          final index =
              messages.indexWhere((element) => element.id == message.id);
          final updatedMessage =
              (messages[index] as types.FileMessage).copyWith(
            isLoading: null,
          );

          setState(() {
            messages[index] = updatedMessage;
          });
        }
      }

      await OpenFilex.open(localPath);
    }
  }

  void _handleImageSelection() async {
    final result = await ImagePicker().pickImage(
      imageQuality: 70,
      maxWidth: 1440,
      source: ImageSource.gallery,
    );

    if (result != null) {
      final bytes = await result.readAsBytes();
      final image = await decodeImageFromList(bytes);

      final message = types.ImageMessage(
        author: types.User(id: user.id),
        createdAt: DateTime.now().millisecondsSinceEpoch,
        height: image.height.toDouble(),
        id: generateRandomId(),
        name: result.name,
        size: bytes.length,
        uri: result.path,
        width: image.width.toDouble(),
      );

      sendImagesMessage(section, message, base64Encode(bytes));
    }
  }

  void _handleCamera() async {
    final result = await ImagePicker().pickImage(
      imageQuality: 70,
      maxWidth: 1440,
      source: ImageSource.camera,
    );

    if (result != null) {
      final bytes = await result.readAsBytes();
      final image = await decodeImageFromList(bytes);

      final message = types.ImageMessage(
        author: types.User(id: user.id),
        createdAt: DateTime.now().millisecondsSinceEpoch,
        height: image.height.toDouble(),
        id: generateRandomId(),
        name: result.name,
        size: bytes.length,
        uri: result.path,
        width: image.width.toDouble(),
      );

      sendImagesMessage(section, message, base64Encode(bytes));
    }
  }

  void _handleAttachmentPressed() {
    showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) => SafeArea(
        child: SizedBox(
          height: 300,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  _handleCamera();
                },
                child: const Align(
                  alignment: AlignmentDirectional.centerStart,
                  child: Text('Camera'),
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  _handleImageSelection();
                },
                child: const Align(
                  alignment: AlignmentDirectional.centerStart,
                  child: Text('Photo'),
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  _handleFileSelection();
                },
                child: const Align(
                  alignment: AlignmentDirectional.centerStart,
                  child: Text('File'),
                ),
              ),
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Align(
                  alignment: AlignmentDirectional.centerStart,
                  child: Text('Cancel'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Chat(
          key: _chatKey,
          messages: messages,
          avatarBuilder: (author) => CircleAvatar(
              radius: 20,
              child: SvgPicture.asset(
                "assets/images/authentify_logo.svg",
                height: 15,
                width: 15,
              )),
          onSendPressed: (PartialText) {
            onSendPressed(PartialText);
          },
          showUserAvatars: true,
          showUserNames: true,
          typingIndicatorOptions: section != 9
              ? TypingIndicatorOptions(
                  typingUsers: users,
                  customTypingWidget: Text("Authentify is Typing"))
              : TypingIndicatorOptions(),
          user: types.User(
            id: user.id,
            imageUrl: "https://i.pravatar.cc/300",
          ),
          onMessageTap: _handleMessageTap,
          onAttachmentPressed: _handleAttachmentPressed),
    );
  }
}
