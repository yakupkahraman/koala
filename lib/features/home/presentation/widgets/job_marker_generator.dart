import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:koala/features/home/data/models/job_model.dart';
import 'package:flutter_svg/flutter_svg.dart';

/// Custom marker oluşturucu
/// İş kategorisine göre farklı SVG pinli marker'lar oluşturur
class JobMarkerGenerator {
  // Cache for bitmap descriptors to avoid regenerating
  static final Map<JobCategory, BitmapDescriptor> _iconCache = {};

  /// Job listesinden marker set'i oluştur
  static Future<Set<Marker>> generateMarkers({
    required List<JobModel> jobs,
    required void Function(JobModel job) onMarkerTap,
  }) async {
    final Set<Marker> markers = {};

    for (final job in jobs) {
      final marker = await _createMarker(job, onMarkerTap);
      markers.add(marker);
    }

    return markers;
  }

  /// Tek bir job için marker oluştur
  static Future<Marker> _createMarker(
    JobModel job,
    void Function(JobModel job) onMarkerTap,
  ) async {
    final BitmapDescriptor icon = await _getOrCreateIcon(job.category);

    return Marker(
      markerId: MarkerId(job.id),
      position: LatLng(job.latitude, job.longitude),
      icon: icon,
      onTap: () => onMarkerTap(job),
      anchor: const Offset(0.5, 1.0), // Pin'in alt noktası konumu göstersin
    );
  }

  /// Cache'den ikon al veya yeni oluştur
  static Future<BitmapDescriptor> _getOrCreateIcon(JobCategory category) async {
    if (_iconCache.containsKey(category)) {
      return _iconCache[category]!;
    }

    final icon = await _createIconFromSvg(category);
    _iconCache[category] = icon;
    return icon;
  }

  /// SVG dosyasından BitmapDescriptor oluştur
  static Future<BitmapDescriptor> _createIconFromSvg(
    JobCategory category,
  ) async {
    const double size = 70; // Marker boyutu

    // SVG dosyasını yükle
    final String svgString = await rootBundle.loadString(category.pinAsset);

    // SVG'yi Picture'a dönüştür
    final PictureInfo pictureInfo = await vg.loadPicture(
      SvgStringLoader(svgString),
      null,
    );

    // SVG'nin orijinal boyutlarını al
    final double svgWidth = pictureInfo.size.width;
    final double svgHeight = pictureInfo.size.height;

    // En-boy oranını koru
    final double scale = size / svgHeight;
    final double scaledWidth = svgWidth * scale;

    // PictureRecorder ile resmi çiz
    final ui.PictureRecorder pictureRecorder = ui.PictureRecorder();
    final Canvas canvas = Canvas(pictureRecorder);

    // SVG'yi ölçeklendir ve çiz
    canvas.scale(scale);
    canvas.drawPicture(pictureInfo.picture);

    // Picture'ı Image'a dönüştür
    final ui.Image image = await pictureRecorder.endRecording().toImage(
      scaledWidth.toInt(),
      size.toInt(),
    );

    // Image'ı byte array'e dönüştür
    final ByteData? byteData = await image.toByteData(
      format: ui.ImageByteFormat.png,
    );

    pictureInfo.picture.dispose();

    return BitmapDescriptor.bytes(byteData!.buffer.asUint8List());
  }

  /// Cache'i temizle (gerekirse)
  static void clearCache() {
    _iconCache.clear();
  }
}
