import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class NewMessageWidget extends StatefulWidget {
  const NewMessageWidget({Key? key}) : super(key: key);

  @override
  _NewMessageWidgetState createState() => _NewMessageWidgetState();
}

class _NewMessageWidgetState extends State<NewMessageWidget> {
  
  final _controller = TextEditingController();
  String message = '';

  void sendMessage() {

    saveData(message);

    _controller.clear();

  }

  void saveData(String text) async {
    final response = await http
        .get(Uri.parse('http://10.0.2.2:8080/saveMessage?text=$text'));

    if(response.statusCode >= 200 && response.statusCode < 300) {
      //print(response.body);
      //var jsonResponse = convert.jsonDecode(response.body) as Map<String, dynamic>;

      //var responseList = json.decode(response.body) as List;
        print('gönderildi');
      //print(responseList);
    }
    else {
      //print(response.statusCode);
    }
    //print(response.toString());
  }
  
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _controller,
              textCapitalization: TextCapitalization.sentences,
              autocorrect: true,
              enableSuggestions: true,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.grey[100],
                labelText: 'Type your message...',
                labelStyle: TextStyle(color: Colors.red),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide(color: Color.fromRGBO(64, 55, 55, 1.0)),
                  gapPadding: 8,
                ),
              ),
              onChanged: (newValue) {
                setState(() {
                  message = newValue;
                });
              },
            ),
          ),

          SizedBox(width: 16,),

          GestureDetector(
            onTap: message.trim().isEmpty ? null:sendMessage,
            child: Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.blue,
              ),
              child: Icon(
                Icons.send,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
