// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:koala/core/constants.dart';
import 'package:location/location.dart';

class MapExplorePage extends StatefulWidget {
  const MapExplorePage({super.key});

  @override
  State<MapExplorePage> createState() => _MapExplorePageState();
}

class _MapExplorePageState extends State<MapExplorePage> {
  bool _isMapLoading = true;
  GoogleMapController? _mapController;
  Location location = Location();
  LocationData? _currentPosition;
  String _loadingMessage = '';

  @override
  void initState() {
    super.initState();

    setState(() {
      _loadingMessage = 'Harita yükleniyor...';
      _isMapLoading = true;
    });

    _getCurrentLocation();
  }

  // Kullanıcının mevcut konumunu al (sadece bir kez)
  Future<void> _getCurrentLocation() async {
    bool serviceEnabled;
    PermissionStatus permissionGranted;

    // Konum servisi aktif mi kontrol et
    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        return;
      }
    }

    // Konum izni var mı kontrol et
    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    // Konum ayarlarını yapılandır
    await location.changeSettings(accuracy: LocationAccuracy.high);

    // Konumu al
    try {
      LocationData locationData = await location.getLocation();
      setState(() {
        _currentPosition = locationData;
        _isMapLoading = false;
      });

      // Haritayı kullanıcının konumuna odakla
      if (_mapController != null && _currentPosition != null) {
        _mapController!.animateCamera(
          CameraUpdate.newLatLng(
            LatLng(_currentPosition!.latitude!, _currentPosition!.longitude!),
          ),
        );
      }
    } catch (e) {
      setState(() {
        _isMapLoading = false;
      });
      Exception('Konum alınamadı: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          GoogleMap(
            initialCameraPosition: CameraPosition(
              target: _currentPosition != null
                  ? LatLng(
                      _currentPosition!.latitude!,
                      _currentPosition!.longitude!,
                    )
                  : const LatLng(37.7749, -122.4194), // Default San Francisco
              zoom: 15.0,
            ),
            mapType: MapType.normal,
            myLocationEnabled: true,
            myLocationButtonEnabled: false,
            zoomControlsEnabled: false,
            onMapCreated: (GoogleMapController controller) {
              _mapController = controller;

              setState(() {
                _loadingMessage = 'Konum alınıyor...';
              });

              // Eğer konum zaten alınmışsa haritayı odakla
              if (_currentPosition != null) {
                controller.animateCamera(
                  CameraUpdate.newLatLng(
                    LatLng(
                      _currentPosition!.latitude!,
                      _currentPosition!.longitude!,
                    ),
                  ),
                );

                setState(() {
                  _isMapLoading = false;
                });
              }
            },
          ),

          // Loading overlay
          if (_isMapLoading)
            Container(
              color: Colors.black.withOpacity(0.6),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(
                        ThemeConstants.primaryColor,
                      ),
                      strokeWidth: 3.0,
                    ),
                    SizedBox(height: 16),
                    Text(
                      _loadingMessage,
                      style: TextStyle(
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
                if (_currentPosition != null && _mapController != null) {
                  _mapController!.animateCamera(
                    CameraUpdate.newLatLng(
                      LatLng(
                        _currentPosition!.latitude!,
                        _currentPosition!.longitude!,
                      ),
                    ),
                  );
                }
              },
              child: const Icon(Icons.my_location, size: 24),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _mapController?.dispose();
    super.dispose();
  }
}
