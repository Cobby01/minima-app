import 'package:flutter/material.dart';

class HomeTabBox extends StatelessWidget {
  final String cardName;
  final String iconPath;
  final VoidCallback? onTap;
  final  String route;

  const HomeTabBox({
    super.key,
    required this.cardName,
    required this.iconPath,
    required this.onTap,
    required this.route,  
    });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.grey[400],
            borderRadius: BorderRadius.circular(15),
          ),
          padding: const EdgeInsets.symmetric(vertical: 20,
          horizontal: 5,),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // icon
              Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: Image.asset(iconPath),
              ),
              // name 
              Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: Text(cardName,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Roboto  ',
                ),
                ),
              ),
      
            ],
          ),
        ),
      ),
    );
  }
}