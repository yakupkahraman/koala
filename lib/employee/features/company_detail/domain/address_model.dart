class AddressModel {
  final String id;
  final String? street;
  final String? city;
  final String? district;
  final String? postalCode;
  final String? country;
  final double? latitude;
  final double? longitude;

  const AddressModel({
    required this.id,
    this.street,
    this.city,
    this.district,
    this.postalCode,
    this.country,
    this.latitude,
    this.longitude,
  });

  /// JSON'dan model oluşturma
  factory AddressModel.fromJson(Map<String, dynamic> json) {
    return AddressModel(
      id: json['id'] as String,
      street: json['street'] as String?,
      city: json['city'] as String?,
      district: json['district'] as String?,
      postalCode: json['postalCode'] as String?,
      country: json['country'] as String?,
      latitude: json['latitude'] != null
          ? (json['latitude'] as num).toDouble()
          : null,
      longitude: json['longitude'] != null
          ? (json['longitude'] as num).toDouble()
          : null,
    );
  }

  /// Model'den JSON oluşturma
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'street': street,
      'city': city,
      'district': district,
      'postalCode': postalCode,
      'country': country,
      'latitude': latitude,
      'longitude': longitude,
    };
  }

  /// Tam adres stringi oluştur
  String get fullAddress {
    final parts = [
      if (street != null && street!.isNotEmpty) street,
      if (district != null && district!.isNotEmpty) district,
      if (city != null && city!.isNotEmpty) city,
      if (postalCode != null && postalCode!.isNotEmpty) postalCode,
      if (country != null && country!.isNotEmpty) country,
    ];
    return parts.join(', ');
  }
}
