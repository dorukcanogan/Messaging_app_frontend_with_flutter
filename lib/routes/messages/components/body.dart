import 'dart:convert';
import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:the_project/model/conversation.dart';
import 'package:the_project/model/message.dart';
import 'package:the_project/model/user.dart';
import 'package:the_project/utils/color.dart';
import 'text_message.dart';
import 'message_input_field.dart';
import 'package:stomp_dart_client/stomp.dart';
import 'package:stomp_dart_client/stomp_config.dart';
import 'package:stomp_dart_client/stomp_frame.dart';
import 'package:http/http.dart' as http;

class Body extends StatefulWidget {
  const Body({Key? key, required this.conversation, required this.activeUser}) : super(key: key);

  final Conversation conversation;
  final AppUser activeUser;

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {

  final _controller = TextEditingController();
  String message= '';
  bool textType = false;


  void sendMessage() {

    saveData(message);

    setState(() {
      widget.conversation.message.add(new Message(senderId: widget.activeUser.userId, text: message));
    });

    _controller.clear();

    message = '';

    setState(() {
      textType = !textType;
    });

  }


  @override
  Widget build(BuildContext context) {

    Widget AttachIcon (){
      return Row(
        children: [
          Icon(Icons.attach_file),
          SizedBox(width: 6,),
          Icon(Icons.camera_alt_outlined),
        ],
      );
    }

    Widget SendIcon (){
      return IconButton(
        icon:Icon(Icons.send),
        onPressed: () { sendMessage(); },);
    }

    Widget InputIcon = Container();
    if(textType){
      InputIcon = SendIcon();
    }else {
      InputIcon = AttachIcon();
    }

    return Column(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: ListView.builder(
              itemCount: widget.conversation.message.length,
              itemBuilder: (context, index) =>
                  Row(
                    mainAxisAlignment: widget.conversation.message[index].senderId == widget.activeUser.userId ? MainAxisAlignment.end
                        : MainAxisAlignment.start,
                    children: [
                      Container(
                          margin: EdgeInsets.only(top: 16),
                          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                          decoration: BoxDecoration(
                              color: widget.conversation.message[index].senderId == widget.activeUser.userId ? AppColors.messageSender : AppColors.messageReceiver,
                              borderRadius: BorderRadius.circular(30)
                          ),
                          child:
                          Text(widget.conversation.message[index].text,style: TextStyle(fontSize: 16,color: AppColors.secondaryAppColor),))
                    ],
                  )
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: Theme.of(context).scaffoldBackgroundColor,
          ),
          child: SafeArea(
            child: Row(
              children: [
                Icon(Icons.mic, color: AppColors.primaryAppColor,),
                SizedBox(width: 16,),
                Expanded(
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 12),
                      height: 50,
                      decoration: BoxDecoration(
                          color: AppColors.primaryAppColor.withOpacity(0.05),
                          borderRadius: BorderRadius.circular(40),
                          boxShadow: [BoxShadow(
                              offset: Offset(0, 4),
                              blurRadius: 32,
                              color: Color(0xFF087949).withOpacity(0.08)
                          )
                          ]
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.sentiment_satisfied_alt_outlined),
                          SizedBox(width: 4,),
                          Expanded(
                            child: TextField(
                              controller: _controller,
                              textCapitalization: TextCapitalization.sentences,
                              autocorrect: true,
                              enableSuggestions: true,
                              decoration: InputDecoration(
                                  hintText: 'Type message',
                                  border: InputBorder.none
                              ),
                              onChanged:(value){
                                setState(() {
                                  if(value.length==0 || message.length==0) {
                                    textType = !textType;
                                  }
                                  message = value;
                                });
                              },
                            ),
                          ),
                          InputIcon,

                        ],
                      ),
                    )
                )

              ],
            ),
          ),
        )
      ],
    );
  }

  void saveData(String text) async {


    final response = await http
        .get(Uri.parse('http://10.0.2.2:8080/saveMessage?text=$message&sender=${widget.activeUser.userId}&conv=${widget.conversation.conversationId}'));

    if(response.statusCode >= 200 && response.statusCode < 300) {
      //print(response.body);
      //var jsonResponse = convert.jsonDecode(response.body) as Map<String, dynamic>;

      //var responseList = json.decode(response.body) as List;
      print('gönderildi');
      //print(responseList);
    }
    else {
      print(response.statusCode);
    }
    //print(response.toString());
  }


/*
  @override
  Widget build(BuildContext context) {


    return Column(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: ListView.builder(
              itemCount: conversation.message.length,
              itemBuilder: (context, index) =>
                  TextMessage(message: conversation.message[index],activeUser: widget.activeUser,),
            ),
          ),
        ),
        MessageTypeField(convId: conversation.conversationId, activeUser: widget.activeUser,conversation: conversation)
      ],
    );
  } */
}