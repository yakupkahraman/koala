import 'package:flutter/material.dart';
import 'package:koala/employee/features/home/presentation/widgets/my_list_tile.dart';
import 'package:koala/product/constants/app_padding.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        surfaceTintColor: Colors.white,
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          "Ayarlar",
          style: TextStyle(
            fontFamily: "Poppins",
            color: Colors.black,
            fontSize: 24,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: AppPadding.primaryAll,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [settingsList()],
          ),
        ),
      ),
    );
  }

  Column settingsList() {
    return Column(
      children: [
        MyListTile(icon: Icons.person_outline, title: "Hesap Bilgilerim"),
        MyListTile(icon: Icons.settings, title: "Uygulama Ayarları"),
        MyListTile(icon: Icons.question_mark_rounded, title: "Yardım"),
        MyListTile(icon: Icons.logout, title: "Çıkış Yap"),
      ],
    );
  }
}
