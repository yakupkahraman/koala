import 'package:flutter/material.dart';

class MyListTile extends StatelessWidget {
  const MyListTile({super.key, required this.title, required this.icon});

  final String title;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: ListTile(
        tileColor: Colors.grey[200],
        contentPadding: EdgeInsets.only(left: 20, right: 10),
        leading: Icon(icon),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Text(
          title,
          style: TextStyle(
            fontFamily: "Poppins",
            color: Colors.black,
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
        trailing: Icon(Icons.arrow_forward_ios, size: 16),
        onTap: () {},
      ),
    );
  }
}
