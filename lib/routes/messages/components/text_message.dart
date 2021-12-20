import 'package:flutter/material.dart';
import 'package:the_project/model/conversation.dart';
import 'package:the_project/model/message.dart';
import 'package:the_project/model/user.dart';
import 'package:the_project/utils/color.dart';
import 'package:the_project/routes/chats/chat_screen.dart';

import 'text_message.dart';


class TextMessage extends StatefulWidget {
  const TextMessage({
    Key? key, required this.message, required this.activeUser
  }) : super(key: key);

  final AppUser activeUser;
  final Message message;

  @override
  _TextMessageState createState() => _TextMessageState();
}

class _TextMessageState extends State<TextMessage> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: widget.message.senderId == widget.activeUser.userId ? MainAxisAlignment.end
          : MainAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.only(top: 16),
          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: widget.message.senderId == widget.activeUser.userId ? AppColors.messageSender : AppColors.messageReceiver,
              borderRadius: BorderRadius.circular(30)
            ),
            child:
            Text(widget.message.text,style: TextStyle(fontSize: 16,color: AppColors.secondaryAppColor),))
      ],
    );
  }

}


