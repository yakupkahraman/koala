// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:koala/core/widgets/my_button.dart';
import 'package:koala/core/widgets/my_textfield.dart';
import 'package:koala/core/constants.dart';

class CompanyInformationsPage extends StatefulWidget {
  const CompanyInformationsPage({super.key});

  @override
  State<CompanyInformationsPage> createState() =>
      _CompanyInformationsPageState();
}

class _CompanyInformationsPageState extends State<CompanyInformationsPage> {
  final TextEditingController companyNameController = TextEditingController();
  final TextEditingController companyAddressController =
      TextEditingController();
  final TextEditingController taxNumberController = TextEditingController();
  final TextEditingController sectorController = TextEditingController();
  final TextEditingController companyPhoneController = TextEditingController();
  final TextEditingController companyEmailController = TextEditingController();
  final TextEditingController websiteController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  // Soft renkler listesi
  final List<Color> _softColors = [
    Colors.blue.withOpacity(0.2),
    Colors.green.withOpacity(0.2),
    Colors.purple.withOpacity(0.2),
    Colors.orange.withOpacity(0.2),
    Colors.teal.withOpacity(0.2),
    Colors.pink.withOpacity(0.2),
    Colors.indigo.withOpacity(0.2),
    Colors.cyan.withOpacity(0.2),
    Colors.red.withOpacity(0.2),
    Colors.amber.withOpacity(0.2),
    Colors.deepPurple.withOpacity(0.2),
    Colors.lightGreen.withOpacity(0.2),
  ];

  Color _currentAvatarColor = Colors.grey.withOpacity(0.2);

  @override
  void initState() {
    super.initState();
    // Firma adı değiştiğinde CircleAvatar'ı güncellemek için listener ekle
    companyNameController.addListener(_updateAvatar);
  }

  void _updateAvatar() {
    setState(() {
      // Firma adı değiştiğinde rastgele soft renk seç
      if (companyNameController.text.isNotEmpty) {
        final random = companyNameController.text.hashCode % _softColors.length;
        _currentAvatarColor = _softColors[random.abs()];
      } else {
        _currentAvatarColor = Colors.grey.withOpacity(0.2);
      }
    });
  }

  String _getInitials() {
    String text = companyNameController.text.trim();
    if (text.isEmpty) return 'Logo';

    if (text.length >= 2) {
      return text.substring(0, 2).toUpperCase();
    } else {
      return text[0].toUpperCase();
    }
  }

  Color _getTextColor() {
    // Arkaplan rengine göre uyumlu text rengi döndür
    if (companyNameController.text.isEmpty) {
      return Colors.grey[600]!;
    }

    // Arkaplan renginin ana rengini al ve daha koyu bir tonu kullan
    if (_currentAvatarColor == Colors.blue.withOpacity(0.2)) {
      return Colors.blue[700]!;
    }
    if (_currentAvatarColor == Colors.green.withOpacity(0.2)) {
      return Colors.green[700]!;
    }
    if (_currentAvatarColor == Colors.purple.withOpacity(0.2)) {
      return Colors.purple[700]!;
    }
    if (_currentAvatarColor == Colors.orange.withOpacity(0.2)) {
      return Colors.orange[700]!;
    }
    if (_currentAvatarColor == Colors.teal.withOpacity(0.2)) {
      return Colors.teal[700]!;
    }
    if (_currentAvatarColor == Colors.pink.withOpacity(0.2)) {
      return Colors.pink[700]!;
    }
    if (_currentAvatarColor == Colors.indigo.withOpacity(0.2)) {
      return Colors.indigo[700]!;
    }
    if (_currentAvatarColor == Colors.cyan.withOpacity(0.2)) {
      return Colors.cyan[700]!;
    }
    if (_currentAvatarColor == Colors.red.withOpacity(0.2)) {
      return Colors.red[700]!;
    }
    if (_currentAvatarColor == Colors.amber.withOpacity(0.2)) {
      return Colors.amber[700]!;
    }
    if (_currentAvatarColor == Colors.deepPurple.withOpacity(0.2)) {
      return Colors.deepPurple[700]!;
    }
    if (_currentAvatarColor == Colors.lightGreen.withOpacity(0.2)) {
      return Colors.lightGreen[700]!;
    }

    return ThemeConstants.primaryColor;
  }

