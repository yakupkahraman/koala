import 'package:koala/employee/features/company_detail/domain/company_model.dart';
import 'package:koala/employee/features/company_detail/domain/address_model.dart';

/// Fake şirket verilerini sağlayan repository
/// Backend hazır olduğunda burası gerçek API'ye bağlanacak
class CompanyRepository {
  /// Singleton instance
  static final CompanyRepository _instance = CompanyRepository._internal();
  factory CompanyRepository() => _instance;
  CompanyRepository._internal();

  /// Fake şirket verileri
  final Map<String, CompanyModel> _fakeCompanies = {
    'comp_1': CompanyModel(
      id: 'comp_1',
      name: 'Özlem & Murat Düğün Organizasyonu',
      email: 'info@omlmdugum.com',
      phoneNumber: '+90 312 555 0101',
      website: 'www.ozlemmuratdugun.com',
      description:
          'Ankara\'da 10 yıldır hizmet veren profesyonel düğün organizasyon şirketi. Hayalinizdeki düğünü gerçeğe dönüştürüyoruz.',
      address: AddressModel(
        id: 'addr_1',
        street: 'Kızılırmak Mahallesi, 1443. Cadde No:12/5',
        city: 'Ankara',
        district: 'Çankaya',
        postalCode: '06510',
        country: 'Türkiye',
        latitude: 39.9334,
        longitude: 32.8597,
      ),
      taxNumber: '1234567890',
      type: CompanyType.individual,
      isApproved: true,
    ),
    'comp_2': CompanyModel(
      id: 'comp_2',
      name: 'Kahve Durağı Cafe',
      email: 'iletisim@kahveduragi.com',
      phoneNumber: '+90 312 555 0202',
      website: 'www.kahveduragi.com',
      description:
          'Kızılay\'ın kalbinde özel kahve çeşitleri ve ev yapımı pastalarıyla hizmet veren samimi bir cafe. Her gün taze kahve ve sıcak bir ortam.',
      address: AddressModel(
        id: 'addr_2',
        street: 'Ziya Gökalp Caddesi No:45/A',
        city: 'Ankara',
        district: 'Kızılay',
        postalCode: '06420',
        country: 'Türkiye',
        latitude: 39.9208,
        longitude: 32.8541,
      ),
      taxNumber: '2345678901',
      type: CompanyType.corporate,
      isApproved: true,
    ),
    'comp_3': CompanyModel(
      id: 'comp_3',
      name: 'Ahmet Yılmaz (Bireysel)',
      email: 'ahmet.yilmaz@email.com',
      phoneNumber: '+90 532 555 0303',
      description:
          'Hayvan sever bireysel iş veren. Kedilerime iyi bakılmasını istiyorum.',
      address: AddressModel(
        id: 'addr_3',
        street: 'Çukurambar Mahallesi',
        city: 'Ankara',
        district: 'Çankaya',
        postalCode: '06530',
        country: 'Türkiye',
        latitude: 39.9427,
        longitude: 32.8564,
      ),
      type: CompanyType.individual,
      isApproved: true,
    ),
    'comp_4': CompanyModel(
      id: 'comp_4',
      name: 'Lezzet Durağı Restaurant',
      email: 'info@lezzetduragi.com',
      phoneNumber: '+90 312 555 0404',
      website: 'www.lezzetduragi.com',
      description:
          'Modern ve geleneksel Türk mutfağını bir araya getiren özgün konseptli restoranımız yakında açılıyor. Lezzet dolu bir yolculuğa hazır olun!',
      address: AddressModel(
        id: 'addr_4',
        street: 'Tunalı Hilmi Caddesi No:78/B',
        city: 'Ankara',
        district: 'Kavaklıdere',
        postalCode: '06680',
        country: 'Türkiye',
        latitude: 39.9180,
        longitude: 32.8619,
      ),
      taxNumber: '3456789012',
      type: CompanyType.corporate,
      isApproved: true,
    ),
    'comp_5': CompanyModel(
      id: 'comp_5',
      name: 'Brew & Co. Specialty Coffee',
      email: 'hello@brewandco.com',
      phoneNumber: '+90 312 555 0505',
      website: 'www.brewandco.com',
      description:
          'Ankara\'nın ilk specialty coffee mekânlarından biri. Dünyanın dört bir yanından özenle seçilmiş kahve çekirdekleri ve profesyonel barista ekibi.',
      address: AddressModel(
        id: 'addr_5',
        street: 'Tunalı Hilmi Caddesi No:125/3',
        city: 'Ankara',
        district: 'Çankaya',
        postalCode: '06700',
        country: 'Türkiye',
        latitude: 39.9281,
        longitude: 32.8673,
      ),
      taxNumber: '4567890123',
      type: CompanyType.corporate,
      isApproved: true,
    ),
    'comp_6': CompanyModel(
      id: 'comp_6',
      name: 'TrendShop E-ticaret',
      email: 'destek@trendshop.com',
      phoneNumber: '+90 312 555 0606',
      website: 'www.trendshop.com',
      description:
          'Moda ve aksesuar e-ticaret platformu. En yeni trendleri uygun fiyatlarla müşterilerimize ulaştırıyoruz.',
      address: AddressModel(
        id: 'addr_6',
        street: 'Ümit Mahallesi, 2450. Cadde No:8/12',
        city: 'Ankara',
        district: 'Ümitköy',
        postalCode: '06810',
        country: 'Türkiye',
        latitude: 39.9356,
        longitude: 32.8489,
      ),
      taxNumber: '5678901234',
      type: CompanyType.corporate,
      isApproved: true,
    ),
    'comp_7': CompanyModel(
      id: 'comp_7',
      name: 'Elit Organizasyon',
      email: 'info@elitorganizasyon.com',
      phoneNumber: '+90 312 555 0707',
      website: 'www.elitorganizasyon.com',
      description:
          'Kurumsal etkinlik, toplantı ve özel organizasyon hizmetlerinde 15 yıllık deneyim. Her detayda mükemmellik.',
      address: AddressModel(
        id: 'addr_7',
        street: 'Sheraton Hotel & Convention Center',
        city: 'Ankara',
        district: 'Çankaya',
        postalCode: '06700',
        country: 'Türkiye',
        latitude: 39.9123,
        longitude: 32.8712,
      ),
      taxNumber: '6789012345',
      type: CompanyType.corporate,
      isApproved: true,
    ),
    'comp_8': CompanyModel(
      id: 'comp_8',
      name: 'Zeynep Kaya (Bireysel)',
      email: 'zeynep.kaya@email.com',
      phoneNumber: '+90 535 555 0808',
      description:
          'Golden Retriever sahibi. Köpeğime profesyonel ve sevgi dolu bir bakım arıyorum.',
      address: AddressModel(
        id: 'addr_8',
        street: 'Bahçelievler Mahallesi',
        city: 'Ankara',
        district: 'Çankaya',
        postalCode: '06490',
        country: 'Türkiye',
        latitude: 39.9398,
        longitude: 32.8398,
      ),
      type: CompanyType.individual,
      isApproved: true,
    ),
    'comp_9': CompanyModel(
      id: 'comp_9',
      name: 'FitLife Spor Salonu',
      email: 'bilgi@fitlifegym.com',
      phoneNumber: '+90 312 555 0909',
      website: 'www.fitlifegym.com',
      description:
          'Modern ekipman, profesyonel eğitmenler ve motivasyon dolu bir ortam. Sağlıklı yaşam yolculuğunuz FitLife ile başlasın!',
      address: AddressModel(
        id: 'addr_9',
        street: 'Çayyolu Caddesi No:156/C',
        city: 'Ankara',
        district: 'Çankaya',
        postalCode: '06810',
        country: 'Türkiye',
        latitude: 39.9245,
        longitude: 32.8456,
      ),
      taxNumber: '7890123456',
      type: CompanyType.corporate,
      isApproved: true,
    ),
    'comp_10': CompanyModel(
      id: 'comp_10',
      name: 'Coffee Break Cafe',
      email: 'info@coffeebreak.com',
      phoneNumber: '+90 312 555 1010',
      website: 'www.coffeebreakcafe.com',
      description:
          'Kızılay\'da bulunan huzurlu ve samimi atmosferli cafe. Kaliteli kahve, taze sandviçler ve güler yüzlü ekip.',
      address: AddressModel(
        id: 'addr_10',
        street: 'Necatibey Caddesi No:89/2',
        city: 'Ankara',
        district: 'Kızılay',
        postalCode: '06420',
        country: 'Türkiye',
        latitude: 39.9312,
        longitude: 32.8534,
      ),
      taxNumber: '8901234567',
      type: CompanyType.corporate,
      isApproved: true,
    ),
  };

  /// Tüm şirketleri getir
  Future<List<CompanyModel>> getCompanies() async {
    await Future.delayed(const Duration(milliseconds: 300));
    return _fakeCompanies.values.toList();
  }

  /// Belirli bir şirketi ID ile getir
  Future<CompanyModel?> getCompanyById(String id) async {
    await Future.delayed(const Duration(milliseconds: 150));
    return _fakeCompanies[id];
  }

  /// Şirket ismine göre şirket getir
  Future<CompanyModel?> getCompanyByName(String name) async {
    await Future.delayed(const Duration(milliseconds: 150));
    try {
      return _fakeCompanies.values.firstWhere(
        (company) => company.name == name,
      );
    } catch (e) {
      return null;
    }
  }

  /// Onaylı şirketleri getir
  Future<List<CompanyModel>> getApprovedCompanies() async {
    await Future.delayed(const Duration(milliseconds: 200));
    return _fakeCompanies.values.where((c) => c.isApproved).toList();
  }

  /// Şirket tipine göre şirketleri getir
  Future<List<CompanyModel>> getCompaniesByType(CompanyType type) async {
    await Future.delayed(const Duration(milliseconds: 200));
    return _fakeCompanies.values.where((c) => c.type == type).toList();
  }
}
