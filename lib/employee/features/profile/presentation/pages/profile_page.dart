import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:koala/employee/features/home/presentation/widgets/my_list_tile.dart';
import 'package:koala/employee/features/profile/presentation/widgets/experience_card.dart';
import 'package:koala/product/constants/app_colors.dart';
import 'package:koala/product/constants/app_padding.dart';

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
        actions: [
          IconButton(
            onPressed: () {
              context.push('/settings');
            },
            icon: HugeIcon(
              icon: HugeIcons.strokeRoundedSettings01,
              color: Colors.black,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: AppPadding.primaryAll,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              profileHeader(),
              SizedBox(height: 20),
              aboutProfile(),
              SizedBox(height: 20),
              cvArea(),
              SizedBox(height: 30),
              rosettes(),
              SizedBox(height: 30),
              experienceSection(),
              SizedBox(height: 120),
              //settingsList(),
            ],
          ),
        ),
      ),
    );
  }

  Column rosettes() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Rozetler",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        SizedBox(
          height: 150,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              Image.asset("assets/images/koala_gezgin_altin.png"),
              Image.asset("assets/images/koala_gezgin_gumus_1.png"),
            ],
          ),
        ),
      ],
    );
  }

  Column aboutProfile() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Hakkımda",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        Text(
          "Profesyonel etkinlik ve ürün fotoğrafçısıyım. Yüksek kaliteli ekipman ve hızlı teslimat garantisiyle çalışıyorum. İşlerinize değer katacak profesyonel kareler için profili inceleyebilir, hemen iletişime geçebilirsiniz.",
        ),
      ],
    );
  }

  Container cvArea() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 24),
      decoration: BoxDecoration(
        color: AppColors.primaryColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Özgeçmiş",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text("yakup_demir_cv.pdf", style: TextStyle(color: Colors.white)),
            ],
          ),
          HugeIcon(
            icon: HugeIcons.strokeRoundedFileAttachment,
            color: Colors.white,
          ),
        ],
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
              "Fotoğrafçı",
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

  Column experienceSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Tecrübe",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 12),
        ExperienceCard(
          title: "Kıdemli Fotoğrafçı",
          company: "Studio Kreatif",
          duration: "Ocak 2023 - Halen",
          description:
              "Kurumsal etkinlik ve ürün fotoğrafçılığı. Haftalık ortalama 5 etkinlik çekimi.",
        ),
        ExperienceCard(
          title: "Fotoğrafçı",
          company: "EventShot Medya",
          duration: "Mart 2021 - Aralık 2022",
          description:
              "Düğün, nişan ve özel gün fotoğrafçılığı. 200+ etkinlikte görev aldım.",
        ),
        ExperienceCard(
          title: "Stajyer Fotoğrafçı",
          company: "Lens Ajans",
          duration: "Haziran 2020 - Şubat 2021",
          description:
              "Stüdyo çekimleri, ışık düzeni kurulumu ve post-prodüksiyon süreçlerinde destek.",
        ),
        ExperienceCard(
          title: "Freelance Fotoğrafçı",
          company: "Serbest",
          duration: "Ocak 2019 - Mayıs 2020",
          description:
              "Sosyal medya içerik üretimi, portre ve doğa fotoğrafçılığı. 50+ müşteri portföyü.",
          isLast: true,
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
