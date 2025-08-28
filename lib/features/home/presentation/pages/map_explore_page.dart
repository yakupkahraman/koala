// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:koala/core/constants.dart';
import 'package:koala/features/home/data/location_service.dart';

class MapExplorePage extends StatefulWidget {
  const MapExplorePage({super.key});

  @override
  State<MapExplorePage> createState() => _MapExplorePageState();
}

class _MapExplorePageState extends State<MapExplorePage> {
  GoogleMapController? _mapController;
  late LocationService _locationService;
  bool _loading = true;
  LatLng? _currentLatLng;
  final LatLng _defaultLatLng = const LatLng(39.925533, 32.866287);

  String _loadingMessage = 'Harita Yükleniyor...';

  @override
  void initState() {
    super.initState();

    _locationService = LocationService(
      context,
      onLocationReceived: (pos) {
        setState(() {
          _currentLatLng = LatLng(pos.latitude, pos.longitude);
          _loading = false;
        });

        // Haritayı konuma taşı
        if (_mapController != null) {
          _mapController!.animateCamera(
            CameraUpdate.newLatLngZoom(_currentLatLng!, 16),
          );
        }
      },
    );

    _locationService.init();
  }

  @override
  void dispose() {
    _locationService.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          GoogleMap(
            initialCameraPosition: CameraPosition(
              target: _currentLatLng ?? _defaultLatLng,
              zoom: 15.0,
            ),
            mapType: MapType.normal,
            myLocationEnabled: true,
            myLocationButtonEnabled: false,
            zoomControlsEnabled: false,
            onMapCreated: (GoogleMapController controller) {
              _mapController = controller;

              setState(() {
                _loadingMessage = 'Konum Alınıyor...';
              });

              // Eğer konum zaten alınmışsa haritayı odakla
              if (_currentLatLng != null) {
                _mapController!.animateCamera(
                  CameraUpdate.newLatLngZoom(_currentLatLng!, 16),
                );
              }
            },
          ),

          // Loading overlay
          if (_loading)
            Container(
              color: Colors.black.withOpacity(0.6),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(
                        ThemeConstants.primaryColor,
                      ),
                      strokeWidth: 3.0,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      _loadingMessage,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ),

          // Konumum butonu
          Positioned(
            bottom: 110, // Bottom navigation'ın üzerinde
            right: UiConstants.defaultPadding,
            child: FloatingActionButton(
              mini: true,
              backgroundColor: ThemeConstants.primaryColor,
              foregroundColor: Colors.white,
              elevation: 4,
              onPressed: () {
                if (_currentLatLng != null && _mapController != null) {
                  _mapController!.animateCamera(
                    CameraUpdate.newCameraPosition(
                      CameraPosition(
                        target: _currentLatLng!,
                        zoom: 15.0, // Consistent zoom level
                      ),
                    ),
                  );
                  // Optional: Add haptic feedback
                  // HapticFeedback.lightImpact();
                }
              },
              child: const Icon(Icons.my_location, size: 24),
            ),
          ),
        ],
      ),
    );
  }
}
