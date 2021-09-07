import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:core';

class ChatScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('chats/S8u1j1UkAHIQHkh817vI/messages').snapshots(),
        builder: (ctx, snapShot){
          if (snapShot.hasError) {
            return Text('Something went wrong');
          }
          if (snapShot.connectionState == ConnectionState.waiting){
            return CircularProgressIndicator();
          }
          /*final docs = snapShot.data!.doc() ;*/

          return ListView.builder(
            itemCount: 10,
            itemBuilder: (ctx, index)=> Container(
              padding: EdgeInsets.all(8),
              child: Text(''),
            )
        );
        },

      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: (){
          FirebaseFirestore.instance
              .collection('chats/S8u1j1UkAHIQHkh817vI/messages')
              .add({'text': "Button text"});
        },
      ),
    );
  }
}
