import 'dart:convert';
import 'dart:math';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:the_project/main.dart';
import 'package:the_project/model/conversation.dart';
import 'package:the_project/model/message.dart';
import 'package:the_project/model/user.dart';
import 'package:the_project/routes/camera/camera_screen.dart';
import 'package:the_project/routes/chats/chat_screen.dart';
import 'package:the_project/routes/contacts/contacts.dart';
import 'package:the_project/routes/profile/profile.dart';
import 'package:the_project/routes/singInUp/register.dart';
import 'package:the_project/routes/welcome/components/appbar_title_enum.dart';
import 'package:the_project/utils/color.dart';
import 'package:provider/provider.dart';
import 'package:the_project/utils/style.dart';
import 'package:the_project/widgets/message_box_widget.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class HomePage extends StatefulWidget {
  const HomePage({Key? key, required this.activeUser}) : super(key: key);

  //final CameraDescription camera;
  final AppUser activeUser;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  var responseList=[];
  final chatList = <Conversation>[];
  int _selectedIndex=2;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchData();
  }

  late List<Widget> _widgetNavigation= [
    UserListView(chatList: chatList,activeUser: widget.activeUser,),
    ContactsScreen(activeUser: widget.activeUser, chatlist: chatList,),
    ProfilePage(activeUser: widget.activeUser,),
  ];


  @override
  Widget build(BuildContext context) {

    return Scaffold(
        bottomNavigationBar: SafeArea(
          child: BottomNavigationBar(
            fixedColor: AppColors.primaryAppColor,
            backgroundColor: AppColors.secondaryAppColor,
            currentIndex: _selectedIndex,
            onTap: (value) {
              setState(() {
                _selectedIndex = value;
              });
            },
            items: [
              BottomNavigationBarItem(icon: Icon(Icons.messenger), label: 'Chats'),
              BottomNavigationBarItem(icon: Icon(Icons.people_alt), label: 'Contacts'),
              BottomNavigationBarItem(icon: Icon(Icons.person_pin), label: 'Profile'),
            ],
          ),
        ),
        backgroundColor: AppColors.secondaryAppColor,
        appBar: appBar(),
        body: SafeArea(
            child: _widgetNavigation.elementAt(_selectedIndex)
        )
    );
  }

  /*
  Widget _loader(BuildContext context) {

    return AnimatedContainer(
      duration: Duration(seconds: 1),
      color: Colors.transparent,
      curve: Curves.easeInOut,
      height: 50,
      width: MediaQuery.of(context).size.width * (percentage / 100),
      child: GestureDetector(
        onTap: () {
          setState(() {
            if(percentage < 100) {
              percentage += 1;
            }
          });
        },
        onDoubleTap: () {
          setState(() {
            if(percentage < 90) {
              percentage += 10;
            }
            else {
              percentage = 100;
            }
          });
        },
        child: Container(
          color: Colors.blue,
        ),
      ),
    );
  } */

  var conditions = {
    0: 'Chats',
    1: 'New Chat',
    2: 'Profile'
  };

  PreferredSizeWidget appBar(){
    return AppBar(
      automaticallyImplyLeading: false,
      title: Text( conditions[_selectedIndex]!,style: TextStyle(fontSize: 35,color: AppColors.secondaryAppColor) ),
      elevation: 0,
      backgroundColor: AppColors.primaryAppColor,
      actions: [
        _selectedIndex == 2 ? SizedBox() : IconButton(
          icon: Icon(Icons.search, color: AppColors.secondaryAppColor),
          onPressed: () {
            //Navigator.push(context, MaterialPageRoute(builder: (context) => EditProfile()));
          },),
      ],
    );
  }

  Future<void> fetchData() async {

/*
    final response = await http.post(
      Uri.http(url.authority, url.path),
      headers: <String, String>{
        "Accept": "application/json",
        "Content-Type": "application/x-www-form-urlencoded; charset=UTF-8",
      },
      body: body,
      encoding: Encoding.getByName('utf-8'),
    );
*/
/*
    final response = await http.get(
      Uri.http(),
      headers: <String, String>{
        "Accept": "application/json",
        "Content-Type": "application/x-www-form-urlencoded; charset=UTF-8",
      },
    );
*/
    final response = await http
        .get(Uri.parse('http://localhost:8080/conversations?id=${widget.activeUser.userId}'));

    if(response.statusCode >= 200 && response.statusCode < 300) {

      //var jsonResponse = convert.jsonDecode(response.body) as Map<String, dynamic>;

      responseList = json.decode(response.body) as List;

      for (var i = 0; i < responseList.length; i++) {
        var messageList = <Message> [];
        var userList = <AppUser> [];

        for(var j = 0; j < responseList[i]['messages'].length; j++) {
          messageList.add(new Message(
              senderId: responseList[i]['messages'][j]['sender']['userId'],
              text: responseList[i]['messages'][j]['text'] ));
        }
        for(var k = 0; k < responseList[i]['users'].length; k++) {
          userList.add(new AppUser(
              userId: responseList[i]['users'][k]['userId'],
              firstName: responseList[i]['users'][k]['firstName'],
              lastName: responseList[i]['users'][k]['lastName'],
              hasStory: responseList[i]['users'][k]['hasStory']),
          );
        }
          chatList.add(new Conversation(
              conversationId: responseList[i]['conversationId'],
              user: userList,
              message: messageList
          ));
      }
      print('conversations successfully loaded');
    }
    else {
      print(response.statusCode);
    }

  }

}


