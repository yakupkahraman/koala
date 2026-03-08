import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:koala/business/features/home/data/fake_business_company.dart';
import 'package:koala/employee/features/company_detail/domain/company_model.dart';
import 'package:koala/product/constants/app_colors.dart';
import 'package:koala/product/constants/app_padding.dart';
import 'package:koala/product/widgets/my_appbar.dart';

class BProfilePage extends StatefulWidget {
  const BProfilePage({super.key});

  @override
  State<BProfilePage> createState() => _BProfilePageState();
}

class _BProfilePageState extends State<BProfilePage> {
  late CompanyModel company;

  @override
  void initState() {
    super.initState();
    company = FakeBusinessCompany.instance;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: MyAppbar(
        title: "Profilim",
        fontSize: 24,
        showBackButton: false,
        actions: [
          IconButton(
            onPressed: () async {
              await context.push('/business/settings');
              setState(() {
                company = FakeBusinessCompany.instance;
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _profileHeader(),
            Padding(
              padding: AppPadding.primaryHorizontal,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 24),
                  _aboutSection(),
                  const SizedBox(height: 24),
                  _contactInfoSection(),
                  const SizedBox(height: 24),
                  _addressSection(),
                  const SizedBox(height: 24),
                  _statsSection(),
                  const SizedBox(height: 120),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _profileHeader() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.primaryColor,
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(24),
          bottomRight: Radius.circular(24),
        ),
      ),
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
      child: Column(
        children: [
          // Logo
          Container(
            width: 90,
            height: 90,
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              border: Border.all(color: Colors.white, width: 3),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.15),
                  blurRadius: 12,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: ClipOval(
              child: company.logo != null
                  ? Image.network(
                      company.logo!.url,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => _logoPlaceholder(),
                    )
                  : _logoPlaceholder(),
            ),
          ),
          const SizedBox(height: 12),

          // Şirket Adı
          Text(
            company.name,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontFamily: 'Poppins',
              fontSize: 22,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 4),

          // Şirket Tipi Badge
          if (company.type != null)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                company.type!.displayName,
                style: const TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
              ),
            ),
          const SizedBox(height: 8),

          // Onay durumu
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                company.isApproved
                    ? HugeIcons.strokeRoundedCheckmarkCircle02
                    : HugeIcons.strokeRoundedAlert02,
                color: Colors.white,
                size: 16,
              ),
              const SizedBox(width: 6),
              Text(
                company.isApproved ? 'Onaylı İşletme' : 'Onay Bekliyor',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 13,
                  fontWeight: FontWeight.w400,
                  color: Colors.white.withValues(alpha: 0.9),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _logoPlaceholder() {
    return Container(
      color: Colors.grey[200],
      child: Icon(
        HugeIcons.strokeRoundedBuilding06,
        size: 40,
        color: Colors.grey[400],
      ),
    );
  }

  // _editProfileButton removed — editing is now in BSettingsPage > BCompanyInfoPage

  Widget _aboutSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _sectionTitle("Hakkımızda"),
        const SizedBox(height: 8),
        Text(
          company.description ?? 'Henüz bir açıklama eklenmemiş.',
          style: const TextStyle(
            fontFamily: 'Poppins',
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: Colors.black87,
            height: 1.5,
          ),
        ),
      ],
    );
  }

  Widget _contactInfoSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _sectionTitle("İletişim Bilgileri"),
        const SizedBox(height: 12),
        _infoCard([
          _infoRow(HugeIcons.strokeRoundedMail01, "E-posta", company.email),
          if (company.phoneNumber != null)
            _infoRow(
              HugeIcons.strokeRoundedCall,
              "Telefon",
              company.phoneNumber!,
            ),
          if (company.website != null)
            _infoRow(
              HugeIcons.strokeRoundedGlobe02,
              "Website",
              company.website!,
            ),
          if (company.taxNumber != null)
            _infoRow(
              HugeIcons.strokeRoundedFile01,
              "Vergi No",
              company.taxNumber!,
            ),
        ]),
      ],
    );
  }

  Widget _addressSection() {
    if (company.address == null) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _sectionTitle("Adres"),
        const SizedBox(height: 12),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.grey[50],
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey[200]!),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(
                HugeIcons.strokeRoundedLocation01,
                size: 22,
                color: AppColors.primaryColor,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (company.address!.street != null)
                      Text(
                        company.address!.street!,
                        style: const TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Colors.black87,
                        ),
                      ),
                    const SizedBox(height: 2),
                    Text(
                      [
                        company.address!.district,
                        company.address!.city,
                        company.address!.country,
                      ].where((e) => e != null && e.isNotEmpty).join(', '),
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 13,
                        fontWeight: FontWeight.w400,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _statsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _sectionTitle("İstatistikler"),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: _statCard(
                icon: HugeIcons.strokeRoundedWork,
                value: "12",
                label: "Aktif İlan",
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _statCard(
                icon: HugeIcons.strokeRoundedUserMultiple,
                value: "48",
                label: "Başvuru",
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _statCard(
                icon: HugeIcons.strokeRoundedStar,
                value: "4.8",
                label: "Puan",
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _statCard({
    required IconData icon,
    required String value,
    required String label,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
      decoration: BoxDecoration(
        color: AppColors.primaryColor.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: AppColors.primaryColor.withValues(alpha: 0.2),
        ),
      ),
      child: Column(
        children: [
          Icon(icon, size: 24, color: AppColors.primaryColor),
          const SizedBox(height: 8),
          Text(
            value,
            style: const TextStyle(
              fontFamily: 'Poppins',
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            label,
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 12,
              fontWeight: FontWeight.w400,
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }

  Widget _sectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontFamily: 'Poppins',
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: Colors.black87,
      ),
    );
  }

  Widget _infoCard(List<Widget> children) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[200]!),
      ),
      child: Column(children: children),
    );
  }

  Widget _infoRow(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 20, color: AppColors.primaryColor),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: Colors.grey[500],
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  value,
                  style: const TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
