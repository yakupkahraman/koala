import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:koala/employee/features/profile/data/fake_user.dart';
import 'package:koala/employee/features/profile/data/models/user.dart';
import 'package:koala/employee/features/profile/presentation/widgets/experience_card.dart';
import 'package:koala/product/constants/app_colors.dart';
import 'package:koala/product/constants/app_padding.dart';
import 'package:koala/product/widgets/my_appbar.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late User user;

  @override
  void initState() {
    super.initState();
    user = FakeUser.instance;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Ayarlardan döndüğünde güncel veriyi al
    setState(() {
      user = FakeUser.instance;
    });
  }

  void _navigateToAccountInfo() async {
    final updatedUser = await context.push<User>('/account-info', extra: user);
    if (updatedUser != null) {
      setState(() {
        user = updatedUser;
        // Fake user'ı da güncelle ki uygulama genelinde tutarlı olsun
        FakeUser.instance.fullName = updatedUser.fullName;
        FakeUser.instance.jobTitle = updatedUser.jobTitle;
        FakeUser.instance.location = updatedUser.location;
        FakeUser.instance.about = updatedUser.about;
        FakeUser.instance.cvFileName = updatedUser.cvFileName;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppbar(
        title: "Profilim",
        fontSize: 24,
        showBackButton: false,
        actions: [
          IconButton(
            onPressed: () async {
              await context.push('/settings');
              // Ayarlardan döndüğünde profili güncelle
              setState(() {
                user = FakeUser.instance;
              });
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
            ],
          ),
        ),
      ),
    );
  }

  Widget editProfileButton() {
    return SizedBox(
      width: double.infinity,
      child: OutlinedButton.icon(
        onPressed: _navigateToAccountInfo,
        icon: Icon(Icons.edit, size: 18),
        label: Text(
          "Profili Düzenle",
          style: TextStyle(fontFamily: "Poppins", fontWeight: FontWeight.w500),
        ),
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.primaryColor,
          side: BorderSide(color: AppColors.primaryColor),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          padding: EdgeInsets.symmetric(vertical: 12),
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
        SizedBox(height: 4),
        Text(user.about, style: TextStyle(fontFamily: "Poppins", fontSize: 14)),
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
              Text(user.cvFileName, style: TextStyle(color: Colors.white)),
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
              image: AssetImage(user.profileImage),
            ),
          ),
        ),
        SizedBox(width: 20),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              user.fullName,
              style: TextStyle(
                fontFamily: "Poppins",
                color: Colors.black,
                fontSize: 28,
                fontWeight: FontWeight.w500,
              ),
            ),
            Text(
              user.jobTitle,
              style: TextStyle(
                fontFamily: "Poppins",
                color: Colors.black,
                fontSize: 14,
                fontWeight: FontWeight.w400,
              ),
            ),
            Text(
              user.location,
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
        ...user.experiences.asMap().entries.map((entry) {
          final index = entry.key;
          final exp = entry.value;
          return ExperienceCard(
            title: exp.title,
            company: exp.company,
            duration: exp.duration,
            description: exp.description,
            isLast: index == user.experiences.length - 1,
          );
        }),
      ],
    );
  }
}
