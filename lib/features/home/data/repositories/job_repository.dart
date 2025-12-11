import 'package:koala/features/home/data/models/job_model.dart';

/// Fake iş verilerini sağlayan repository
/// Backend hazır olduğunda burası gerçek API'ye bağlanacak
class JobRepository {
  /// Singleton instance
  static final JobRepository _instance = JobRepository._internal();
  factory JobRepository() => _instance;
  JobRepository._internal();

  /// Fake iş verileri - Ankara civarı koordinatlar
  final List<JobModel> _fakeJobs = [
    JobModel(
      id: '1',
      latitude: 39.9334,
      longitude: 32.8597,
      type: JobType.photography,
      title: 'Düğün Fotoğrafçısı',
      subtitle:
          'Çankaya\'da düğün fotoğrafçısı aranıyor. Deneyimli tercih sebebi.',
      price: 2500,
    ),
    JobModel(
      id: '2',
      latitude: 39.9208,
      longitude: 32.8541,
      type: JobType.waiter,
      title: 'Part-time Garson',
      subtitle: 'Kızılay\'da cafe\'de hafta sonu çalışacak garson aranıyor.',
      price: 800,
    ),
    JobModel(
      id: '3',
      latitude: 39.9427,
      longitude: 32.8564,
      type: JobType.petCare,
      title: 'Kedi Bakıcısı',
      subtitle: '2 haftalık tatil süresince 2 kediye bakacak güvenilir birisi.',
      price: 1200,
    ),
    JobModel(
      id: '4',
      latitude: 39.9180,
      longitude: 32.8619,
      type: JobType.design,
      title: 'Logo Tasarımcısı',
      subtitle: 'Yeni açılacak restoran için modern logo tasarımı.',
      price: 1500,
    ),
    JobModel(
      id: '5',
      latitude: 39.9281,
      longitude: 32.8673,
      type: JobType.barista,
      title: 'Deneyimli Barista',
      subtitle: 'Specialty coffee deneyimi olan barista aranıyor. Tam zamanlı.',
      price: 15000,
    ),
    JobModel(
      id: '6',
      latitude: 39.9356,
      longitude: 32.8489,
      type: JobType.photography,
      title: 'Ürün Fotoğrafçısı',
      subtitle: 'E-ticaret sitesi için ürün fotoğrafları çekilecek.',
      price: 1000,
    ),
    JobModel(
      id: '7',
      latitude: 39.9123,
      longitude: 32.8712,
      type: JobType.waiter,
      title: 'Etkinlik Garsonu',
      subtitle: 'Özel etkinlik için 1 günlük garson ihtiyacı.',
      price: 500,
    ),
    JobModel(
      id: '8',
      latitude: 39.9398,
      longitude: 32.8398,
      type: JobType.petCare,
      title: 'Köpek Gezdirici',
      subtitle: 'Sabah ve akşam köpek gezdirme - Golden Retriever.',
      price: 600,
    ),
    JobModel(
      id: '9',
      latitude: 39.9245,
      longitude: 32.8456,
      type: JobType.design,
      title: 'Sosyal Medya Tasarımcısı',
      subtitle: 'Haftalık Instagram post tasarımları yapılacak.',
      price: 2000,
    ),
    JobModel(
      id: '10',
      latitude: 39.9312,
      longitude: 32.8534,
      type: JobType.barista,
      title: 'Hafta Sonu Barista',
      subtitle: 'Cumartesi-Pazar çalışacak barista aranıyor.',
      price: 1600,
    ),
  ];

  /// Tüm işleri getir (simüle edilmiş network gecikmesi ile)
  Future<List<JobModel>> getJobs() async {
    // Backend'den veri çekme simülasyonu
    await Future.delayed(const Duration(milliseconds: 500));
    return _fakeJobs;
  }

  /// Belirli bir işi ID ile getir
  Future<JobModel?> getJobById(String id) async {
    await Future.delayed(const Duration(milliseconds: 200));
    try {
      return _fakeJobs.firstWhere((job) => job.id == id);
    } catch (e) {
      return null;
    }
  }

  /// Belirli bir türdeki işleri getir
  Future<List<JobModel>> getJobsByType(JobType type) async {
    await Future.delayed(const Duration(milliseconds: 300));
    return _fakeJobs.where((job) => job.type == type).toList();
  }
}
