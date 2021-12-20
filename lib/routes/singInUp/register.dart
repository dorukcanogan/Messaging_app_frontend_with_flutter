import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart';
import 'package:the_project/routes/singInUp/register.dart';
import 'package:the_project/routes/singInUp/sign_in.dart';
import 'package:the_project/routes/welcome/home.dart';
import 'package:the_project/utils/color.dart';
import 'package:the_project/utils/style.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:the_project/widgets/primary_button.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {

  //final AuthService _auth = AuthService();

  String firstName = '';
  String lastName = '';
  int userId = 0;
  String email='';
  String password = '';

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
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Register",
                            style: GoogleFonts.pacifico(
                              fontWeight: FontWeight.bold,
                              fontSize: 40,
                              color: Colors.white,
                            )),
                        SizedBox(height: defaultPadding,),
                        Row(
                          children: [
                            Expanded(
                              child: TextFormField(
                                decoration: InputDecoration(
                                  fillColor: Colors.white,
                                  filled: true,
                                  hintText: 'First name',
                                  //labelText: 'Username',
                                  //labelStyle: kLabelLightTextStyle,
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.black),
                                    borderRadius: BorderRadius.all(Radius.circular(30.0)),
                                  ),
                                ),
                                keyboardType: TextInputType.emailAddress,

                                validator: (String? value) {

                                  if(value == null) {
                                    return 'ERROR';
                                  }
                                  else {
                                    if(value.isEmpty) {
                                      return 'Please enter your e-mail';
                                    }
                                  }

                                  return null;
                                },
                                onSaved: (String? value) {
                                  firstName = value ?? '';
                                },
                                onChanged: (String? value) {
                                  firstName = value ?? '';
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
                                  hintText: 'Last name',
                                  //labelText: 'Username',
                                  //labelStyle: kLabelLightTextStyle,
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.black),
                                    borderRadius: BorderRadius.all(Radius.circular(30.0)),
                                  ),
                                ),
                                keyboardType: TextInputType.text,
                                enableSuggestions: false,
                                autocorrect: false,

                                validator: (String? value) {
                                  if(value == null) {
                                    return 'ERROR';
                                  }
                                  else {
                                    if(value.isEmpty) {
                                      return 'Please enter your last name';
                                    }
                                  }

                                  return null;
                                },
                                onSaved: (String? value) {
                                  lastName = value ?? '';
                                },
                                onChanged: (String? value) {
                                  lastName = value ?? '';
                                } ,
                              ),
                            ),
                          ],
                        ),

                        SizedBox(height: 16,),

                        Row(
                          children: [
                            Expanded(
                              child: TextFormField(
                                decoration: InputDecoration(
                                  fillColor: Colors.white,
                                  filled: true,
                                  hintText: 'Phone number',
                                  //labelText: 'Username',
                                  //labelStyle: kLabelLightTextStyle,
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.black),
                                    borderRadius: BorderRadius.all(Radius.circular(30.0)),
                                  ),
                                ),
                                keyboardType: TextInputType.phone,

                                validator: (String? value) {
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
                                  userId = int.parse(value ?? '');
                                },
                                onChanged: (String? value) {
                                  userId = int.parse(value ?? '');
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
                                  hintText: 'E-mail address',
                                  //labelText: 'Username',
                                  //labelStyle: kLabelLightTextStyle,
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.black),
                                    borderRadius: BorderRadius.all(Radius.circular(30.0)),
                                  ),
                                ),
                                keyboardType: TextInputType.emailAddress,

                                validator: (String? value) {
                                  if(value == null) {
                                    return 'ERROR';
                                  }
                                  else {
                                    if(value.isEmpty) {
                                      return 'Please enter your e-mail';
                                    }
                                    if(!EmailValidator.validate(value)) {
                                      return 'The e-mail address is not valid';
                                    }
                                  }

                                  return null;
                                },
                                onSaved: (String? value) {
                                  email = value ?? '';
                                },
                                onChanged: (String? value) {
                                  email = value ?? '';

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
                                  hintText: 'Password',
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
                                  password = value ?? '';
                                },
                                onChanged: (String? value) {
                                  password = value ?? '';
                                } ,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 16.0,),

                        Spacer(flex:2)
                      ],
                    ),
                  ),
                ),
              ),
              //Spacer(flex: 1,),
              //Image.network('http://apcupsler.com/assets/images/referanslarmz-14-600x400.jpg'),
              //Spacer(),

              SizedBox(height: defaultPadding*1.5,),

              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
                      child: PrimaryButton(
                        text: 'Register now!',
                        color: AppColors.buttoncolor,
                        press: () async {

                          if(_formKey.currentState!.validate()) {
                            if(await registerPostRequest(firstName, lastName, userId, email, password)){
                              Navigator.push(context, MaterialPageRoute(builder: (context) => SignIn()));

                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Registered!')));
                            }else{
                              showAlertDialog('Register', 'Email or phone number is currently used by another user!');
                            }
                          }
                          else {
                            print('Form incorrect');
                          }
                        },
                      ),
                    ),
                  ),
                ],
              ),
              //Spacer(flex: 2,)
            ],
          ),

        ),
      ),
    );
  }


  Future<bool> registerPostRequest(String firstName, String lastName, int userId, String email, String password ) async {

    final uri = Uri.parse('http://10.0.2.2:8080/register');
    final headers = {'Content-Type': 'application/json'};
    Map<String, dynamic> body = {'firstName': firstName, 'lastName' : lastName,'userId' : userId,'email' : email, 'password': password };
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

    print("register request status code : $statusCode");
    return responseBody.isNotEmpty;

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