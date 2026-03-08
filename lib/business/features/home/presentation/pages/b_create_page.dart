import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:koala/business/features/home/data/fake_business_company.dart';
import 'package:koala/business/features/home/presentation/providers/b_jobs_provider.dart';
import 'package:koala/employee/features/home/data/models/job_model.dart';
import 'package:koala/product/constants/app_colors.dart';
import 'package:koala/product/constants/app_padding.dart';
import 'package:koala/product/widgets/button_navbar.dart';
import 'package:koala/product/widgets/my_appbar.dart';
import 'package:koala/product/widgets/my_textfield.dart';
import 'package:provider/provider.dart';

class BCreatePage extends StatefulWidget {
  const BCreatePage({super.key});

  @override
  State<BCreatePage> createState() => _BCreatePageState();
}

class _BCreatePageState extends State<BCreatePage> {
  final _titleController = TextEditingController();
  final _subtitleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _priceController = TextEditingController();
  final _addressController = TextEditingController();
  final _sectorController = TextEditingController();
  final _positionController = TextEditingController();
  final _dutiesController = TextEditingController();
  final _dressCodeController = TextEditingController();
  final _minAgeController = TextEditingController();
  final _maxAgeController = TextEditingController();

  JobCategory _selectedCategory = JobCategory.waiter;
  JobType _selectedType = JobType.oneTime;
  bool _experienceRequired = false;
  bool _insuranceRequired = false;

  @override
  void dispose() {
    _titleController.dispose();
    _subtitleController.dispose();
    _descriptionController.dispose();
    _priceController.dispose();
    _addressController.dispose();
    _sectorController.dispose();
    _positionController.dispose();
    _dutiesController.dispose();
    _dressCodeController.dispose();
    _minAgeController.dispose();
    _maxAgeController.dispose();
    super.dispose();
  }

  void _createJob() {
    if (_titleController.text.trim().isEmpty ||
        _priceController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Lütfen başlık ve ücret alanlarını doldurun',
            style: TextStyle(fontFamily: 'Poppins'),
          ),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    final companyName = FakeBusinessCompany.instance.name;
    final now = DateTime.now();
    final jobId = 'b_${now.millisecondsSinceEpoch}';

    final job = JobModel(
      id: jobId,
      latitude: 39.9208,
      longitude: 32.8541,
      type: _selectedType,
      category: _selectedCategory,
      title: _titleController.text.trim(),
      subtitle: _subtitleController.text.trim().isEmpty
          ? _titleController.text.trim()
          : _subtitleController.text.trim(),
      price: double.tryParse(_priceController.text.trim()) ?? 0,
      company: companyName,
      description: _descriptionController.text.trim().isEmpty
          ? null
          : _descriptionController.text.trim(),
      sector: _sectorController.text.trim().isEmpty
          ? null
          : _sectorController.text.trim(),
      position: _positionController.text.trim().isEmpty
          ? null
          : _positionController.text.trim(),
      duties: _dutiesController.text.trim().isEmpty
          ? null
          : _dutiesController.text.trim(),
      insuranceRequired: _insuranceRequired,
      startDateTime: now,
      salaryType: 'FIXED',
      minAge: int.tryParse(_minAgeController.text.trim()),
      maxAge: int.tryParse(_maxAgeController.text.trim()),
      experienceRequired: _experienceRequired,
      dressCode: _dressCodeController.text.trim().isEmpty
          ? null
          : _dressCodeController.text.trim(),
      employerType: 'COMPANY',
      address: _addressController.text.trim().isEmpty
          ? 'Ankara'
          : _addressController.text.trim(),
    );

    context.read<BJobsProvider>().createJobPost(job);
    _showSuccessDialog();
  }

