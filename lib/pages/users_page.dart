import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:minimal_social_app/components/my_text_box.dart';


class UsersPage extends StatefulWidget {
  const UsersPage({super.key});

  @override
  State<UsersPage> createState() => _UsersPageState();
}

class _UsersPageState extends State<UsersPage> {
    
    // user
    final currentUser = FirebaseAuth.instance.currentUser!;
    // all users
    final userCollection = FirebaseFirestore.instance.collection('Users');

    // edit field
    Future<void> editField(String field) async{
      String newValue = "";
      await showDialog(
        context: context,
        builder: (context) => AlertDialog(
          backgroundColor: Colors.grey[900],
          title: Text('Edit$field',
          style: const TextStyle(color: Colors.white),
          ),
          content: TextField(
            autofocus: true,
            style: const TextStyle(color: Colors.white),
            decoration: InputDecoration(
              hintText: 'Enter new $field',
              hintStyle: const TextStyle(color: Colors.grey),
            ),
            onChanged: (value) {
              newValue = value;
            },
          ),
          actions: [
            // cancel button
            TextButton(
              child: const Text('Cancel', style: TextStyle(color: Colors.white),),
              onPressed: () => Navigator.of(context).pop(newValue),
            ),

            // save button
              TextButton(
              child: const Text('Save',
               style: TextStyle(color: Colors.white),),
              onPressed: () => Navigator.pop(context),
            )
          ]
        ),
      );

      // update in the firestore
      if(newValue.trim().isNotEmpty){
        // only update if there is something in the textfield
        await userCollection.doc(currentUser.uid).update({field: newValue});
      }
    }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(''),
      ),

      body: StreamBuilder<DocumentSnapshot>(
        stream: FirebaseFirestore.instance.collection('Users').doc(currentUser.uid).snapshots(),
        builder: (context, snapshot) {
          // get user data
          if (snapshot.hasData){
            final userData = snapshot.data!.data() as Map<String, dynamic>;

            return ListView(
        children: [
          const SizedBox(height: 30,),

          // profile pic
          const Icon(Icons.person,
          size: 72,
          ),

          const SizedBox(height: 10,), 

          // user email
          Text(
            currentUser.email!,
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.grey[700]),
            ),
          
          const SizedBox(height: 30,),

          // user details
          Padding(
            padding: const EdgeInsets.only(left:25.0),
            child: Text(
              'My Details',
              style: TextStyle(color: Colors.grey[600]),
              ),
          ),

          // username
           MyTextBox(
            text: userData['username'],
             sectionName: 'Username',
             onPressed: () => editField('username'),
             ),

          // bio
            MyTextBox(
            text: userData['bio'],
             sectionName: 'bio',
             onPressed: () => editField('bio'),
             ),
        ],
      );

          } else if (snapshot.hasError) {
            return Center(child: Text('Error${snapshot.error}'
            ),
            );

          }
          return const Center(child: CircularProgressIndicator(),);
        },
        ),
      
    );
  }
}