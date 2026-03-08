import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:koala/employee/features/home/presentation/widgets/my_list_tile.dart';
import 'package:koala/product/constants/app_padding.dart';
import 'package:koala/product/widgets/my_appbar.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BSettingsPage extends StatelessWidget {
  const BSettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppbar(title: "Ayarlar", fontSize: 24),
      body: SingleChildScrollView(
        child: Padding(
          padding: AppPadding.primaryAll,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [_settingsList(context)],
          ),
        ),
      ),
    );
  }

  Widget _settingsList(BuildContext context) {
    return Column(
      children: [
        MyListTile(
          icon: HugeIcons.strokeRoundedBuilding06,
          title: "Firma Bilgileri Düzenle",
          onTap: () {
            context.push('/business/company-info');
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
