import 'dart:convert';
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart';
import 'package:the_project/model/conversation.dart';
import 'package:the_project/model/message.dart';
import 'package:the_project/model/user.dart';
import 'package:the_project/routes/messages/websocket_ex.dart';
import 'package:the_project/routes/singInUp/forget_password.dart';
import 'package:the_project/routes/singInUp/register.dart';
import 'package:the_project/routes/welcome/home.dart';
import 'package:the_project/utils/color.dart';
import 'package:the_project/utils/style.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:the_project/widgets/primary_button.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class SignIn extends StatefulWidget {

  const SignIn({Key? key}) : super(key: key);

  //final CameraDescription camera;

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {


  AppUser? activeUser;
  String _userId = '';
  String _pass = '';
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }
  


  Future<bool> loginPostRequest(String userId, String pass) async {

    final url = Uri.parse('http://localhost:8080/login');
    final headers = {'Content-Type': 'application/json'};
    Map<String, dynamic> body = {'userId': userId, 'password' : pass};
    String jsonBody = json.encode(body);
    final encoding = Encoding.getByName('utf-8');

    final response = await post(
      url,
      headers: headers,
      body: jsonBody,
      encoding: encoding,
    );

    int statusCode = response.statusCode;
    var responseBody = json.decode(response.body) as List;

    print("login request status code : $statusCode");

    if(responseBody.isNotEmpty){
      activeUser = new AppUser(userId: responseBody[0]['userId'], firstName: responseBody[0]['firstName'], lastName: responseBody[0]['lastName'], hasStory: false);
      return true;
    }else{
      return false;
    }
  }

  /*
  Future<void> postRequest(String messageId, String title ) async {
    final response = await http.post(
      Uri.parse('http://10.0.2.2:8080/register'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'messageId': messageId,
        'text': title,
      }),
    );

    if (response.statusCode >= 200 && response.statusCode < 300) {
      // If the server did return a 201 CREATED response,
      // then parse the JSON.
       print(jsonDecode(response.body));
    } else {
      // If the server did not return a 201 CREATED response,
      // then throw an exception.
      print(response.statusCode);
    }
  }
 */

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor:Color.fromRGBO(233, 65, 82, 1),
      appBar: AppBar(
        backgroundColor:AppColors.primaryAppColor ,
        automaticallyImplyLeading: false,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
              Container(
              height: 550,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: AppColors.primaryAppColor,
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(80),
                    bottomRight: Radius.circular(80)),
              ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Sing In",
                            style: GoogleFonts.pacifico(
                              fontWeight: FontWeight.bold,
                              fontSize: 40,
                              color: Colors.white,
                            )),
                        SizedBox(height: defaultPadding*3,),
                        Row(
                          children: [
                            Expanded(
                              child: TextFormField(
                                decoration: InputDecoration(
                                  fillColor: Colors.white,
                                  filled: true,
                                  hintText: 'Enter your 10 digits phone number',
                                  //labelText: 'Username',
                                  //labelStyle: kLabelLightTextStyle,
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide(color: AppColors.contentColorLightTheme),
                                    borderRadius: BorderRadius.all(Radius.circular(30.0)),
                                  ),
                                ),
                                keyboardType: TextInputType.number,

                                validator: (String? value) {

                                  _userId = value ?? '';

                                  if(value == null) {
                                    return 'ERROR';
                                  }
                                  else {
                                    if(value.isEmpty) {
                                      return 'Please enter your phone number';
                                    }
                                  }

                                  return null;
                                },
                                onSaved: (String? value) {
                                  _userId = value!;
                                },
                                onChanged: (String? value) {
                                  _userId = value!;

                                } ,
                              ),
                            ),
                          ],
                        ),

                        SizedBox(height: 16.0,),

                        Row(
                          children: [
                            Expanded(
                              child: TextFormField(
                                decoration: InputDecoration(
                                  fillColor: Colors.white,
                                  filled: true,
                                  hintText: 'Enter your password',
                                  //labelText: 'Username',
                                  //labelStyle: kLabelLightTextStyle,
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.black),
                                    borderRadius: BorderRadius.all(Radius.circular(30.0)),
                                  ),
                                ),
                                keyboardType: TextInputType.text,
                                obscureText: true,
                                enableSuggestions: false,
                                autocorrect: false,

                                validator: (String? value) {

                                  _pass = value ?? '';

                                  if(value == null) {
                                    return 'ERROR';
                                  }
                                  else {
                                    if(value.isEmpty) {
                                      return 'Please enter your password';
                                    }
                                    if(value.length < 8) {
                                      return 'Password must be at least 8 characters';
                                    }
                                  }

                                  return null;
                                },
                                onSaved: (String? value) {
                                  _pass = value ?? '';
                                },
                                  onChanged: (String? value) {
                                    _pass = value!;
                                  }
                              ),
                            ),
                          ],
                        ),

                        SizedBox(height: 48,),

                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Expanded(
                              child: PrimaryButton(
                                text: 'Sing In',
                                color: AppColors.buttoncolor,
                                press: () async {



                                  if(_formKey.currentState!.validate()) {
                                    if(await loginPostRequest(_userId,_pass)){
                                      Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage(activeUser: activeUser!)));

                                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Logging in')));
                                    }else{
                                      showAlertDialog('Login', 'Please check your phone number or password!');
                                    }
                                  }
                                  else {
                                    print('Form incorrect');
                                  }
                                },
                              ),
                            ),
                          ],
                        ),

                        SizedBox(height: 12,),

                        Row(
                          children: [
                            Expanded(
                              child: TextButton(
                                child: Text(
                                  'Don\'t remember?',
                                  style: TextStyle(
                                    color: AppColors.contentColorLightTheme.withOpacity(0.5),
                                    fontSize: 18
                                  ),
                                ),
                                onPressed: () {
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => ForgetPassword()));
                                },
                              ),
                            ),
                          ],
                        ),

                        Spacer(flex:2)
                      ],
                    ),
                  ),
                ),
              ),

                SizedBox(height: defaultPadding*1.5,),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                      TextButton(
                        child: Text(
                          'Register now!',
                          style: TextStyle(
                            decoration: TextDecoration.underline,
                            color: AppColors.contentColorLightTheme,
                            fontWeight: FontWeight.bold,
                            fontSize: 20
                          ),
                        ),
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => Register()));                        },
                      ),
                    //Icon(Icons.arrow_forward_ios_outlined,size: 20,)
                  ],
                ),
                //Spacer(flex: 2,)
              ],
            ),

        ),
      ),
    );
  }

  Future<void> showAlertDialog(String title, String message) async {

    bool isIOS = Platform.isIOS;

    return showDialog<void> (
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {

          if(isIOS) {
            return CupertinoAlertDialog(
              title: Text(title),
              content: Column(
                  children: [
                    Text(message),
                  ]
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    print('Alert tap');
                    Navigator.of(context).pop();
                  },
                  child: Text('OK'),
                ),
              ],
            );
          }
          else {
            return AlertDialog(
              contentPadding: EdgeInsets.fromLTRB(16, 0, 16, 8),
              titlePadding: EdgeInsets.fromLTRB(16, 8, 16, 0),
              title: Row(
                children: [
                  Text(title),

                  Spacer(),

                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Icon(Icons.close, color: Colors.red),
                  )
                ],
              ),
              actions: [
                OutlinedButton(
                  onPressed: () {
                    print('Alert tap');
                    Navigator.of(context).pop();
                  },
                  child: Text('OK'),
                ),
              ],
              content: SingleChildScrollView(
                child: ListBody(
                  children: [
                    Text(message),
                  ],
                ),
              ),
            );
          }
        }
    );
  }

}