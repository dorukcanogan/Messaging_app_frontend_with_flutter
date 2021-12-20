import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:the_project/model/conversation.dart';
import 'package:the_project/model/message.dart';
import 'package:the_project/routes/chats/chat_screen.dart';
import 'package:the_project/routes/messages/message_screen.dart';
import 'package:provider/provider.dart';
import 'package:the_project/model/user.dart';
import 'package:http/http.dart' as http;
import 'package:the_project/routes/singInUp/sign_in.dart';
import 'dart:convert' as convert;
import 'package:the_project/routes/welcome/home.dart';
import 'package:the_project/utils/color.dart';
import 'package:contacts_service/contacts_service.dart';

class ContactsScreen extends StatefulWidget {

  const ContactsScreen({Key? key, required this.activeUser, required this.chatlist}) : super(key: key);

  final AppUser activeUser;
  final List<Conversation> chatlist;

  @override
  _ContactsScreenState createState() => _ContactsScreenState();
}

class _ContactsScreenState extends State<ContactsScreen> {

  List<Contact> contacts = [];
  Conversation? newConversation;
  var convUsers = <AppUser> [];

  @override
  void initState() {
    // TODO: implement initState

    super.initState();

    getAllContacts();

  }

  AppUser receiverUser(List<AppUser> users) {
    return widget.activeUser.userId == users.elementAt(0).userId ? users.elementAt(1) : users.elementAt(0);
  }


  @override
  Widget build(BuildContext context) {

    return Column(
      children: [
        Expanded(
          child: ListView.builder(
              itemCount: contacts.length,
              itemBuilder: (BuildContext context, int index) {
                return ContactCard(
                  contact: contacts[index],
                  press: () async {
                    /*
                    for(var i = 0; i < widget.chatlist.length; i++) {
                      if(receiverUser(widget.chatlist[i].user).userId == int.parse(contacts[index].phones!.elementAt(0).value!.substring(1))) {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => MessageScreen(conversation: widget.chatlist[i],receiver: receiverUser(widget.chatlist[i].user), activeUser: widget.activeUser,)));
                      break;
                      }
                    } */
                    await createConversation(contacts[index].phones!.elementAt(0).value!.substring(1), widget.activeUser.userId);

                    Navigator.push(context, MaterialPageRoute(builder: (context) => new MessageScreen(conversation: newConversation!,receiver: receiverUser(convUsers), activeUser: widget.activeUser,)));
                  },
                );
              }
          ),
        ),
      ],
    );
  }

  void getAllContacts() async{

    List<Contact> _contacts = (await ContactsService.getContacts(withThumbnails: false)).toList();

    setState(() {

      contacts = _contacts;

    });

  }

  Future<void> createConversation(String receiver, int sender) async {


    final response = await http
        .get(Uri.parse('http://10.0.2.2:8080/createconv?receiver=$receiver&sender=$sender'));

    if(response.statusCode >= 200 && response.statusCode < 300) {
      //print(response.body);

      var responseList = json.decode(response.body);

      List<Message> messages = [];


      for(var k = 0; k < responseList['users'].length; k++) {

        convUsers.add(new AppUser(
            userId: responseList['users'][k]['userId'],
            firstName: responseList['users'][k]['firstName'],
            lastName: responseList['users'][k]['lastName'],
            hasStory: responseList['users'][k]['hasStory']),
        );
      }

      newConversation = new Conversation(
          conversationId: responseList['conversationId'],
          user: convUsers,
          message: messages
      );
    }
    else {
      print(response.statusCode);
    }

    print("user0 : ${convUsers.elementAt(0).userId}");
    print("user1 : ${convUsers.elementAt(1).userId}");

  }


}

class ContactCard extends StatelessWidget {
  const ContactCard({
    Key? key, required this.contact, required this.press
  }) : super(key: key);

  final VoidCallback press;
  final Contact contact;


  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: press,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Expanded(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(16.0, 0, 16, 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(contact.displayName!),
                        SizedBox(height: 6,),
                        Opacity(
                            opacity:0.64,
                            child: Text(contact.phones!.elementAt(0).value!,maxLines: 1),
                        ),
                      ],
                    ),
                ))
          ],
        ),
      ),
    );
  }
}
