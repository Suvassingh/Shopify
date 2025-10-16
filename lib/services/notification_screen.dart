

import 'package:firebase_messaging_platform_interface/src/remote_message.dart';
import 'package:flutter/material.dart';
import 'package:shopify/utils/app_constants.dart';

class NotificationScreen extends StatelessWidget {
  final RemoteMessage message;
  const NotificationScreen({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Notification",style: TextStyle(fontWeight: FontWeight.bold,color: AppConstants.appTextColour),),
        backgroundColor: AppConstants.appMainColour,
        centerTitle: true,

      ),
      body: Card(
        elevation: 5,
        child: ListTile
        (
          leading: Icon(Icons.notifications_active),
          title:Text(message.notification!.title.toString()),
          subtitle: Text(message.notification!.body.toString()),
          trailing: Text(message.data['screen'].toString()),
        
        
        ),
      ),
    );
  }
}