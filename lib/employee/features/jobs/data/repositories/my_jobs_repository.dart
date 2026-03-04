import 'package:koala/employee/features/jobs/data/models/my_jobs_model.dart';

class MyJobsRepository {
  static final MyJobsRepository _instance = MyJobsRepository._internal();
  factory MyJobsRepository() => _instance;
  MyJobsRepository._internal();

  Future<List<MyJobsModel>> getMyJobs() async {
    await Future.delayed(const Duration(milliseconds: 400));
    return _fakeJobs;
  }

  Future<List<MyJobsModel>> getJobsByStatus(MyJobStatus status) async {
    await Future.delayed(const Duration(milliseconds: 200));
    return _fakeJobs.where((job) => job.status == status).toList();
  }

  final List<MyJobsModel> _fakeJobs = const [
    // Pending - Başvuru bekleyenler
    MyJobsModel(
      id: '1',
      title: 'Düğün Fotoğrafçısı',
      company: 'Studio Kreatif',
      description: 'Düğün töreni fotoğraf çekimi, 6 saat',
      date: '15.03.2026',
      price: 3500,
      status: MyJobStatus.pending,
    ),
    MyJobsModel(
      id: '2',
      title: 'Cafe Barista',
      company: 'Kahve Durağı',
      description: 'Hafta sonu barista, sabah vardiyası',
      date: '12.03.2026',
      price: 1200,
      status: MyJobStatus.pending,
    ),
    MyJobsModel(
      id: '3',
      title: 'Kedi Bakıcısı',
      company: 'PetFriends',
      description: '3 gün boyunca 2 kedi bakımı',
      date: '18.03.2026',
      price: 900,
      status: MyJobStatus.pending,
    ),

    // Approved - Onaylanmış, gidilmesi beklenen
    MyJobsModel(
      id: '4',
      title: 'Ürün Fotoğrafçısı',
      company: 'E-Ticaret Plus',
      description: '50 ürün için stüdyo çekimi',
      date: '08.03.2026',
      price: 2800,
      status: MyJobStatus.approved,
    ),
    MyJobsModel(
      id: '5',
      title: 'Garson',
      company: 'Lezzet Restoran',
      description: 'Akşam vardiyası, özel davet servisi',
      date: '07.03.2026',
      price: 1500,
      status: MyJobStatus.approved,
    ),

    // Completed - İş bitti, ödeme bekleniyor
    MyJobsModel(
      id: '6',
      title: 'Etkinlik Fotoğrafçısı',
      company: 'EventShot Medya',
      description: 'Kurumsal lansman etkinliği çekimi',
      date: '01.03.2026',
      price: 4000,
      status: MyJobStatus.completed,
    ),
    MyJobsModel(
      id: '7',
      title: 'Logo Tasarımcısı',
      company: 'Starter Ajans',
      description: 'Startup için logo ve marka kimliği',
      date: '28.02.2026',
      price: 2200,
      status: MyJobStatus.completed,
    ),

    // Past - Tamamlanmış ve ödemesi alınmış
    MyJobsModel(
      id: '8',
      title: 'Düğün Fotoğrafçısı',
      company: 'Aşk Stüdyo',
      description: 'Kır düğünü fotoğraf ve video çekimi',
      date: '20.02.2026',
      price: 5000,
      status: MyJobStatus.past,
    ),
    MyJobsModel(
      id: '9',
      title: 'Barista',
      company: 'Coffee Lab',
      description: 'Özel etkinlik için barista hizmeti',
      date: '14.02.2026',
      price: 1800,
      status: MyJobStatus.past,
    ),
    MyJobsModel(
      id: '10',
      title: 'Garson',
      company: 'Grand Otel',
      description: 'Gala yemeği servis hizmeti',
      date: '10.02.2026',
      price: 1600,
      status: MyJobStatus.past,
    ),
    MyJobsModel(
      id: '11',
      title: 'Köpek Bakıcısı',
      company: 'Happy Paws',
      description: '1 hafta Golden Retriever bakımı',
      date: '05.02.2026',
      price: 2100,
      status: MyJobStatus.past,
    ),
    MyJobsModel(
      id: '12',
      title: 'Ürün Fotoğrafçısı',
      company: 'ModaStyle',
      description: 'Sezon kataloğu için 100 ürün çekimi',
      date: '28.01.2026',
      price: 5500,
      status: MyJobStatus.past,
    ),
    MyJobsModel(
      id: '13',
      title: 'Sosyal Medya Tasarımcısı',
      company: 'DigiBoost',
      description: 'Instagram içerik tasarımı, 30 görsel',
      date: '20.01.2026',
      price: 3000,
      status: MyJobStatus.past,
    ),
  ];
}
