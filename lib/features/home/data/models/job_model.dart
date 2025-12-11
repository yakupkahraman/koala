import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';

/// İş türlerini temsil eden enum
enum JobType { photography, waiter, petCare, design, barista }

/// JobType için extension - ikon ve renk bilgileri
extension JobTypeExtension on JobType {
  /// Her iş türü için ikon
  IconData get icon {
    switch (this) {
      case JobType.photography:
        return HugeIcons.strokeRoundedCamera01;
      case JobType.waiter:
        return HugeIcons.strokeRoundedRestaurant01;
      case JobType.petCare:
        return HugeIcons.strokeRoundedPenTool01;
      case JobType.design:
        return HugeIcons.strokeRoundedPaintBoard;
      case JobType.barista:
        return HugeIcons.strokeRoundedCoffee01;
    }
  }

  /// Her iş türü için renk
  Color get color {
    switch (this) {
      case JobType.photography:
        return const Color(0xFF9C27B0); // Mor
      case JobType.waiter:
        return const Color(0xFFFF5722); // Turuncu
      case JobType.petCare:
        return const Color(0xFF4CAF50); // Yeşil
      case JobType.design:
        return const Color(0xFF2196F3); // Mavi
      case JobType.barista:
        return const Color(0xFF795548); // Kahverengi
    }
  }

  /// Her iş türü için Türkçe isim
  String get displayName {
    switch (this) {
      case JobType.photography:
        return 'Fotoğrafçılık';
      case JobType.waiter:
        return 'Garsonluk';
      case JobType.petCare:
        return 'Hayvan Bakımı';
      case JobType.design:
        return 'Tasarım';
      case JobType.barista:
        return 'Barista';
    }
  }

  /// Her iş türü için SVG pin asset yolu
  String get pinAsset {
    switch (this) {
      case JobType.photography:
        return 'assets/map_pins/photography.svg';
      case JobType.waiter:
        return 'assets/map_pins/waiter.svg';
      case JobType.petCare:
        return 'assets/map_pins/pet_care.svg';
      case JobType.design:
        return 'assets/map_pins/design.svg';
      case JobType.barista:
        return 'assets/map_pins/barista.svg';
    }
  }
}

/// İş ilanı model sınıfı
class JobModel {
  final String id;
  final double latitude;
  final double longitude;
  final JobType type;
  final String title;
  final String subtitle;
  final double price;
  final String? imageUrl;

  const JobModel({
    required this.id,
    required this.latitude,
    required this.longitude,
    required this.type,
    required this.title,
    required this.subtitle,
    required this.price,
    this.imageUrl,
  });

  /// JSON'dan model oluşturma
  factory JobModel.fromJson(Map<String, dynamic> json) {
    return JobModel(
      id: json['id'] as String,
      latitude: (json['latitude'] as num).toDouble(),
      longitude: (json['longitude'] as num).toDouble(),
      type: JobType.values.firstWhere(
        (e) => e.name == json['type'],
        orElse: () => JobType.waiter,
      ),
      title: json['title'] as String,
      subtitle: json['subtitle'] as String,
      price: (json['price'] as num).toDouble(),
      imageUrl: json['imageUrl'] as String?,
    );
  }

  /// Model'den JSON oluşturma
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'latitude': latitude,
      'longitude': longitude,
      'type': type.name,
      'title': title,
      'subtitle': subtitle,
      'price': price,
      'imageUrl': imageUrl,
    };
  }
}
