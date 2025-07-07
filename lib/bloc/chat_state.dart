class ChatState {
  final List<Map<String, String>> messages;
  final bool isListening;

  ChatState({required this.messages, this.isListening = false});

  ChatState copyWith({List<Map<String, String>>? messages, bool? isListening}) {
    return ChatState(
      messages: messages ?? this.messages,
      isListening: isListening ?? this.isListening,
    );
  }
}
