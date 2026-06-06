import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:manifex/App/Urls.dart';
import 'package:manifex/Core/SharepreferenceHelper.dart';

class ChatMessage {
  final String text;
  final bool isUser;

  ChatMessage({required this.text, required this.isUser});
}

class SupportChatController extends GetxController {
  final TextEditingController messageController = TextEditingController();
  final RxList<ChatMessage> messages = <ChatMessage>[].obs;
  final scrollController = ScrollController();
  final isReplying = false.obs;

  @override
  void onInit() {
    super.onInit();
    messages.add(
      ChatMessage(text: 'Hello! How can I assist you today?', isUser: false),
    );
  }

  void sendMessage() async {
    final messageText = messageController.text;
    if (messageText.isEmpty) return;

    // Add user message to chat
    messages.add(ChatMessage(text: messageText, isUser: true));
    messageController.clear();
    scrollToBottom();
    isReplying.value = true;

    try {
      final token = await PrefHelper.getAccessToken();
      final userId =
          PrefHelper.getUserId(); // Assuming you have a method to get user ID
      
      if (token == null || userId == null) {
        messages.add(ChatMessage(text: 'Error: User not logged in', isUser: false));
        return;
      }

      final response = await http.post(
        Uri.parse(urls.chatbot),
        headers: {
          'Content-Type': 'application/json',
          'authtoken': '$token',
        },
        body: jsonEncode({
          'user_id': userId,
          'user_message': messageText,
        }),
      );

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        final botResponse = responseData['chatbot_reply'];
        if (botResponse != null) {
          messages.add(
              ChatMessage(text: botResponse, isUser: false));
        } else {
          messages.add(ChatMessage(text: 'Error: Received empty response', isUser: false));
        }
      } else {
        // Handle error
        messages.add(ChatMessage(text: 'Error: Failed to get response', isUser: false));
        print('Error: ${response.statusCode}');
        print('Error: ${response.body}');
      }
    } catch (e) {
      messages.add(ChatMessage(text: 'Error: $e', isUser: false));
      print('Error: $e');
    } finally {
      isReplying.value = false;
      scrollToBottom();
    }
  }
  
  void scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (scrollController.hasClients) {
        scrollController.animateTo(
          scrollController.position.maxScrollExtent,
          duration: Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }
}
