import 'package:flutter_bloc/flutter_bloc.dart';
import 'chat_event.dart';
import 'chat_state.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:http/http.dart' as http;
import 'dart:convert';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  final stt.SpeechToText speech = stt.SpeechToText();

  ChatBloc() : super(ChatState(messages: [])) {
    on<SendMessage>(_onSendMessage);
  }

  Future<void> _onSendMessage(
    SendMessage event,
    Emitter<ChatState> emit,
  ) async {
    final updatedMessages = List<Map<String, String>>.from(state.messages)
      ..add({'sender': 'user', 'text': event.message});
    emit(state.copyWith(messages: updatedMessages));

    // ChatGPT API
    const apiKey = 'Replace this text with your OpenAI API key';
    const apiUrl = 'https://api.openai.com/v1/chat/completions';

    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $apiKey',
      },
      body: jsonEncode({
        "model": "gpt-3.5-turbo",
        "messages": [
          {"role": "user", "content": event.message},
        ],
      }),
    );

    String botReply;
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      botReply = data['choices'][0]['message']['content'];
    } else {
      botReply = 'حدث خطأ في الاتصال بـ ChatGPT';
    }

    final newMessages = List<Map<String, String>>.from(updatedMessages)
      ..add({'sender': 'bot', 'text': botReply});
    emit(state.copyWith(messages: newMessages));
  }
}
