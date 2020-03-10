import 'package:flutter/material.dart';
//import 'package:firebase_database/firebase_database.dart';
//import 'package:firebase_core/firebase_core.dart';

class Message{

  String title;
  String body;

   Message(@required this.title,@required this.body);

   /*Message.fromSnapshot(DataSnapshot snapshot):
      title=snapshot.value['title'],
      body=snapshot.value['body'];*/

   toJSON(){
     return {
       "title":title,
       "body":body,
     };
   }

}