
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:the_project/model/user.dart';
import 'package:the_project/widgets/profile_widget.dart';


class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key, required this.activeUser}) : super(key: key);

  final AppUser activeUser;

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    //final user = UserPreferences.myUser;

    return Scaffold(
      body: ListView(
        physics: BouncingScrollPhysics(),
        children: [
          const SizedBox(height: 36),
          ProfileWidget(
            onClicked: () async {},
            activeUser: widget.activeUser,
          ),
          const SizedBox(height: 24),
          buildName(widget.activeUser),
          /*const SizedBox(height: 24),
          NumbersWidget(),
          const SizedBox(height: 48),
          buildAbout(user), */
        ],
      ),
    );
  }

  Widget buildName(AppUser user) => Column(
    children: [
      Text(
        user.firstName+' '+user.lastName,
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
      ),
      const SizedBox(height: 4),
      Text(
        user.userId.toString(),
        style: TextStyle(color: Colors.grey),
      )
    ],
  );

  /*
  Widget buildAbout(User user) => Container(
    padding: EdgeInsets.symmetric(horizontal: 48),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'About',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),
        Text(
          user.about,
          style: TextStyle(fontSize: 16, height: 1.4),
        ),
      ],
    ),
  ); */
}
