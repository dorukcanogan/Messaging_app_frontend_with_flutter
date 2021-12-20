import 'package:the_project/model/user.dart';

import 'message.dart';

class Conversation {
  final int conversationId;
  final List<AppUser> user;
  final List<Message> message;

  Conversation({required this.conversationId,required this.user,required this.message});
}