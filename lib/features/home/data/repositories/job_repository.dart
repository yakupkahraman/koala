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
      type: JobType.oneTime,
      category: JobCategory.photography,
      title: 'Düğün Fotoğrafçısı',
      subtitle:
          'Çankaya\'da düğün fotoğrafçısı aranıyor. Deneyimli tercih sebebi.',
      price: 2500,
      company: 'Özlem & Murat Düğün Organizasyonu',
      description:
          'Çankaya bölgesinde düzenlenen düğün organizasyonu için profesyonel fotoğrafçı aranmaktadır. Minimum 2 yıl deneyim ve kendi ekipmanı olması gerekmektedir. Düğün baştan sona kadar yaklaşık 8 saat sürecektir.',
      sector: 'Fotoğrafçılık',
      position: 'Düğün Fotoğrafçısı',
      duties:
          'Düğün fotoğrafları çekmek, video kayıt yapmak, fotoğrafları düzenlemek',
      insuranceRequired: false,
      startDateTime: DateTime(2025, 12, 20, 14, 0),
      endDateTime: DateTime(2025, 12, 20, 23, 0),
      salaryType: 'FIXED',
      minAge: 20,
      maxAge: 45,
      experienceRequired: true,
      dressCode: 'Takım elbise',
      employerType: 'INDIVIDUAL',
      address: 'Çankaya, Ankara',
    ),
    JobModel(
      id: '2',
      latitude: 39.9208,
      longitude: 32.8541,
      type: JobType.recurring,
      category: JobCategory.waiter,
      title: 'Part-time Garson',
      subtitle: 'Kızılay\'da cafe\'de hafta sonu çalışacak garson aranıyor.',
      price: 800,
      company: 'Kahve Durağı Cafe',
      description:
          'Kızılay merkezde bulunan cafe\'mizde hafta sonları çalışacak enerjik ve güler yüzlü garson arkadaşlar arıyoruz. Esnek çalışma saatleri.',
      sector: 'Restoran & Cafe',
      position: 'Garson',
      duties: 'Müşteri karşılama, sipariş alma, servis yapma, kasa işlemleri',
      insuranceRequired: false,
      startDateTime: DateTime(2025, 12, 21, 9, 0),
      endDateTime: DateTime(2025, 12, 21, 18, 0),
      salaryType: 'HOURLY',
      minAge: 18,
      maxAge: 35,
      experienceRequired: false,
      dressCode: 'Siyah pantolon, beyaz gömlek',
      employerType: 'COMPANY',
      address: 'Kızılay, Ankara',
    ),
    JobModel(
      id: '3',
      latitude: 39.9427,
      longitude: 32.8564,
      type: JobType.recurring,
      category: JobCategory.petCare,
      title: 'Kedi Bakıcısı',
      subtitle: '2 haftalık tatil süresince 2 kediye bakacak güvenilir birisi.',
      price: 1200,
      company: 'Ahmet Yılmaz (Bireysel)',
      description:
          'Tatile giderken evimizde 2 tane sevimli kedimize bakacak hayvan sever, güvenilir bir kişi arıyoruz. Günde 2 kez ziyaret yeterli.',
      sector: 'Hayvan Bakımı',
      position: 'Kedi Bakıcısı',
      duties:
          'Günde 2 kez ziyaret, mama ve su verme, tuvalet temizliği, oyun oynama',
      insuranceRequired: false,
      startDateTime: DateTime(2025, 12, 25, 10, 0),
      endDateTime: DateTime(2026, 1, 8, 10, 0),
      salaryType: 'FIXED',
      minAge: 20,
      maxAge: 55,
      experienceRequired: false,
      dressCode: 'Rahat kıyafet',
      employerType: 'INDIVIDUAL',
      address: 'Çukurambar, Ankara',
    ),
    JobModel(
      id: '4',
      latitude: 39.9180,
      longitude: 32.8619,
      type: JobType.oneTime,
      category: JobCategory.design,
      title: 'Logo Tasarımcısı',
      subtitle: 'Yeni açılacak restoran için modern logo tasarımı.',
      price: 1500,
      company: 'Lezzet Durağı Restaurant',
      description:
          'Yeni açacağımız modern restoran konseptimiz için özgün ve çarpıcı bir logo tasarımına ihtiyacımız var. 3 farklı revizyon hakkı dahil.',
      sector: 'Grafik Tasarım',
      position: 'Logo Tasarımcısı',
      duties:
          'Konsept geliştirme, logo tasarımı, 3 revizyon, final dosyaların teslimi (AI, PNG, SVG)',
      insuranceRequired: false,
      startDateTime: DateTime(2025, 12, 16, 10, 0),
      endDateTime: DateTime(2025, 12, 23, 18, 0),
      salaryType: 'PROJECT',
      minAge: 18,
      maxAge: 50,
      experienceRequired: true,
      dressCode: 'Serbest',
      employerType: 'COMPANY',
      address: 'Kavaklıdere, Ankara',
    ),
    JobModel(
      id: '5',
      latitude: 39.9281,
      longitude: 32.8673,
      type: JobType.recurring,
      category: JobCategory.barista,
      title: 'Deneyimli Barista',
      subtitle: 'Specialty coffee deneyimi olan barista aranıyor. Tam zamanlı.',
      price: 15000,
      company: 'Brew & Co. Specialty Coffee',
      description:
          'Specialty coffee alanında deneyimli, latte art yapabilen ve müşteri iletişimi güçlü barista arkadaşlar aramaktayız. Tam zamanlı pozisyon.',
      sector: 'Cafe & Coffee Shop',
      position: 'Barista',
      duties:
          'Espresso bazlı içecek hazırlama, latte art, müşteri hizmeti, ekipman bakımı',
      insuranceRequired: true,
      startDateTime: DateTime(2026, 1, 5, 8, 0),
      endDateTime: DateTime(2026, 1, 5, 17, 0),
      salaryType: 'MONTHLY',
      minAge: 20,
      maxAge: 40,
      experienceRequired: true,
      dressCode: 'Barista önlüğü sağlanacak',
      employerType: 'COMPANY',
      address: 'Tunalı Hilmi, Ankara',
    ),
    JobModel(
      id: '6',
      latitude: 39.9356,
      longitude: 32.8489,
      type: JobType.oneTime,
      category: JobCategory.photography,
      title: 'Ürün Fotoğrafçısı',
      subtitle: 'E-ticaret sitesi için ürün fotoğrafları çekilecek.',
      price: 1000,
      company: 'TrendShop E-ticaret',
      description:
          'E-ticaret sitemiz için yaklaşık 50 adet ürünün profesyonel fotoğraflarının çekilmesi gerekiyor. Beyaz fon ve detay çekimleri.',
      sector: 'Fotoğrafçılık',
      position: 'Ürün Fotoğrafçısı',
      duties: 'Ürün fotoğrafı çekimi, basit düzenleme, beyaz fon çekimleri',
      insuranceRequired: false,
      startDateTime: DateTime(2025, 12, 18, 10, 0),
      endDateTime: DateTime(2025, 12, 18, 16, 0),
      salaryType: 'FIXED',
      minAge: 18,
      maxAge: 50,
      experienceRequired: true,
      dressCode: 'Rahat kıyafet',
      employerType: 'COMPANY',
      address: 'Ümitköy, Ankara',
    ),
    JobModel(
      id: '7',
      latitude: 39.9123,
      longitude: 32.8712,
      type: JobType.oneTime,
      category: JobCategory.waiter,
      title: 'Etkinlik Garsonu',
      subtitle: 'Özel etkinlik için 1 günlük garson ihtiyacı.',
      price: 500,
      company: 'Elit Organizasyon',
      description:
          'Kurumsal bir etkinlikte kokteyl servisi yapacak deneyimli garson arkadaşlar aranıyor. Akşam 6 saat sürecek.',
      sector: 'Etkinlik & Organizasyon',
      position: 'Garson',
      duties: 'Kokteyl servisi, masa düzenleme, misafir ağırlama',
      insuranceRequired: false,
      startDateTime: DateTime(2025, 12, 19, 18, 0),
      endDateTime: DateTime(2025, 12, 20, 0, 0),
      salaryType: 'FIXED',
      minAge: 20,
      maxAge: 40,
      experienceRequired: true,
      dressCode: 'Siyah takım elbise (sağlanacak)',
      employerType: 'COMPANY',
      address: 'Sheraton Otel, Ankara',
    ),
    JobModel(
      id: '8',
      latitude: 39.9398,
      longitude: 32.8398,
      type: JobType.recurring,
      category: JobCategory.petCare,
      title: 'Köpek Gezdirici',
      subtitle: 'Sabah ve akşam köpek gezdirme - Golden Retriever.',
      price: 600,
      company: 'Zeynep Kaya (Bireysel)',
      description:
          'Golden Retriever cinsi köpeğimizi hafta içi her gün sabah ve akşam gezdireceğimiz güvenilir, köpek sever birini arıyoruz.',
      sector: 'Hayvan Bakımı',
      position: 'Köpek Gezdirici',
      duties: 'Sabah 07:00 ve akşam 19:00\'da 45\'er dakika köpek gezdirme',
      insuranceRequired: false,
      startDateTime: DateTime(2025, 12, 16, 7, 0),
      endDateTime: DateTime(2025, 12, 16, 20, 0),
      salaryType: 'DAILY',
      minAge: 18,
      maxAge: 60,
      experienceRequired: false,
      dressCode: 'Spor kıyafet',
      employerType: 'INDIVIDUAL',
      address: 'Bahçelievler, Ankara',
    ),
    JobModel(
      id: '9',
      latitude: 39.9245,
      longitude: 32.8456,
      type: JobType.recurring,
      category: JobCategory.design,
      title: 'Sosyal Medya Tasarımcısı',
      subtitle: 'Haftalık Instagram post tasarımları yapılacak.',
      price: 2000,
      company: 'FitLife Spor Salonu',
      description:
          'Spor salonumuzun Instagram hesabı için haftalık 7 post + 3 story tasarımı yapacak yaratıcı tasarımcı aranıyor.',
      sector: 'Dijital Pazarlama',
      position: 'Sosyal Medya Tasarımcısı',
      duties:
          'Instagram post tasarımı, story tasarımı, marka kimliğine uygun içerik üretimi',
      insuranceRequired: false,
      startDateTime: DateTime(2025, 12, 16, 9, 0),
      endDateTime: DateTime(2025, 12, 22, 18, 0),
      salaryType: 'WEEKLY',
      minAge: 18,
      maxAge: 45,
      experienceRequired: true,
      dressCode: 'Serbest',
      employerType: 'COMPANY',
      address: 'Çayyolu, Ankara',
    ),
    JobModel(
      id: '10',
      latitude: 39.9312,
      longitude: 32.8534,
      type: JobType.recurring,
      category: JobCategory.barista,
      title: 'Hafta Sonu Barista',
      subtitle: 'Cumartesi-Pazar çalışacak barista aranıyor.',
      price: 1600,
      company: 'Coffee Break Cafe',
      description:
          'Cafe\'mizde hafta sonları çalışacak kahve yapma konusunda deneyimli veya öğrenmeye istekli barista aranıyor.',
      sector: 'Cafe & Coffee Shop',
      position: 'Barista',
      duties:
          'Kahve hazırlama, müşteri hizmeti, kasa işlemleri, cafe temizliği',
      insuranceRequired: false,
      startDateTime: DateTime(2025, 12, 21, 9, 0),
      endDateTime: DateTime(2025, 12, 21, 19, 0),
      salaryType: 'DAILY',
      minAge: 18,
      maxAge: 35,
      experienceRequired: false,
      dressCode: 'Siyah önlük sağlanacak',
      employerType: 'COMPANY',
      address: 'Kızılay, Ankara',
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

  /// Belirli bir kategorideki işleri getir
  Future<List<JobModel>> getJobsByCategory(JobCategory category) async {
    await Future.delayed(const Duration(milliseconds: 300));
    return _fakeJobs.where((job) => job.category == category).toList();
  }

  /// Belirli bir türdeki işleri getir (Günlük veya Tekrarlı)
  Future<List<JobModel>> getJobsByType(JobType type) async {
    await Future.delayed(const Duration(milliseconds: 300));
    return _fakeJobs.where((job) => job.type == type).toList();
  }
}
