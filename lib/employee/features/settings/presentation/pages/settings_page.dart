import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:koala/employee/features/home/presentation/widgets/my_list_tile.dart';
import 'package:koala/product/constants/app_padding.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
            children: [settingsList(context)],
          ),
        ),
      ),
    );
  }

  Column settingsList(BuildContext context) {
    return Column(
      children: [
        MyListTile(icon: Icons.person_outline, title: "Hesap Bilgilerim"),
        MyListTile(icon: Icons.settings, title: "Uygulama Ayarları"),
        MyListTile(icon: Icons.question_mark_rounded, title: "Yardım"),
        MyListTile(
          icon: Icons.logout,
          title: "Çıkış Yap",
          onTap: () async {
            final prefs = await SharedPreferences.getInstance();
            await prefs.setBool('is_logged_in', false);
            await prefs.remove('user_type');

            if (context.mounted) {
              context.go('/authgate');
            }
          },
        ),
      ],
    );
  }
}
