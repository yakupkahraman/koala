import 'package:koala/employee/features/company_detail/domain/address_model.dart';
import 'package:koala/employee/features/company_detail/domain/company_model.dart';
import 'package:koala/employee/features/company_detail/domain/image_model.dart';

/// Business kullanıcısı için fake şirket verisi
class FakeBusinessCompany {
  static final CompanyModel instance = CompanyModel(
    id: 'comp_business_1',
    name: 'Kahve Durağı Cafe',
    email: 'iletisim@kahveduragi.com',
    phoneNumber: '+90 312 555 0202',
    logo: ImageModel(
      id: 'logo_2',
      url:
          'https://ui-avatars.com/api/?name=Kahve+Durağı&size=256&background=795548&color=ffffff&bold=true&format=png',
      name: 'Kahve Durağı Logo',
      contentType: 'image/png',
    ),
    website: 'www.kahveduragi.com',
    description:
        'Kızılay\'ın kalbinde özel kahve çeşitleri ve ev yapımı pastalarıyla hizmet veren samimi bir cafe. Her gün taze kahve ve sıcak bir ortam. 2018 yılından bu yana Ankara\'nın en sevilen buluşma noktalarından biri olmaya devam ediyoruz.',
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
  );
}
