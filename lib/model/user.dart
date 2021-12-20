import 'message.dart';

class AppUser {
  final int userId;
  final String firstName;
  final String lastName;
  final bool hasStory;

  AppUser({required this.userId, required this.firstName,required this.lastName, required this.hasStory});
}