import 'package:dogehouse_flutter/resources/palette.dart';
import 'package:flutter/material.dart';

class InputField extends StatelessWidget {
  final Function sendMessage;
  final TextEditingController textEditingController;
  final FocusNode focusNode;

  InputField(this.textEditingController, this.focusNode, this.sendMessage);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, bottom: 10, right: 10),
      child: Container(
        padding: EdgeInsets.only(left: 10),
        child: Row(
          children: <Widget>[
            Flexible(
              child: Container(
                child: TextField(
                  onSubmitted: sendMessage as void Function(String)?,
                  textInputAction: TextInputAction.newline,
                  style: TextStyle(color: Colors.white, fontSize: 15.0),
                  controller: textEditingController,
                  decoration: InputDecoration.collapsed(
                    hintText: 'Send a Message',
                    hintStyle: TextStyle(color: Palette.lightBlue, fontWeight: FontWeight.bold),
                  ),
                  focusNode: focusNode,
                ),
              ),
            ),
            Material(
              color: Palette.separateLine,
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 8.0),
                child: IconButton(
                  icon: Icon(Icons.send),
                  onPressed: () => sendMessage(textEditingController.text),
                  color: Palette.primaryColor,
                ),
              ),
            ),
          ],
        ),
        width: double.infinity,
        height: 50.0,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(5.0), color: Palette.separateLine),
      ),
    );
  }
}
