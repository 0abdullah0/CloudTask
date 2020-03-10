import 'dart:io';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'message.dart';
//import 'package:firebase_database/firebase_database.dart';
//import 'package:firebase_core/firebase_core.dart';

class MessageWidget extends StatefulWidget {
  @override
  _MessageWidgetState createState() => _MessageWidgetState();
}

class _MessageWidgetState extends State<MessageWidget> {
  final FirebaseMessaging _firebaseMessaging= FirebaseMessaging();
  //final DatabaseReference notificationref=FirebaseDatabase.instance.reference().child("Notifications");
  final List<Message> messages=[];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _firebaseMessaging.configure(
        onMessage: (Map<String,dynamic> message)async{ //foreground
          print("on message:$message");
          final notification =message['notification'];
          setState(() {
            messages.add(Message(notification['title'],notification['body']));
            //notificationref.push().set(messages[messages.length].toJSON());
          });

        },
        onLaunch: (Map<String,dynamic> message){ //closed
          print("on launch:$message");
          final notification =message['notification'];
          setState(() {
            messages.add(Message(notification['title'],notification['body']));
            //notificationref.push().set(messages[messages.length].toJSON());
          });
        },
        onResume: (Map<String,dynamic> message){  //background
          print("on resume:$message");
          final notification =message['notification'];
          setState(() {
            messages.add(Message(notification['title'],notification['body']));
            //notificationref.push().set(messages[messages.length].toJSON());
          });
        }
    );
    //notificationref.onChildAdded.listen(_onEntryAdded);
  }
  /*_onEntryAdded(Event event){
    setState(() {
      //messages.add(Message.fromSnapshot(event.snapshot));
    });
  }*/
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        Expanded(
            child: ListView(

              shrinkWrap: true,
                children: messages.map(buildMessage).toList()
            )
        ),

        Row(
          children: <Widget>[
            RaisedButton(onPressed:()=>_firebaseMessaging.subscribeToTopic("PL"),child:Text("PL subscribe"),),
            RaisedButton(onPressed:()=>saveDeviceToken(),child:Text("get token"),),
          ],
        )
      ],
    );

  }

  Widget buildMessage(Message message)=>ListTile(
    title:Text(message.title),
    subtitle: Text(message.body),
  );

saveDeviceToken()async{
    String uid="abdullah";
    String fcmToken=await _firebaseMessaging.getToken();
    print(fcmToken);
    }
}