  void _showSuccessDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (dialogContext) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 72,
                height: 72,
                decoration: BoxDecoration(
                  color: Colors.green.withValues(alpha: 0.1),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.check_circle_outline,
                  color: Colors.green,
                  size: 48,
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                'İlan Oluşturuldu!',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'İlanınız başarıyla oluşturuldu ve aktif ilanlarınızda görüntülenecek.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 14,
                  color: Colors.grey[600],
                  height: 1.4,
                ),
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(dialogContext);
                    context.go('/business/posts');
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryColor,
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                  ),
                  child: const Text(
                    'İlanlarıma Git',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: MyAppbar(title: "Yeni İlan Oluştur"),
      bottomNavigationBar: ButtonNavbar(
        onPressed: _createJob,
        title: "İlanı Yayınla",
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: AppPadding.primaryAll,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Temel Bilgiler
              _sectionLabel("Temel Bilgiler"),
              const SizedBox(height: 16),
              MyTextfield(
                labelText: "İlan Başlığı *",
                controller: _titleController,
              ),
              const SizedBox(height: 16),
              MyTextfield(
                labelText: "Kısa Açıklama",
                controller: _subtitleController,
              ),
              const SizedBox(height: 16),
              MyTextfield(
                labelText: "Ücret (₺) *",
                controller: _priceController,
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 16),
              MyTextfield(labelText: "Adres", controller: _addressController),

              const SizedBox(height: 24),

              // Kategori & Tip
              _sectionLabel("Kategori ve Tip"),
              const SizedBox(height: 12),
              _categorySelector(),
              const SizedBox(height: 16),
              _typeSelector(),

              const SizedBox(height: 24),

              // Detaylı Bilgiler
              _sectionLabel("Detaylı Bilgiler"),
              const SizedBox(height: 12),
              _descriptionTextField(),
              const SizedBox(height: 16),
              MyTextfield(labelText: "Sektör", controller: _sectorController),
              const SizedBox(height: 16),
              MyTextfield(
                labelText: "Pozisyon",
                controller: _positionController,
              ),
              const SizedBox(height: 16),
              MyTextfield(labelText: "Görevler", controller: _dutiesController),

              const SizedBox(height: 24),

              // Gereksinimler
              _sectionLabel("Gereksinimler"),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: MyTextfield(
                      labelText: "Min Yaş",
                      controller: _minAgeController,
                      keyboardType: TextInputType.number,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: MyTextfield(
                      labelText: "Max Yaş",
                      controller: _maxAgeController,
                      keyboardType: TextInputType.number,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              MyTextfield(
                labelText: "Kıyafet Kuralı",
                controller: _dressCodeController,
              ),
              const SizedBox(height: 12),
              _switchTile(
                title: "Deneyim Gerekli",
                value: _experienceRequired,
                onChanged: (v) => setState(() => _experienceRequired = v),
              ),
              _switchTile(
                title: "Sigorta Gerekli",
                value: _insuranceRequired,
                onChanged: (v) => setState(() => _insuranceRequired = v),
              ),

              const SizedBox(height: 60),
            ],
          ),
        ),
      ),
    );
  }

  Widget _sectionLabel(String title) {
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

  Widget _categorySelector() {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: JobCategory.values.map((category) {
        final isSelected = _selectedCategory == category;
        return GestureDetector(
          onTap: () => setState(() => _selectedCategory = category),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
            decoration: BoxDecoration(
              color: isSelected
                  ? category.color.withValues(alpha: 0.15)
                  : Colors.grey[100],
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: isSelected ? category.color : Colors.grey[300]!,
                width: isSelected ? 2 : 1,
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  category.icon,
                  size: 16,
                  color: isSelected ? category.color : Colors.grey[600],
                ),
                const SizedBox(width: 6),
                Text(
                  category.displayName,
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 13,
                    fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                    color: isSelected ? category.color : Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _typeSelector() {
    return Row(
      children: JobType.values.map((type) {
        final isSelected = _selectedType == type;
        return Expanded(
          child: GestureDetector(
            onTap: () => setState(() => _selectedType = type),
            child: Container(
              margin: EdgeInsets.only(
                right: type == JobType.oneTime ? 8 : 0,
                left: type == JobType.recurring ? 8 : 0,
              ),
              padding: const EdgeInsets.symmetric(vertical: 12),
              decoration: BoxDecoration(
                color: isSelected
                    ? AppColors.primaryColor.withValues(alpha: 0.1)
                    : Colors.grey[100],
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: isSelected
                      ? AppColors.primaryColor
                      : Colors.grey[300]!,
                  width: isSelected ? 2 : 1,
                ),
              ),
              child: Center(
                child: Text(
                  type.displayName,
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 14,
                    fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                    color: isSelected
                        ? AppColors.primaryColor
                        : Colors.grey[600],
                  ),
                ),
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _descriptionTextField() {
    return TextField(
      controller: _descriptionController,
      maxLines: 4,
      decoration: InputDecoration(
        labelText: "Açıklama",
        labelStyle: TextStyle(fontFamily: 'Poppins', color: Colors.grey[600]),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: Theme.of(context).colorScheme.primary,
            width: 2.0,
          ),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16.0,
          vertical: 14.0,
        ),
      ),
      style: const TextStyle(fontFamily: 'Poppins', fontSize: 16),
    );
  }

  Widget _switchTile({
    required String title,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontFamily: 'Poppins',
              fontSize: 15,
              fontWeight: FontWeight.w500,
              color: Colors.black87,
            ),
          ),
          Switch(
            value: value,
            onChanged: onChanged,
            activeThumbColor: AppColors.primaryColor,
          ),
        ],
      ),
    );
  }
}
