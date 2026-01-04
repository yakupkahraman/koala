class ImageModel {
  final String id;
  final String url;
  final String? name;
  final String? contentType;

  const ImageModel({
    required this.id,
    required this.url,
    this.name,
    this.contentType,
  });

  /// JSON'dan model oluşturma
  factory ImageModel.fromJson(Map<String, dynamic> json) {
    return ImageModel(
      id: json['id'] as String,
      url: json['url'] as String,
      name: json['name'] as String?,
      contentType: json['contentType'] as String?,
    );
  }

  /// Model'den JSON oluşturma
  Map<String, dynamic> toJson() {
    return {'id': id, 'url': url, 'name': name, 'contentType': contentType};
  }
}
