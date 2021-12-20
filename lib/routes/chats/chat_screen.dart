import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:stomp_dart_client/stomp.dart';
import 'package:stomp_dart_client/stomp_config.dart';
import 'package:stomp_dart_client/stomp_frame.dart';
import 'package:the_project/model/conversation.dart';
import 'package:the_project/model/message.dart';
import 'package:the_project/routes/messages/message_screen.dart';
import 'package:provider/provider.dart';
import 'package:the_project/model/user.dart';
import 'package:http/http.dart' as http;
import 'package:the_project/routes/story/story_view.dart';
import 'dart:convert' as convert;
import 'package:the_project/routes/welcome/home.dart';
import 'package:the_project/utils/color.dart';

class UserListView extends StatefulWidget {
  const UserListView({Key? key,required this.chatList, required this.activeUser}) : super(key: key);

  final List<Conversation> chatList;
  final AppUser activeUser;


  @override
  _UserListViewState createState() => _UserListViewState();
}

class _UserListViewState extends State<UserListView> {

  /*
  StompClient? stompClient;

  void onConnect(StompFrame frame) {
    stompClient!.subscribe(
        destination: '/topic/message/',
        callback: (StompFrame frame) {
          if (frame.body != null) {

            var result = json.decode(frame.body!);

            setState(() {



            });
          }
        });
  }
 */

  @override
  void initState() {
    // TODO: implement initState

    super.initState();

    /*
    stompClient = StompClient(
        config: StompConfig(
          url: 'ws://10.0.2.2:8080/chat',
          onConnect: onConnect,
          onWebSocketError: (dynamic error) => print(error.toString()),
        )
    );

    stompClient!.activate();
    */
  }

  AppUser receiverUser(List<AppUser> users) {
    return widget.activeUser.userId == users.elementAt(0).userId ? users.elementAt(1) : users.elementAt(0);
  }


  @override
  Widget build(BuildContext context) {

    return Column(
      children: [
       Material(
         elevation: 0.5,
         color: Colors.white,
         child: Container(
           height: 100,
           child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: widget.chatList.length,
                  itemBuilder:(BuildContext context, int index) {
                    return InkWell(
                      onTap: () { Navigator.push(context, MaterialPageRoute(builder: (context) => StoryView(user: receiverUser(widget.chatList[index].user),)));},
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(8, 8, 8, 4),
                        child: Column(
                            children: [
                              Container(
                                width:73,
                                height:73,
                                decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                        begin: Alignment.topCenter,
                                        end: Alignment.bottomCenter,
                                        colors: AppColors.mixColor
                                    ),
                                  shape: BoxShape.circle,
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(3.0),
                                  child: Container(
                                    width: 67,
                                    height: 67,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: Colors.white,
                                        width: 2
                                      ),
                                      shape: BoxShape.circle,
                                      image: DecorationImage(
                                        image: AssetImage('assets/IMG_${receiverUser(widget.chatList[index].user).userId}.jpeg')
                                      )
                                    ),
                                  ),
                                ),
                              ),
                              //CircleAvatar(radius: 36,backgroundImage:AssetImage('assets/IMG_${receiverUser(widget.chatList[index].user).userId}.jpeg')),
                              Text(receiverUser(widget.chatList[index].user).firstName ,style: TextStyle(fontSize: 12),overflow: TextOverflow.ellipsis,)
                            ],
                          ),
                        ),
                    );
                  }),
          ),
       ),
        Expanded(
          child: ListView.builder(
            itemCount: widget.chatList.length,
            itemBuilder: (BuildContext context, int index) {
              return ChatCard(
                activeUser: widget.activeUser,
                chat: widget.chatList[index],
                press: () => Navigator.push(context, MaterialPageRoute(builder: (context) => MessageScreen(conversation:widget.chatList[index], receiver: receiverUser(widget.chatList[index].user),activeUser: widget.activeUser,))),
              );
            }
          ),
        ),
      ],
    );
  }

}

class ChatCard extends StatelessWidget {
  const ChatCard({
    Key? key,required this.chat,required this.press, required this.activeUser
  }) : super(key: key);

  final Conversation chat;
  final VoidCallback press;
  final AppUser activeUser;

  AppUser receiverUser(List<AppUser> users) {
    return activeUser.userId == users.elementAt(0).userId ? users.elementAt(1) : users.elementAt(0);
  }


  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: press,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            CircleAvatar(backgroundImage: AssetImage('assets/IMG_${receiverUser(chat.user).userId}.jpeg') , radius: 24,),
            Expanded(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(16.0, 0, 0, 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text( receiverUser(chat.user).firstName +' '+receiverUser(chat.user).lastName,style: TextStyle(fontSize: 16,fontWeight: FontWeight.w500),),
                      SizedBox(height: 6,),
                      Opacity(
                          opacity:0.64,
                          child: Text(chat.message.last.text, maxLines: 1, overflow: TextOverflow.ellipsis,)
                      )
              ],
            ),
                )),
          ],
        ),
      ),
    );
  }
}
