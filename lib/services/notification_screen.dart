import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging_platform_interface/src/remote_message.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:shopify/utils/app_constants.dart';

// ignore: must_be_immutable
class NotificationScreen extends StatefulWidget {
  final RemoteMessage? message;
   NotificationScreen({super.key, this.message});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  User? user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Notification",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: AppConstants.appTextColour,
          ),
        ),
        backgroundColor: AppConstants.appMainColour,
        centerTitle: true,
      ),
      body:StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('notifications')
            .doc(user!.uid)
            .collection('notifications')
            // .where('isSale', isEqualTo: true)
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return const Center(
              child: Text("Error"),
            );
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CupertinoActivityIndicator(),
            );
          }

          if (snapshot.data!.docs.isEmpty) {
            return const Center(
              child: Text("No notifications found!"),
            );
          }

          if (snapshot.data != null) {
            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                String docId = snapshot.data!.docs[index].id;
                return GestureDetector(
                  onTap: () async {
                    print("Docid => $docId");
                    await FirebaseFirestore.instance
                        .collection('notifications')
                        .doc(user!.uid)
                        .collection('notifications')
                        .doc(docId)
                        .update(
                      {
                        "isSeen": true,
                      },
                    );
                  },
                  child: Card(
                    color: snapshot.data!.docs[index]['isSeen']
                        ? Colors.green.withOpacity(0.3)
                        : Colors.blue.withOpacity(0.3),
                    elevation: snapshot.data!.docs[index]['isSeen'] ? 0 : 5,
                    child: ListTile(
                      leading: CircleAvatar(
                        child: Icon(snapshot.data!.docs[index]['isSeen']
                            ? Icons.done
                            : Icons.notification_add),
                      ),
                      title: Text(snapshot.data!.docs[index]['title']),
                      subtitle: Text(snapshot.data!.docs[index]['body']),
                    ),
                  ),
                );
              },
            );
          }

          return Container();
        },
      ),
    );
  }
}