  @override
  void dispose() {
    companyNameController.removeListener(_updateAvatar);
    companyNameController.dispose();
    companyAddressController.dispose();
    taxNumberController.dispose();
    sectorController.dispose();
    companyPhoneController.dispose();
    companyEmailController.dispose();
    websiteController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(HugeIcons.strokeRoundedArrowLeft01, color: Colors.black),
          onPressed: () => context.pop(),
        ),
        backgroundColor: Colors.white,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(left: 16.0, right: 16.0, bottom: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Firma Adı
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  child: Column(
                    children: [
                      Text(
                        "Şirket Bilgilerini Giriniz",
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 40,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 30),
                      MyTextfield(
                        labelText: "Firma Adı*",
                        controller: companyNameController,
                        keyboardType: TextInputType.text,
                      ),
                      const SizedBox(height: 15),

                      // Firma Adresi
                      MyTextfield(
                        labelText: "Firma Adresi*",
                        controller: companyAddressController,
                        keyboardType: TextInputType.streetAddress,
                      ),
                      const SizedBox(height: 15),

                      // Vergi Numarası
                      MyTextfield(
                        labelText: "Vergi Numarası*",
                        controller: taxNumberController,
                        keyboardType: TextInputType.number,
                      ),
                      const SizedBox(height: 15),

                      // Sektör
                      MyTextfield(
                        labelText: "Sektör*",
                        controller: sectorController,
                        keyboardType: TextInputType.text,
                      ),
                      const SizedBox(height: 15),

                      // Şirket Numarası
                      MyTextfield(
                        labelText: "Şirket Numarası",
                        controller: companyPhoneController,
                        keyboardType: TextInputType.phone,
                      ),
                      const SizedBox(height: 15),

                      // Şirket Maili
                      MyTextfield(
                        labelText: "Şirket E-posta",
                        controller: companyEmailController,
                        keyboardType: TextInputType.emailAddress,
                      ),
                      const SizedBox(height: 15),

                      // Website
                      MyTextfield(
                        labelText: "Website",
                        controller: websiteController,
                        keyboardType: TextInputType.url,
                      ),
                      const SizedBox(height: 15),

                      // Açıklama
                      Row(
                        children: [
                          Expanded(
                            child: SizedBox(
                              height: 100,
                              child: TextField(
                                controller: descriptionController,
                                maxLines: null,
                                expands: true,
                                textAlignVertical: TextAlignVertical.top,
                                decoration: InputDecoration(
                                  labelText: "Açıklama",
                                  alignLabelWithHint: true,
                                  labelStyle: TextStyle(
                                    fontFamily: 'Poppins',
                                    color: Colors.grey[600],
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8.0),
                                    borderSide: BorderSide(
                                      color: ThemeConstants.primaryColor,
                                      width: 2.0,
                                    ),
                                  ),
                                  contentPadding: EdgeInsets.symmetric(
                                    horizontal: 16.0,
                                    vertical: 18.0,
                                  ),
                                  isDense: true,
                                ),
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 15),
                          GestureDetector(
                            onTap: () {
                              // Logo seçme işlevi
                            },
                            child: SizedBox(
                              width: 80,
                              height: 100,
                              child: Stack(
                                alignment: Alignment.center,
                                children: [
                                  CircleAvatar(
                                    radius: 40,
                                    backgroundColor: _currentAvatarColor,
                                    child: Text(
                                      _getInitials(),
                                      style: TextStyle(
                                        fontFamily: 'Poppins',
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: _getTextColor(),
                                      ),
                                    ),
                                  ),
                                  // Attachment icon köşede
                                  Positioned(
                                    bottom: 5,
                                    right: 5,
                                    child: Container(
                                      width: 30,
                                      height: 30,
                                      decoration: BoxDecoration(
                                        color: ThemeConstants.primaryColor,
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                          color: Colors.white,
                                          width: 2,
                                        ),
                                      ),
                                      child: Icon(
                                        HugeIcons.strokeRoundedEdit03,
                                        size: 16,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 30),
                    ],
                  ),
                ),

                // Kaydet Butonu
                MyButton(
                  onPressed: () {
                    // Form verilerini işle
                    _saveCompanyInformation();
                  },
                  title: "KAYDET",
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _saveCompanyInformation() {
    // Form validation
    if (companyNameController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Lütfen firma adını giriniz',
            style: TextStyle(fontFamily: 'Poppins'),
          ),
          backgroundColor: Colors.red,
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }

    // Başarı mesajı
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Şirket bilgileri başarıyla kaydedildi',
          style: TextStyle(fontFamily: 'Poppins'),
        ),
        backgroundColor: ThemeConstants.primaryColor,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }
}
