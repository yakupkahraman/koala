import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:koala/employee/features/profile/data/models/user.dart';
import 'package:koala/product/constants/app_colors.dart';
import 'package:koala/product/constants/app_padding.dart';
import 'package:koala/product/widgets/my_textfield.dart';
import 'package:koala/product/widgets/button_navbar.dart';
import 'package:koala/product/widgets/my_appbar.dart';

class AccountInfoPage extends StatefulWidget {
  final User user;

  const AccountInfoPage({super.key, required this.user});

  @override
  State<AccountInfoPage> createState() => _AccountInfoPageState();
}

class _AccountInfoPageState extends State<AccountInfoPage> {
  late TextEditingController _fullNameController;
  late TextEditingController _jobTitleController;
  late TextEditingController _locationController;
  late TextEditingController _aboutController;
  late TextEditingController _cvFileNameController;

  @override
  void initState() {
    super.initState();
    _fullNameController = TextEditingController(text: widget.user.fullName);
    _jobTitleController = TextEditingController(text: widget.user.jobTitle);
    _locationController = TextEditingController(text: widget.user.location);
    _aboutController = TextEditingController(text: widget.user.about);
    _cvFileNameController = TextEditingController(text: widget.user.cvFileName);
  }

  @override
  void dispose() {
    _fullNameController.dispose();
    _jobTitleController.dispose();
    _locationController.dispose();
    _aboutController.dispose();
    _cvFileNameController.dispose();
    super.dispose();
  }

  void _save() {
    final updatedUser = widget.user.copyWith(
      fullName: _fullNameController.text.trim(),
      jobTitle: _jobTitleController.text.trim(),
      location: _locationController.text.trim(),
      about: _aboutController.text.trim(),
      cvFileName: _cvFileNameController.text.trim(),
    );
    context.pop(updatedUser);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppbar(title: "Hesabı Düzenle"),
      bottomNavigationBar: ButtonNavbar(onPressed: _save, title: "Kaydet"),
      body: SingleChildScrollView(
        child: Padding(
          padding: AppPadding.primaryAll,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Stack(
                  children: [
                    Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: AssetImage(widget.user.profileImage),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Container(
                        padding: EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          color: AppColors.primaryColor,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.camera_alt,
                          color: Colors.white,
                          size: 18,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 30),
              SizedBox(height: 8),
              MyTextfield(
                labelText: "Ad Soyad",
                controller: _fullNameController,
              ),
              SizedBox(height: 16),
              MyTextfield(labelText: "Meslek", controller: _jobTitleController),
              SizedBox(height: 16),
              MyTextfield(labelText: "Konum", controller: _locationController),
              SizedBox(height: 16),
              _aboutTextField(),
              SizedBox(height: 16),
              MyTextfield(
                labelText: "CV Dosya Adı",
                controller: _cvFileNameController,
              ),
              SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  Widget _aboutTextField() {
    return TextField(
      controller: _aboutController,
      maxLines: 4,
      decoration: InputDecoration(
        labelText: "Hakkımda",
        labelStyle: TextStyle(fontFamily: 'Poppins', color: Colors.grey[600]),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: Theme.of(context).colorScheme.primary,
            width: 2.0,
          ),
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 14.0),
      ),
      style: TextStyle(fontFamily: 'Poppins', fontSize: 16),
    );
  }
}
