import 'package:flutter/material.dart';
import 'package:the_project/model/conversation.dart';
import 'package:the_project/model/message.dart';
import 'package:the_project/model/user.dart';
import 'package:the_project/routes/chats/chat_screen.dart';
import 'package:the_project/routes/messages/components/body.dart';
import 'package:the_project/routes/messages/message_screen.dart';
import 'package:the_project/routes/welcome/home.dart';
import 'package:the_project/utils/color.dart';
import 'package:http/http.dart' as http;

class MessageTypeField extends StatefulWidget {
  const MessageTypeField({
    Key? key, required this.convId, required this.activeUser, required this.conversation
  }) : super(key: key);

  final int convId;
  final AppUser activeUser;
  final Conversation conversation;


  @override
  _MessageTypeFieldState createState() => _MessageTypeFieldState();
}

class _MessageTypeFieldState extends State<MessageTypeField> {

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

  void saveData(String text) async {

    int convId = widget.convId;

    final response = await http
        .get(Uri.parse('http://10.0.2.2:8080/saveMessage?text=$message&sender=${widget.activeUser.userId}&conv=$convId'));

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



  @override
  Widget build(BuildContext context) {

    Widget InputIcon = Container();
    if(textType){
      InputIcon = SendIcon();
    }else {
      InputIcon = AttachIcon();
    }


    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Theme
            .of(context)
            .scaffoldBackgroundColor,
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
    );
  }
}