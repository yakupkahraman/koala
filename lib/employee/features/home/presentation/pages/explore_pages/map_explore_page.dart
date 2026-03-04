import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:koala/employee/features/home/data/location_service.dart';
import 'package:koala/employee/features/home/data/models/job_model.dart';
import 'package:koala/employee/features/home/data/repositories/job_repository.dart';
import 'package:koala/employee/features/home/presentation/providers/search_provider.dart';
import 'package:koala/employee/features/home/presentation/widgets/job_marker_generator.dart';
import 'package:koala/employee/features/home/presentation/widgets/job_detail_bottom_sheet.dart';
import 'package:koala/product/constants/app_padding.dart';
import 'package:provider/provider.dart';

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
    final searchProvider = context.watch<SearchProvider>();

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: appBar(searchProvider),
      body: Stack(
        children: [
          map(),
          if (_loading) loadingOverlay(),

          // Arama sonuçları overlay
          if (searchProvider.isSearching && _searchResults.isNotEmpty)
            _searchResultsOverlay(),

          // Arama aktifken ve sonuç yoksa
          if (searchProvider.isSearching &&
              _searchController.text.isNotEmpty &&
              _searchResults.isEmpty)
            _noResultsOverlay(),

          currentPositionButton(),
        ],
      ),
    );
  }

  Widget _searchResultsOverlay() {
    return Positioned(
      top: MediaQuery.of(context).padding.top + kToolbarHeight + 8,
      left: 16,
      right: 16,
      child: Material(
        elevation: 8,
        borderRadius: BorderRadius.circular(16),
        color: Colors.white,
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxHeight: MediaQuery.of(context).size.height * 0.4,
          ),
          child: ListView.separated(
            shrinkWrap: true,
            padding: const EdgeInsets.symmetric(vertical: 8),
            itemCount: _searchResults.length,
            separatorBuilder: (_, __) =>
                Divider(height: 1, indent: 16, endIndent: 16),
            itemBuilder: (context, index) {
              final job = _searchResults[index];
              return ListTile(
                leading: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: job.category.color.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(
                    job.category.icon,
                    color: job.category.color,
                    size: 20,
                  ),
                ),
                title: Text(
                  job.title,
                  style: const TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                subtitle: Text(
                  '${job.company ?? ''} • ${job.address ?? ''}',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 12,
                    color: Colors.grey[600],
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                trailing: Text(
                  '₺${job.price.toStringAsFixed(0)}',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
                onTap: () => _focusOnJob(job),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _noResultsOverlay() {
    return Positioned(
      top: MediaQuery.of(context).padding.top + kToolbarHeight + 8,
      left: 16,
      right: 16,
      child: Material(
        elevation: 8,
        borderRadius: BorderRadius.circular(16),
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                HugeIcons.strokeRoundedSearchList01,
                size: 40,
                color: Colors.grey[400],
              ),
              const SizedBox(height: 8),
              Text(
                'Sonuç bulunamadı',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey[600],
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'Farklı bir arama terimi deneyin',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 12,
                  color: Colors.grey[400],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Positioned currentPositionButton() {
    return Positioned(
      bottom: 110,
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
                CameraPosition(target: _currentLatLng!, zoom: 15.0),
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

        if (_currentLatLng != null) {
          _mapController!.animateCamera(
            CameraUpdate.newLatLngZoom(_currentLatLng!, 16),
          );
        }
      },
      onTap: (_) {
        // Haritaya tıklanınca aramayı kapat
        final searchProvider = Provider.of<SearchProvider>(
          context,
          listen: false,
        );
        if (searchProvider.isSearching) {
          searchProvider.stopSearching();
          _searchController.clear();
          _searchFocusNode.unfocus();
          setState(() {
            _searchResults = [];
          });
        }
      },
    );
  }

  AppBar appBar(SearchProvider searchProvider) {
    if (searchProvider.isSearching) {
      return AppBar(
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.dark,
          statusBarBrightness: Brightness.light,
        ),
        backgroundColor: Colors.white,
        elevation: 2,
        shadowColor: Colors.black.withValues(alpha: 0.1),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black87),
          onPressed: () {
            searchProvider.stopSearching();
            _searchController.clear();
            _searchFocusNode.unfocus();
            setState(() {
              _searchResults = [];
            });
          },
        ),
        title: TextField(
          controller: _searchController,
          focusNode: _searchFocusNode,
          autofocus: true,
          onChanged: (value) {
            searchProvider.setQuery(value);
            _onMapSearch(value);
          },
          style: const TextStyle(
            fontFamily: 'Poppins',
            fontSize: 16,
            color: Colors.black87,
          ),
          decoration: InputDecoration(
            hintText: 'İş, şirket veya konum ara...',
            hintStyle: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 16,
              color: Colors.grey[400],
            ),
            border: InputBorder.none,
          ),
        ),
        actions: [
          if (_searchController.text.isNotEmpty)
            IconButton(
              icon: const Icon(Icons.close, color: Colors.black54),
              onPressed: () {
                _searchController.clear();
                searchProvider.clearQuery();
                _onMapSearch('');
              },
            ),
        ],
      );
    }

    return AppBar(
      systemOverlayStyle: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.light,
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
            icon: HugeIcon(
              icon: HugeIcons.strokeRoundedSearch01,
              color: Colors.white,
            ),
            style: ButtonStyle(
              backgroundColor: WidgetStatePropertyAll(
                Theme.of(context).colorScheme.primary,
              ),
            ),
            onPressed: () {
              searchProvider.startSearching();
            },
          ),
        ),
        const SizedBox(width: 16),
      ],
    );
  }
}
