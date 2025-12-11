import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:koala/core/constants.dart';

class ListExplorePage extends StatefulWidget {
  const ListExplorePage({super.key});

  @override
  State<ListExplorePage> createState() => _ListExplorePageState();
}

class _ListExplorePageState extends State<ListExplorePage> {
  bool isOpen = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      extendBody: true,
      extendBodyBehindAppBar: false,
      body: CustomScrollView(
        slivers: [
          //TODO: Küçük ekranlar için responsive tasarım
          SliverAppBar(
            pinned: true,
            floating: true,
            snap: false,
            stretch: true,
            expandedHeight: 124,
            collapsedHeight: 124,
            elevation: 0,
            backgroundColor: Colors.white,
            surfaceTintColor: Colors.white,
            clipBehavior: Clip.hardEdge,
            title: const Text(
              'KOALA',
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 30,
                fontWeight: FontWeight.w800,
                color: ThemeConstants.primaryColor,
              ),
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
            ),
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                  ),
                  color: Colors.white,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Stack(
                          clipBehavior: Clip.none,
                          alignment: Alignment.centerRight,
                          children: [
                            // 🔹 Açılan TextField (butonun altından)
                            AnimatedContainer(
                              duration: const Duration(milliseconds: 200),
                              curve: Curves.easeInOut,
                              width: isOpen
                                  ? MediaQuery.of(context).size.width - 32
                                  : 50,
                              height: 60,
                              child: TextField(
                                decoration: InputDecoration(
                                  hintText: "Ara...",
                                  filled: true,
                                  fillColor: isOpen
                                      ? Colors.grey[200]
                                      : Colors.transparent,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(30),
                                    borderSide: BorderSide.none,
                                  ),
                                  suffixIcon: Hero(
                                    tag: 'search_button',
                                    child: IconButton(
                                      icon: const Icon(
                                        HugeIcons.strokeRoundedSearch01,
                                        size: 24,
                                      ),
                                      style: ButtonStyle(
                                        backgroundColor: WidgetStatePropertyAll(
                                          ThemeConstants.primaryColor,
                                        ),
                                        padding: WidgetStatePropertyAll(
                                          EdgeInsets.all(8),
                                        ),
                                      ),
                                      color: Colors.white,
                                      onPressed: () {},
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                      ],
                    ),
                    SizedBox(width: 16),
                  ],
                ),
              ),
            ),
          ),
          // Kategoriler Bölümü
          SliverToBoxAdapter(
            child: Container(
              width: double.infinity,
              margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
              padding: const EdgeInsets.fromLTRB(16, 10, 16, 16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Kategoriler',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Colors.black87,
                        ),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: Icon(
                          HugeIcons.strokeRoundedArrowRight01,
                          size: 20,
                        ),
                        style: ButtonStyle(
                          backgroundColor: WidgetStateProperty.all(
                            Colors.grey[200],
                          ),
                          padding: WidgetStateProperty.all(EdgeInsets.all(4)),
                          minimumSize: WidgetStateProperty.all(Size(28, 28)),
                          fixedSize: WidgetStateProperty.all(Size(28, 28)),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  SizedBox(
                    height: 40,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: 8,
                      itemBuilder: (context, index) {
                        final categories = [
                          {
                            'name': 'Bahçıvanlık',
                            'icon': HugeIcons.strokeRoundedPlant01,
                          },
                          {
                            'name': 'Temizlik',
                            'icon': HugeIcons.strokeRoundedClean,
                          },
                          {
                            'name': 'Elektrik',
                            'icon': HugeIcons.strokeRoundedElectricWire,
                          },
                          {
                            'name': 'Su Tesisatı',
                            'icon': HugeIcons.strokeRoundedWaterEnergy,
                          },
                          {
                            'name': 'Boyacılık',
                            'icon': HugeIcons.strokeRoundedPaintBrush01,
                          },
                          {
                            'name': 'Nakliye',
                            'icon': HugeIcons.strokeRoundedTruck,
                          },
                          {
                            'name': 'İnşaat',
                            'icon': HugeIcons.strokeRoundedWork,
                          },
                          {
                            'name': 'Diğer',
                            'icon': HugeIcons.strokeRoundedMore01,
                          },
                        ];

                        return Container(
                          height: 50,
                          margin: EdgeInsets.only(right: 12),
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Row(
                            children: [
                              SizedBox(width: 8),
                              Container(
                                width: 20,
                                height: 20,
                                decoration: BoxDecoration(
                                  color: ThemeConstants.primaryColor,
                                  borderRadius: BorderRadius.circular(25),
                                ),
                                child: Icon(
                                  categories[index]['icon'] as IconData,
                                  color: Colors.white,
                                  size: 16,
                                ),
                              ),
                              SizedBox(width: 8),
                              Text(
                                categories[index]['name'] as String,
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black87,
                                ),
                                textAlign: TextAlign.center,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              SizedBox(width: 8),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Yakındaki İşler Başlığı
          SliverToBoxAdapter(
            child: Container(
              padding: EdgeInsets.fromLTRB(16, 14, 0, 14),
              child: Text(
                'Yakındaki İşler',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 30,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
            ),
          ),

          // İş Listesi
          SliverList(
            delegate: SliverChildBuilderDelegate((context, index) {
              return Card(
                elevation: 0,
                margin: EdgeInsets.only(bottom: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: ListTile(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  contentPadding: const EdgeInsets.all(16),
                  leading: CircleAvatar(
                    backgroundColor: ThemeConstants.primaryColor,
                    child: Icon(
                      index % 2 == 0
                          ? HugeIcons.strokeRoundedWork
                          : HugeIcons.strokeRoundedUser,
                      color: Colors.white,
                    ),
                  ),
                  title: Text(
                    index % 2 == 0
                        ? 'İş Fırsatı ${index + 1}'
                        : 'Çalışan ${index + 1}',
                    style: const TextStyle(
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                  ),
                  subtitle: Text(
                    index % 2 == 0
                        ? 'Bahçe düzenleme işi - 2.5 km uzaklıkta'
                        : 'Deneyimli bahçıvan - 1.8 km uzaklıkta',
                    style: const TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 14,
                      color: Colors.grey,
                    ),
                  ),
                  trailing: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: ThemeConstants.primaryColor,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Text(
                      index % 2 == 0 ? '₺250' : '₺180/gün',
                      style: const TextStyle(
                        color: Colors.white,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w600,
                        fontSize: 12,
                      ),
                    ),
                  ),
                  onTap: () {},
                ),
              );
            }, childCount: 10),
          ),
        ],
      ),
    );
  }
}
