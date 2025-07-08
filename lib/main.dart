import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bloc/chat_bloc.dart';
import 'chat_screen.dart';

void main() => runApp(ChatBotApp());

class ChatBotApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: BlocProvider(create: (_) => ChatBloc(), child: ChatScreen()),
    );
  }
}
