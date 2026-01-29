part of 'map_explore_page.dart';

abstract class MapExplorePageModel extends State<MapExplorePage>
    with AutomaticKeepAliveClientMixin<MapExplorePage> {
  GoogleMapController? _mapController;
  late LocationService _locationService;
  late JobRepository _jobRepository;

  bool _loading = true;
  LatLng? _currentLatLng;
  final LatLng _defaultLatLng = const LatLng(39.925533, 32.866287);

  String _loadingMessage = 'Harita Yükleniyor...';

  // İş verileri
  Set<Marker> _markers = {};

  @override
  void initState() {
    super.initState();

    _jobRepository = JobRepository();

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
    _loadJobs();
  }

  /// İşleri yükle ve marker'ları oluştur
  Future<void> _loadJobs() async {
    try {
      final jobs = await _jobRepository.getJobs();

      final markers = await JobMarkerGenerator.generateMarkers(
        jobs: jobs,
        onMarkerTap: _onJobMarkerTap,
      );

      setState(() {
        _markers = markers;
      });
    } catch (e) {
      debugPrint('İşler yüklenirken hata: $e');
    }
  }

  /// Marker'a tıklandığında bottom sheet göster
  void _onJobMarkerTap(JobModel job) {
    HapticFeedback.lightImpact();
    JobDetailBottomSheet.show(context, job);
  }

  @override
  void dispose() {
    _locationService.dispose();
    super.dispose();
  }

  @override
  bool get wantKeepAlive => true;
}
