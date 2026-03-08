import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:koala/employee/features/home/presentation/widgets/my_list_tile.dart';
import 'package:koala/employee/features/profile/data/fake_user.dart';
import 'package:koala/employee/features/profile/data/models/user.dart';
import 'package:koala/product/constants/app_padding.dart';
import 'package:koala/product/widgets/my_appbar.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppbar(title: "Ayarlar", fontSize: 24),
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
        MyListTile(
          icon: HugeIcons.strokeRoundedUser,
          title: "Hesabı Düzenle",
          onTap: () async {
            final user = FakeUser.instance;
            final updatedUser = await context.push<User>(
              '/account-info',
              extra: user,
            );
            if (updatedUser != null) {
              FakeUser.instance.fullName = updatedUser.fullName;
              FakeUser.instance.jobTitle = updatedUser.jobTitle;
              FakeUser.instance.location = updatedUser.location;
              FakeUser.instance.about = updatedUser.about;
              FakeUser.instance.cvFileName = updatedUser.cvFileName;
            }
          },
        ),
        MyListTile(
          icon: HugeIcons.strokeRoundedLogout01,
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
