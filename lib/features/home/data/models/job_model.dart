import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';

/// İş kategorilerini temsil eden enum
enum JobCategory { photography, waiter, petCare, design, barista }

/// İş tipini temsil eden enum (Günlük veya Tekrarlı)
enum JobType { oneTime, recurring }

/// JobCategory için extension - ikon ve renk bilgileri
extension JobCategoryExtension on JobCategory {
  /// Her iş kategorisi için ikon
  IconData get icon {
    switch (this) {
      case JobCategory.photography:
        return HugeIcons.strokeRoundedCamera01;
      case JobCategory.waiter:
        return HugeIcons.strokeRoundedRestaurant01;
      case JobCategory.petCare:
        return HugeIcons.strokeRoundedPenTool01;
      case JobCategory.design:
        return HugeIcons.strokeRoundedPaintBoard;
      case JobCategory.barista:
        return HugeIcons.strokeRoundedCoffee01;
    }
  }

  /// Her iş kategorisi için renk
  Color get color {
    switch (this) {
      case JobCategory.photography:
        return const Color(0xFF9C27B0); // Mor
      case JobCategory.waiter:
        return const Color(0xFFFF5722); // Turuncu
      case JobCategory.petCare:
        return const Color(0xFF4CAF50); // Yeşil
      case JobCategory.design:
        return const Color(0xFF2196F3); // Mavi
      case JobCategory.barista:
        return const Color(0xFF795548); // Kahverengi
    }
  }

  /// Her iş kategorisi için Türkçe isim
  String get displayName {
    switch (this) {
      case JobCategory.photography:
        return 'Fotoğrafçılık';
      case JobCategory.waiter:
        return 'Garsonluk';
      case JobCategory.petCare:
        return 'Hayvan Bakımı';
      case JobCategory.design:
        return 'Tasarım';
      case JobCategory.barista:
        return 'Barista';
    }
  }

  /// Her iş kategorisi için SVG pin asset yolu
  String get pinAsset {
    switch (this) {
      case JobCategory.photography:
        return 'assets/map_pins/photography.svg';
      case JobCategory.waiter:
        return 'assets/map_pins/waiter.svg';
      case JobCategory.petCare:
        return 'assets/map_pins/pet_care.svg';
      case JobCategory.design:
        return 'assets/map_pins/design.svg';
      case JobCategory.barista:
        return 'assets/map_pins/barista.svg';
    }
  }
}

/// JobType için extension - Türkçe isimler
extension JobTypeExtension on JobType {
  String get displayName {
    switch (this) {
      case JobType.oneTime:
        return 'Günlük';
      case JobType.recurring:
        return 'Tekrarlı';
    }
  }
}

class JobModel {
  final String id;
  final double latitude;
  final double longitude;
  final JobType type;
  final JobCategory category;
  final String title;
  final String subtitle;
  final double price;
  final String? imageUrl;
  final String? company;
  final String? description;
  final String? sector;
  final String? position;
  final String? duties;
  final bool? insuranceRequired;
  final DateTime? startDateTime;
  final DateTime? endDateTime;
  final String? salaryType;
  final int? minAge;
  final int? maxAge;
  final bool? experienceRequired;
  final String? dressCode;
  final String? employerType;
  final String? address;

  const JobModel({
    required this.id,
    required this.latitude,
    required this.longitude,
    required this.type,
    required this.category,
    required this.title,
    required this.subtitle,
    required this.price,
    this.imageUrl,
    this.company,
    this.description,
    this.sector,
    this.position,
    this.duties,
    this.insuranceRequired,
    this.startDateTime,
    this.endDateTime,
    this.salaryType,
    this.minAge,
    this.maxAge,
    this.experienceRequired,
    this.dressCode,
    this.employerType,
    this.address,
  });

  /// JSON'dan model oluşturma
  factory JobModel.fromJson(Map<String, dynamic> json) {
    return JobModel(
      id: json['id'] as String,
      latitude: (json['latitude'] as num).toDouble(),
      longitude: (json['longitude'] as num).toDouble(),
      type: JobType.values.firstWhere(
        (e) => e.name == json['type'],
        orElse: () => JobType.oneTime,
      ),
      category: JobCategory.values.firstWhere(
        (e) => e.name == json['category'],
        orElse: () => JobCategory.waiter,
      ),
      title: json['title'] as String,
      subtitle: json['subtitle'] as String,
      price: (json['price'] as num).toDouble(),
      imageUrl: json['imageUrl'] as String?,
      company: json['company'] as String?,
      description: json['description'] as String?,
      sector: json['sector'] as String?,
      position: json['position'] as String?,
      duties: json['duties'] as String?,
      insuranceRequired: json['insuranceRequired'] as bool?,
      startDateTime: json['startDateTime'] != null
          ? DateTime.parse(json['startDateTime'] as String)
          : null,
      endDateTime: json['endDateTime'] != null
          ? DateTime.parse(json['endDateTime'] as String)
          : null,
      salaryType: json['salaryType'] as String?,
      minAge: json['minAge'] as int?,
      maxAge: json['maxAge'] as int?,
      experienceRequired: json['experienceRequired'] as bool?,
      dressCode: json['dressCode'] as String?,
      employerType: json['employerType'] as String?,
      address: json['address'] as String?,
    );
  }

  /// Model'den JSON oluşturma
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'latitude': latitude,
      'longitude': longitude,
      'type': type.name,
      'category': category.name,
      'title': title,
      'subtitle': subtitle,
      'price': price,
      'imageUrl': imageUrl,
      'company': company,
      'description': description,
      'sector': sector,
      'position': position,
      'duties': duties,
      'insuranceRequired': insuranceRequired,
      'startDateTime': startDateTime?.toIso8601String(),
      'endDateTime': endDateTime?.toIso8601String(),
      'salaryType': salaryType,
      'minAge': minAge,
      'maxAge': maxAge,
      'experienceRequired': experienceRequired,
      'dressCode': dressCode,
      'employerType': employerType,
      'address': address,
    };
  }
}
