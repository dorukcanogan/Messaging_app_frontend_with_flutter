import 'package:flutter/material.dart';
import 'package:the_project/model/user.dart';

class StoryView extends StatelessWidget {
  const StoryView({Key? key,required this.user}) : super(key: key);

  final AppUser user;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            width:double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/stories/STRY_${user.userId}.jpg'),
                fit: BoxFit.cover
              )
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 36, horizontal: 8),
            child: Column(
              children: [
                SizedBox( height: 20,),
                Row(
                  children: [
                    CircleAvatar(radius: 24,backgroundImage:AssetImage('assets/IMG_${user.userId}.jpeg')),
                    SizedBox( width: 8,),
                    Text(
                      user.firstName + ' '+ user.lastName,
                      style: TextStyle(color: Colors.white,fontSize: 18),
                    )
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
