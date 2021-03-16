import 'package:dogehouse_flutter/models/chat_model.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class ChatItem extends StatelessWidget {
  final ChatModel chatModel;

  ChatItem(this.chatModel);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        child: Row(
          children: [
            Container(
              height: 20,
              width: 20,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(chatModel.avatarUrl!),
                ),
              ),
            ),
            SizedBox(width: 5),
            Flexible(
              child: RichText(
                text: TextSpan(
                  // style: defaultStyle,
                  children: <TextSpan>[
                    TextSpan(text: chatModel.displayName, style: TextStyle(color: Colors.blue), recognizer: TapGestureRecognizer()..onTap = () {}),
                    TextSpan(text: ': '),
                    TextSpan(text: chatModel.tokens![0].v),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
