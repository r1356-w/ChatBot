import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bloc/chat_bloc.dart';
import 'bloc/chat_event.dart';
import 'bloc/chat_state.dart';

class ChatScreen extends StatelessWidget {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              const Color.fromARGB(255, 119, 117, 117)!,
              Colors.grey[850]!,
              Colors.grey[800]!,
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: BlocBuilder<ChatBloc, ChatState>(
                  builder: (context, state) {
                    return ListView.builder(
                      padding: EdgeInsets.all(8),
                      itemCount: state.messages.length,
                      itemBuilder: (context, index) {
                        final msg = state.messages[index];
                        return Padding(
                          padding: EdgeInsets.symmetric(vertical: 4),
                          child: Row(
                            mainAxisAlignment: msg['sender'] == 'user'
                                ? MainAxisAlignment.end
                                : MainAxisAlignment.start,
                            children: [
                              Container(
                                constraints: BoxConstraints(
                                  maxWidth:
                                      MediaQuery.of(context).size.width * 0.7,
                                ),
                                padding: EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 12,
                                ),
                                decoration: BoxDecoration(
                                  color: msg['sender'] == 'user'
                                      ? Colors.grey[900]
                                      : Colors.grey[900],
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Text(
                                  msg['text'] ?? '',
                                  style: TextStyle(
                                    color: const Color.fromARGB(
                                      255,
                                      255,
                                      255,
                                      255,
                                    ),
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                  textDirection: TextDirection.rtl,
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
              Container(
                padding: EdgeInsets.all(12),
                color: Colors.transparent,
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.grey[850],
                          borderRadius: BorderRadius.circular(25),
                          border: Border.all(color: Colors.grey[700]!),
                        ),

                        child: TextField(
                          controller: _controller,
                          onSubmitted: (text) {
                            context.read<ChatBloc>().add(SendMessage(text));
                            _controller.clear();
                          },
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                          textDirection: TextDirection.rtl,
                          decoration: InputDecoration(
                            hintText: 'اكتب رسالتك هنا...',
                            hintStyle: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                            ),
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 12,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 12),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.grey[900],
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: IconButton(
                        icon: Icon(Icons.send, color: Colors.white, size: 24),
                        onPressed: () {
                          context.read<ChatBloc>().add(
                            SendMessage(_controller.text),
                          );
                          _controller.clear();
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
