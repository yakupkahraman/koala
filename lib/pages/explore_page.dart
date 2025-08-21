import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:koala/constants.dart';
import 'package:koala/providers/page_provider.dart';
import 'package:koala/pages/map_explore_page.dart';
import 'package:koala/pages/list_explore_page.dart';
import 'package:provider/provider.dart';

class ExplorePage extends StatefulWidget {
  const ExplorePage({super.key});

  @override
  State<ExplorePage> createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage> {
  bool isOpen = false;
  bool allowButtonAnimation = true; // Button animasyonunu kontrol etmek için
  ExploreViewType? _previousViewType;

  @override
  void initState() {
    super.initState();
    // İlk açılışta view type'ı kaydet
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final pageProvider = Provider.of<PageProvider>(context, listen: false);
      _previousViewType = pageProvider.exploreViewType;
    });
  }

  void _handleViewTypeChange(ExploreViewType currentViewType) {
    // Eğer map'ten list'e geçiş yapıldıysa
    if (_previousViewType == ExploreViewType.map &&
        currentViewType == ExploreViewType.list) {
      // Search button'un konumlandırma animasyonu süresini bekle (200ms)
      // sonra TextField'ı aç
      Future.delayed(const Duration(milliseconds: 100), () {
        if (mounted) {
          setState(() {
            isOpen = true;
          });
        }
      });
    } else if (_previousViewType == ExploreViewType.list &&
        currentViewType == ExploreViewType.map) {
      // List'ten map'e geçerken önce button animasyonunu durdur
      setState(() {
        allowButtonAnimation = false;
        isOpen = false;
      });

      // TextField kapanma animasyonu bitince (50ms) button animasyonunu başlat
      Future.delayed(const Duration(milliseconds: 100), () {
        if (mounted) {
          setState(() {
            allowButtonAnimation = true; // Button animasyonunu tekrar başlat
          });
        }
      });
    }

    _previousViewType = currentViewType;
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<PageProvider>(
      builder: (context, pageProvider, child) {
        // View type değişikliğini kontrol et
        WidgetsBinding.instance.addPostFrameCallback((_) {
          _handleViewTypeChange(pageProvider.exploreViewType);
        });

        return Stack(
          children: [
            IndexedStack(
              index: pageProvider.exploreViewType == ExploreViewType.map
                  ? 0
                  : 1,
              children: const [MapExplorePage(), ListExplorePage()],
            ),

            //toggle view
            Positioned(
              bottom: 100,
              left: 36,
              child: FloatingActionButton(
                mini: true,
                elevation: 4,
                onPressed: () {
                  final pageProvider = Provider.of<PageProvider>(
                    context,
                    listen: false,
                  );
                  pageProvider.toggleExploreView();
                },
                backgroundColor: kMainGreenColor,

                child: Icon(
                  pageProvider.exploreViewType == ExploreViewType.map
                      ? HugeIcons.strokeRoundedListView
                      : HugeIcons.strokeRoundedMaps,
                  color: Colors.white,
                  size: 20,
                ),
              ),
            ),

            //search button
            Stack(
              clipBehavior: Clip.none,
              children: [
                // 🔹 Açılan TextField (butonun altından)
                Positioned(
                  top: pageProvider.exploreViewType == ExploreViewType.map
                      ? 30
                      : 80,
                  right: 16,
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    curve: Curves.easeInOut,
                    width: isOpen ? MediaQuery.of(context).size.width - 32 : 0,
                    height: 60,
                    child: TextField(
                      onTap: () {
                        context.push('/search');
                      },
                      readOnly: true, // Klavyenin açılmasını önler
                      decoration: InputDecoration(
                        hintText: "Ara...",
                        filled: true,
                        fillColor: Colors.grey[200],
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                  ),
                ),

                AnimatedPositioned(
                  duration: allowButtonAnimation
                      ? Duration(milliseconds: 200)
                      : Duration.zero, // Animasyon kontrolü
                  curve: Curves.easeInOut,
                  top: pageProvider.exploreViewType == ExploreViewType.map
                      ? 30
                      : 84,
                  right: 16,
                  child: Hero(
                    tag: 'search_button',
                    child: IconButton(
                      icon: const Icon(
                        HugeIcons.strokeRoundedSearch01,
                        size: 24,
                      ),
                      style: ButtonStyle(
                        backgroundColor: WidgetStatePropertyAll(
                          kMainGreenColor,
                        ),
                        padding: WidgetStatePropertyAll(EdgeInsets.all(8)),
                      ),
                      color: Colors.white,
                      onPressed: () {
                        context.push('/search');
                      },
                    ),
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
