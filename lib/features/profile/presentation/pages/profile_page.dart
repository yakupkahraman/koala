import 'package:flutter/material.dart';
import 'package:koala/core/constants.dart';
import 'package:koala/features/home/presentation/widgets/my_list_tile.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        surfaceTintColor: Colors.white,
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          "Profilim",
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
          padding: EdgeInsets.all(UiConstants.defaultPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              profileHeader(),
              SizedBox(height: 40),
              //scoreArea(),
              SizedBox(height: 30),
              settingsList(),
            ],
          ),
        ),
      ),
    );
  }

  Row profileHeader() {
    return Row(
      children: [
        Container(
          width: 100,
          height: 100,
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(20),
            image: DecorationImage(
              fit: BoxFit.cover,
              image: AssetImage('assets/images/koala_profile_picture.png'),
            ),
          ),
        ),
        SizedBox(width: 20),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(width: 20),
            Text(
              "Yakup Demir",
              style: TextStyle(
                fontFamily: "Poppins",
                color: Colors.black,
                fontSize: 28,
                fontWeight: FontWeight.w500,
              ),
            ),
            Text(
              "28/06/2006",
              style: TextStyle(
                fontFamily: "Poppins",
                color: Colors.black,
                fontSize: 14,
                fontWeight: FontWeight.w400,
              ),
            ),
            Text(
              "Küçükçekmece/İstanbul",
              style: TextStyle(
                fontFamily: "Poppins",
                color: Colors.black,
                fontSize: 14,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Row scoreArea() {
    return Row(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 150,
              height: 150,
              decoration: BoxDecoration(
                image: DecorationImage(
                  alignment: Alignment.center,
                  image: AssetImage('assets/images/culsuz_koala.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Text(
              "Çulsuz Koala",
              style: TextStyle(
                fontFamily: "Poppins",
                color: Colors.black,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ],
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
