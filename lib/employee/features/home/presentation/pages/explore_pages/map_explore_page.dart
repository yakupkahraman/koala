import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:koala/employee/features/home/data/location_service.dart';
import 'package:koala/employee/features/home/data/models/job_model.dart';
import 'package:koala/employee/features/home/data/repositories/job_repository.dart';
import 'package:koala/employee/features/home/presentation/widgets/job_marker_generator.dart';
import 'package:koala/employee/features/home/presentation/widgets/job_detail_bottom_sheet.dart';
import 'package:koala/product/constants/app_padding.dart';

part 'map_explore_pagemodel.dart';

class MapExplorePage extends StatefulWidget {
  const MapExplorePage({super.key});

  @override
  State<MapExplorePage> createState() => _MapExplorePageState();
}

class _MapExplorePageState extends MapExplorePageModel {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: appBar(),
      body: Stack(
        children: [
          map(),
          if (_loading) loadingOverlay(),
          currentPositionButton(),
        ],
      ),
    );
  }

  Positioned currentPositionButton() {
    return Positioned(
      bottom: 110, // Bottom navigation'ın üzerinde
      right: AppPadding.primary,
      child: FloatingActionButton(
        mini: true,
        backgroundColor: Theme.of(context).colorScheme.primary,
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
            HapticFeedback.lightImpact();
          }
        },
        child: const Icon(Icons.my_location, size: 24),
      ),
    );
  }

  Container loadingOverlay() {
    return Container(
      color: Colors.black.withValues(alpha: 0.2),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(
                Theme.of(context).colorScheme.primary,
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
    );
  }

  GoogleMap map() {
    return GoogleMap(
      initialCameraPosition: CameraPosition(
        target: _currentLatLng ?? _defaultLatLng,
        zoom: 15.0,
      ),
      mapType: MapType.normal,
      myLocationEnabled: true,
      myLocationButtonEnabled: false,
      zoomControlsEnabled: false,
      markers: _markers,
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
    );
  }

  AppBar appBar() {
    return AppBar(
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark, // Android için
        statusBarBrightness: Brightness.light, // iOS için
      ),
      backgroundColor: Colors.transparent,
      elevation: 0,
      title: Text(
        'KOALA',
        style: TextStyle(
          fontFamily: 'Poppins',
          fontSize: 30,
          fontWeight: FontWeight.w800,
          color: Theme.of(context).colorScheme.primary,
        ),
      ),
      centerTitle: false,
      actions: [
        Hero(
          tag: 'search_button',
          child: IconButton(
            icon: const Icon(HugeIcons.strokeRoundedSearch01, size: 24),
            style: ButtonStyle(
              backgroundColor: WidgetStatePropertyAll(
                Theme.of(context).colorScheme.primary,
              ),
              padding: WidgetStatePropertyAll(EdgeInsets.all(8)),
            ),
            color: Colors.white,
            onPressed: () {},
          ),
        ),
        SizedBox(width: 16),
      ],
    );
  }
}
