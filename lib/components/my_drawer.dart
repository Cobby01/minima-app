import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  // Logout function
void logout() {
  FirebaseAuth.instance.signOut();
}

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.background,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
        Column(
          children: [
                    // drawer header
        DrawerHeader(
        child: Image.asset('assets/logo/Track it.png',
        color: Theme.of(context).colorScheme.inversePrimary,)
        ),
         const SizedBox(height: 25,),

        // home tile
        Padding(
          padding: const EdgeInsets.only(left: 25.0),
          child: ListTile(
            leading: Icon(
              Icons.home,
              color: Theme.of(context).colorScheme.inversePrimary,
            ),
            title: const Text("H O M E"),
            onTap: () {
              // this is already the home so just pop drawer
              Navigator.pop(context);

             // navigate to the list page
              Navigator.pushNamed(context, '/home_page');
            },
          ),
        ),

        // alert tile
         Padding(
          padding: const EdgeInsets.only(left: 25.0),
          child: ListTile(
            leading: Icon(
              Icons.notifications,
              color: Theme.of(context).colorScheme.inversePrimary,
            ),
            title:const  Text("A L E R T"),
            onTap: () {
              // this is already the home so just pop drawer
              Navigator.pop(context);

              // navigate to the list page
              Navigator.pushNamed(context, '/alert_page');
            },
          ),
        ),

        // list tile
                Padding(
          padding: const EdgeInsets.only(left: 25.0),
          child: ListTile(
            leading: Icon(
              Icons.list,
              color: Theme.of(context).colorScheme.inversePrimary,
            ),
            title: const Text("T R A C K E R  L I S T"),
            onTap: () {
              // this is already the home so just pop drawer
              Navigator.pop(context);

              // navigate to the list page
              Navigator.pushNamed(context, '/list_page');
            },
          ),
        ),

        // shop tile
        Padding(
          padding: const EdgeInsets.only(left: 25.0),
          child: ListTile(
            leading: Icon(
              Icons.shop,
              color: Theme.of(context).colorScheme.inversePrimary,
            ),
            title: const Text("S H O P"),
            onTap: () {
              // this is already the home so just pop drawer
              Navigator.pop(context);

              // navigate to the list page
              Navigator.pushNamed(context, '/shop_page');
            },
          ),
        ),
      ],
    ),

        // logout tile
                Padding(
          padding: const EdgeInsets.only(left: 25.0, bottom: 25),
          child: ListTile(
            leading: Icon(
              Icons.logout,
              color: Theme.of(context).colorScheme.inversePrimary,
            ),
            title: const  Text("L O G O U T"),
            onTap: () {
              // this is already the home so just pop drawer
              Navigator.pop(context);

              //logout
              logout();
            },
          ),
        )


      ],),
    );
  }
}