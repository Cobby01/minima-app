import 'package:flutter/material.dart';

// class UsersPage extends StatelessWidget {
//   const UsersPage ({super.key});
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Users Page'),
//         centerTitle: true,
//         backgroundColor:  Theme.of(context).colorScheme.inversePrimary,
//         foregroundColor:   Theme.of(context).colorScheme.primary,
//       ),
//       body: const Padding(
//         padding: EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             CircleAvatar(
//               radius: 50,
//               backgroundImage: AssetImage('assets/logo/Track it.png'),// add your profile image here
//             ),
//             SizedBox(height: 16),
//             Text(
//               'Cobby',
//               style: TextStyle(
//                 fontSize: 24,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//            SizedBox(height: 16),
//            Text(
//             'cobby@gmail.com',
//             style: TextStyle(
//               fontSize: 16,
//               fontWeight: FontWeight.normal,
//             ),
//            ),
//            SizedBox(height: 24),
//           ],
//         ),
//       ),
//     );
//   }
// }

class UsersPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const CircleAvatar(
              radius: 60,
              backgroundImage: AssetImage('assets/logo/Track it.png'),
            ),
            SizedBox(height: 20),
            Text(
              'John Doe',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Text(
              'john.doe@example.com',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: () {
                // Navigate to edit profile page
              },
              icon: Icon(Icons.edit),
              label: Text('Edit Profile'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
