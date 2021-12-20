import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:the_project/model/conversation.dart';
import 'package:the_project/model/user.dart';
import 'package:the_project/model/message.dart';
import 'package:the_project/utils/color.dart';
import 'package:stomp_dart_client/stomp.dart';
import 'package:stomp_dart_client/stomp_config.dart';
import 'package:stomp_dart_client/stomp_frame.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

import 'components/body.dart';


class MessageScreen extends StatefulWidget {

  MessageScreen({Key? key, required this.conversation , required this.receiver, required this.activeUser }) : super(key: key);

  final Conversation conversation;
  final AppUser receiver;
  final AppUser activeUser;


  @override
  _MessageScreenState createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessageScreen> {


  StompClient stompClient = StompClient(
      config: StompConfig(
          url: 'ws://localhost:8080/chat',
      )
  );


  void onConnect(StompFrame frame) {
    stompClient.subscribe(
        destination: '/topic/message/${widget.conversation.conversationId}',
        callback: (StompFrame frame) {
          if (frame.body != null) {
            var result = json.decode(frame.body!);
            setState(() {
              widget.conversation.message.add(new Message(senderId: result['sender'], text: result['text']));
            });
          }
        });
  }


  @override
  void initState() {

    super.initState();


      stompClient = StompClient(
          config: StompConfig(
            url: 'ws://localhost:8080/chat',
            onConnect: onConnect,
            onWebSocketError: (dynamic error) => print(error.toString()),
          ));

      stompClient.activate();

  }

/*
  @override
  void dispose() {
    super.dispose();
    //stompClient.deactivate();
  }
*/

  @override
  Widget build(BuildContext context) {


    return Scaffold(
          appBar: buildAppBar(),
          body: Body(conversation: widget.conversation, activeUser: widget.activeUser ),
    );
  }


  AppBar buildAppBar() {
    return AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: AppColors.primaryAppColor,
          title: Row(
            children: [
              BackButton(),
              CircleAvatar(backgroundImage: AssetImage('assets/IMG_${widget.receiver.userId}.jpeg'),),
              SizedBox(width: 16,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(widget.receiver.firstName+' '+widget.receiver.lastName,style: TextStyle(fontSize: 16),),
                  Text('Active 36m ago',style: TextStyle(fontSize: 12),)
                ],
              )
            ],
          ),
        );
  }
}
