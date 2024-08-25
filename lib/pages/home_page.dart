import 'package:flutter/material.dart';
import 'package:minimal_social_app/components/home_tab_box.dart';
import 'package:minimal_social_app/components/my_drawer.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // paddings constants
  final double horizontalPadding = 20.0;
  final double verticalPadding = 20.0;

  // list of card of quick navigation
  final List<List<String>> cards = [
    // [card name, iconPath, route]
    ['Add Device', 'assets/images/vector/Group.png', '/add_device_page'],
    ['Device Manager', 'assets/images/vector/List.png', '/list_page'],
    ['Map', 'assets/images/vector/Map.png', '/map_page'],
    ['Shop', 'assets/images/vector/shop.png', '/shop_page'],
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        title: const Text(''),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        foregroundColor: Theme.of(context).colorScheme.inversePrimary,
        actions: [
          // go to user profile button
          IconButton(
            onPressed: () => Navigator.pushNamed(context, '/users_page'),
            icon: const Icon(
              Icons.person,
            ),
          ),
        ],
      ),
      drawer: const MyDrawer(),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: horizontalPadding,
                vertical: verticalPadding,
              ),
            ),
            const SizedBox(height: 20),
            // welcome user name
            Padding(
              padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Welcome,",
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  Text(
                    "ELIKPLIM",
                    style: TextStyle(
                      color: Colors.deepPurpleAccent,
                      fontSize: 40,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            // Cards
            Expanded(
              child: GridView.builder(
                itemCount: cards.length,
                padding: const EdgeInsets.all(10),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                ),
                itemBuilder: (context, index) {
                  return HomeTabBox(
                    cardName: cards[index][0],
                    iconPath: cards[index][1],
                    route: cards[index][2],
                    onTap: () {
                      Navigator.pushNamed(context, cards[index][2]);
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
