import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:lottie/lottie.dart';
import 'dart:convert';
import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

List<Map<String, dynamic>> conversationHistory = [];

class _ChatScreenState extends State<ChatScreen> {
  final ourUrl =
      "https://generativelanguage.googleapis.com/v1beta/models/gemini-pro:generateContent?key=AIzaSyDcb9znEyp91lmu5TWkJDFo5O9CTMkXJXs";

  ChatUser currentUser = ChatUser(
    id: "1",
    firstName: "User",
    lastName: "ID",
  );
  ChatUser bot = ChatUser(
    id: "2",
    firstName: "Chef",
    lastName: "Bot",
  );

  List<ChatMessage> allMessages = [];
  List<ChatUser> typing = [];
  final header = {"Content-Type": "application/json"};
  bool isRelatedToCulinary(String text) {
    // Daftar kata kunci terkait kuliner
    final culinaryKeywords = [
      'makanan', 'masak', 'resep', 'bahan', 'rasa', 'menu', 'hidangan',
      'dapur', 'chef', 'restoran', 'kuliner', 'gizi', 'nutrisi'
      // Tambahkan kata kunci lain sesuai kebutuhan
    ];

    return culinaryKeywords
        .any((keyword) => text.toLowerCase().contains(keyword));
  }

  void handleUserMessage(ChatMessage message) {
    if (isRelatedToCulinary(message.text)) {
      getData(message);
    } else {
      final redirectMessage = ChatMessage(
        user: bot,
        text:
            "Maaf, saya hanya dapat menjawab pertanyaan terkait kuliner. Silakan tanyakan sesuatu tentang makanan, resep, atau memasak.",
        createdAt: DateTime.now(),
      );
      setState(() {
        allMessages.insert(0, redirectMessage);
      });
    }
  }

  getData(ChatMessage message) async {
    typing.add(bot);
    allMessages.insert(0, message);
    setState(() {});

    conversationHistory.add({
      "role": "user",
      "parts": [
        {"text": message.text}
      ]
    });

    var data = {
      "contents": [
        {
          "role": "user",
          "parts": [
            {
              "text":
                  "You are ChefBot (Culinary Helper and Expert Flavor Bot), a friendly assistant trained by Muh. Fausan and Anggun Setia Dewi. Your mission is to provide accurate information and advice STRICTLY on topics related to food, recipes, cooking techniques, and everything culinary. You MUST NOT answer questions that are out of context. If a user asks about non-culinary topics, politely redirect them to food-related subjects. You are designed to offer delicious recipe recommendations and helpful cooking tips, making the kitchen experience enjoyable for all users."
            }
          ]
        },
        ...conversationHistory
      ]
    };

    try {
      var response = await http.post(Uri.parse(ourUrl),
          headers: header, body: jsonEncode(data));

      if (response.statusCode == 200) {
        var responseData = jsonDecode(response.body);
        setState(() {
          if (isRelatedToCulinary(
              responseData['candidates'][0]['content']['parts'][0]['text'])) {
            ChatMessage message2 = ChatMessage(
              user: bot,
              text: responseData['candidates'][0]['content']['parts'][0]
                  ['text'],
              createdAt: DateTime.now(),
            );
            allMessages.insert(0, message2);
          } else {
            ChatMessage errorMessage = ChatMessage(
              user: bot,
              text:
                  "Maaf, saya seharusnya hanya menjawab pertanyaan terkait kuliner. Mohon tanyakan sesuatu tentang makanan atau memasak.",
              createdAt: DateTime.now(),
            );
            allMessages.insert(0, errorMessage);
          }
        });
        conversationHistory.add({
          "role": "model",
          "parts": [
            {
              "text": responseData['candidates'][0]['content']['parts'][0]
                  ['text']
            }
          ]
        });
      } else {
        // ignore: use_build_context_synchronously
        showAboutDialog(context: context, children: [Text(response.body)]);
      }
    } catch (e) {
      // ignore: use_build_context_synchronously
      showAboutDialog(context: context, children: [Text(e.toString())]);
    }

    typing.remove(bot);
    setState(() {});
  }

  onLongPress() {
    final botMessagesText = allMessages
        .where((message) => message.user == bot)
        .map((message) => '${message.user.firstName}: ${message.text}')
        .join('\n');
    Clipboard.setData(ClipboardData(text: botMessagesText));

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Form ini berisi semua respons dari ${bot.firstName}'),
          content: SelectableText(
            botMessagesText,
            style: const TextStyle(fontSize: 16.0),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Keluar'),
            ),
            TextButton(
              onPressed: () {
                Clipboard.setData(ClipboardData(text: botMessagesText));
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                      backgroundColor: Color.fromARGB(255, 0, 166, 126),
                      content: Text("Pesan disalin ke clipboard")),
                );
              },
              child: const Text("Salin"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        centerTitle: true,
        title: const Text(
          "ChefBot",
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          IconButton(
            onPressed: () {
              _showDeleteAllMessagesDialog(context);
            },
            icon: const Icon(
              FontAwesomeIcons.trashCan,
              color: Colors.white,
            ),
          ),
        ],
        backgroundColor: Colors.blueGrey,
      ),
      body: Stack(
        children: [
          Container(
            color: const Color.fromARGB(255, 222, 222, 222),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: Row(
              children: [
                Expanded(
                  child: AnimatedTextKit(
                    animatedTexts: [
                      TyperAnimatedText(
                          'ChefBot (Culinary Helper and Expert Flavor Bot)\nadalah sebuah kecerdasan buatan yang dilatih\nuntuk memberikan rekomendasi resep dan menjawab\npertanyaan anda seputar dunia kuliner 🍳👨‍🍳',
                          speed: const Duration(milliseconds: 45),
                          textStyle: const TextStyle(
                              fontSize: 15,
                              fontStyle: FontStyle.italic,
                              color: Color.fromARGB(255, 128, 123, 123)),
                          textAlign: TextAlign.center),
                    ],
                    totalRepeatCount: 1,
                  ),
                )
              ],
            ),
          ),
          Lottie.asset(
            'assets/backgrounds/wallpaper_chat1.json',
            width: double.infinity,
            height: double.infinity,
          ),
          GestureDetector(
            onLongPress: onLongPress,
            child: DashChat(
              typingUsers: typing,
              currentUser: currentUser,
              onSend: (ChatMessage message) {
                getData(message);
              },
              messages: allMessages,
              inputOptions: const InputOptions(
                cursorStyle: CursorStyle(
                  color: Color.fromRGBO(0, 166, 126, 1),
                ),
              ),
              messageOptions: MessageOptions(
                messageTextBuilder: (ChatMessage message,
                    ChatMessage? previousMessage, ChatMessage? nextMessage) {
                  return MarkdownBody(
                    data: message.text,
                    styleSheet: MarkdownStyleSheet(
                      p: const TextStyle(fontSize: 14, color: Colors.black),
                    ),
                  );
                },
                currentUserContainerColor:
                    const Color.fromRGBO(192, 254, 239, 1),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showDeleteAllMessagesDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Hapus Semua Pesan'),
          content: const Text('Anda yakin ingin menghapus semua pesan?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Batal'),
            ),
            TextButton(
              onPressed: () {
                _deleteAllMessages();
                Navigator.of(context).pop();
              },
              child: const Text('Hapus'),
            ),
          ],
        );
      },
    );
  }

  void _deleteAllMessages() {
    setState(() {
      allMessages.clear();
      conversationHistory.clear();
    });
  }
}
