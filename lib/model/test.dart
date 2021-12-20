import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

class User {
  String? name;
  String? surname;
  int? userId;

  User({required this.name, required this.surname, required this.userId });

  String get nameAndSurname => "name: $name"+"surname: $surname";

  @override
  String toString() {
    return "Name: $name"+"Surname:$surname"+"UserID:$userId";
  }

}