import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart';
import 'package:the_project/routes/singInUp/register.dart';
import 'package:the_project/routes/welcome/home.dart';
import 'package:the_project/utils/color.dart';
import 'package:the_project/utils/style.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:the_project/widgets/primary_button.dart';

class ForgetPassword extends StatefulWidget {
  @override
  _ForgetPasswordState createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {

  //final AuthService _auth = AuthService();

  String userId = '';
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor:Color.fromRGBO(233, 65, 82, 1),
      appBar: AppBar(
        backgroundColor:AppColors.primaryAppColor ,
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
                      children: [
                        Text("Forgot your password?",
                            style: GoogleFonts.pacifico(
                              fontWeight: FontWeight.bold,
                              fontSize: 50,
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
                                    borderSide: BorderSide(color: Colors.black),
                                    borderRadius: BorderRadius.all(Radius.circular(30.0)),
                                  ),
                                ),
                                keyboardType: TextInputType.number,

                                validator: (String? value) {
                                  if(value == null) {
                                    return 'ERROR';
                                  }
                                  else {
                                    if(value.isEmpty) {
                                      return 'Please enter phone number ';
                                    }
                                  }

                                  return null;
                                },
                                onSaved: (String? value) {
                                  userId = value ?? '';
                                },
                                onChanged: (String? value) {
                                  userId = value ?? '';
                                } ,
                              ),
                            ),
                          ],
                        ),

                        SizedBox(height: 32.0,),

                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Expanded(
                              child: PrimaryButton(
                                text: 'Reset my password now!',
                                color: AppColors.buttoncolor,
                                press: () async {

                                  if(_formKey.currentState!.validate()) {

                                    await rememberPostRequest(userId);
                                    showAlertDialog('Info', 'Your password sent to your email!');


                                  }
                                  else {
                                    showAlertDialog('Login', 'Please check your phone number!');
                                  }
                                },
                              ),
                            ),
                          ],
                        ),

                        SizedBox(height: 16,),

                        Spacer(flex:2)
                      ],
                    ),
                  ),
                ),
              ),


              SizedBox(height: defaultPadding*1.5,),


              //Spacer(flex: 2,)
            ],
          ),

        ),
      ),
    );
  }


  Future<void> rememberPostRequest(String userId) async {

    final uri = Uri.parse('http://10.0.2.2:8080/remember');
    final headers = {'Content-Type': 'application/json'};
    Map<String, dynamic> body = {'userId': userId};
    String jsonBody = json.encode(body);
    final encoding = Encoding.getByName('utf-8');

    final response = await post(
      uri,
      headers: headers,
      body: jsonBody,
      encoding: encoding,
    );

    int statusCode = response.statusCode;
    var responseBody = json.decode(response.body);

    print("remember request status code : $statusCode");
    print(responseBody);

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