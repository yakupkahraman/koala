// ignore_for_file: deprecated_member_use

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:koala/constants.dart';
import 'package:location/location.dart';
import 'dart:async';

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
  StreamSubscription<LocationData>? _locationSubscription;
  bool _isFollowingUser = true; // Kullanıcıyı takip ediyor mu?

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  // Kullanıcının konumunu al ve anlık takip et
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
    await location.changeSettings(
      accuracy: LocationAccuracy.high,
      interval: 5000, // 5 saniyede bir güncelle
      distanceFilter: 5, // 5 metre hareket ettiğinde güncelle
    );

    // İlk konumu al
    try {
      LocationData locationData = await location.getLocation();
      setState(() {
        _currentPosition = locationData;
      });

      // Haritayı kullanıcının konumuna odakla
      if (_mapController != null && _currentPosition != null) {
        _mapController!.animateCamera(
          CameraUpdate.newLatLng(
            LatLng(_currentPosition!.latitude!, _currentPosition!.longitude!),
          ),
        );
      }

      // Anlık konum takibini başlat
      _startLocationTracking();
    } catch (e) {
      if (kDebugMode) {
        print('Konum alınamadı: $e');
      }
    }
  }

  // Anlık konum takibini başlat
  void _startLocationTracking() {
    _locationSubscription = location.onLocationChanged.listen((
      LocationData locationData,
    ) {
      if (mounted) {
        setState(() {
          _currentPosition = locationData;
        });

        // Sadece kullanıcıyı takip ediyorsak haritayı hareket ettir
        if (_mapController != null && _isFollowingUser) {
          _mapController!.animateCamera(
            CameraUpdate.newLatLng(
              LatLng(locationData.latitude!, locationData.longitude!),
            ),
          );
        }
      }
    });
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
            onCameraMove: (CameraPosition position) {
              setState(() {
                _isFollowingUser = false;
              });
              // Kullanıcı haritayı manuel olarak hareket ettirdi
            },
            onMapCreated: (GoogleMapController controller) {
              _mapController = controller;

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
              }

              // Map yüklendiğinde loading'i kapat
              Future.delayed(const Duration(milliseconds: 500), () {
                if (mounted) {
                  setState(() {
                    _isMapLoading = false;
                  });
                }
              });
            },
          ),

          // Loading overlay
          if (_isMapLoading)
            Container(
              color: Colors.black.withOpacity(0.8),
              child: const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(
                        kMainGreenColor,
                      ),
                      strokeWidth: 3.0,
                    ),
                    SizedBox(height: 16),
                    Text(
                      'Harita Yükleniyor...',
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
        ],
      ),
    );
  }

  @override
  void dispose() {
    _locationSubscription?.cancel();
    _mapController?.dispose();
    super.dispose();
  }
}
