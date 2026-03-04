import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:koala/employee/features/home/data/models/job_model.dart';
import 'package:koala/employee/features/home/data/repositories/job_repository.dart';
import 'package:koala/employee/features/home/presentation/widgets/job_card.dart';
import 'package:geolocator/geolocator.dart';

part 'list_explore_pagemodel.dart';

class ListExplorePage extends StatefulWidget {
  const ListExplorePage({super.key});

  @override
  State<ListExplorePage> createState() => _ListExplorePageState();
}

class _ListExplorePageState extends ListExplorePagemodel {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return GestureDetector(
      onTap: () => _searchFocusNode.unfocus(),
      child: Scaffold(
        backgroundColor: Colors.grey[200],
        extendBody: true,
        extendBodyBehindAppBar: false,
        body: CustomScrollView(
          slivers: [
            appBar(context),
            SliverToBoxAdapter(child: const SizedBox(height: 10)),
            filters(),

            // Arama aktifse sonuç sayısını göster
            if (_searchQuery.isNotEmpty)
              SliverToBoxAdapter(
                child: Container(
                  padding: const EdgeInsets.fromLTRB(16, 14, 16, 0),
                  child: Row(
                    children: [
                      Text(
                        '"$_searchQuery" için ${_filteredJobs.length} sonuç',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Colors.grey[600],
                        ),
                      ),
                      const Spacer(),
                      GestureDetector(
                        onTap: _clearSearch,
                        child: Text(
                          'Temizle',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Theme.of(context).colorScheme.primary,
                          ),
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
                  _searchQuery.isNotEmpty
                      ? 'Arama Sonuçları'
                      : 'Yakındaki İşler',
                  style: const TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 30,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
              ),
            ),

            // İş Listesi
            if (_loading)
              SliverToBoxAdapter(
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(32.0),
                    child: CircularProgressIndicator(
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                ),
              )
            else if (_filteredJobs.isEmpty)
              SliverToBoxAdapter(
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(32.0),
                    child: Column(
                      children: [
                        Icon(
                          HugeIcons.strokeRoundedSearchList01,
                          size: 64,
                          color: Colors.grey[400],
                        ),
                        const SizedBox(height: 16),
                        Text(
                          _searchQuery.isNotEmpty
                              ? '"$_searchQuery" ile eşleşen iş bulunamadı'
                              : 'Bu filtreye uygun iş bulunamadı',
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 16,
                            color: Colors.grey,
                          ),
                        ),
                        if (_searchQuery.isNotEmpty) ...[
                          const SizedBox(height: 12),
                          TextButton(
                            onPressed: _clearSearch,
                            child: Text(
                              'Aramayı Temizle',
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: Theme.of(context).colorScheme.primary,
                              ),
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                ),
              )
            else
              SliverList(
                delegate: SliverChildBuilderDelegate((context, index) {
                  final job = _filteredJobs[index];
                  final distance = _getDistance(job);
                  return JobCard(job: job, distance: distance);
                }, childCount: _filteredJobs.length),
              ),
            SliverToBoxAdapter(child: SizedBox(height: 100)),
          ],
        ),
      ),
    );
  }

  SliverToBoxAdapter filters() {
    return SliverToBoxAdapter(
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          children: [
            // Sırala butonu
            _buildFilterButton(
              icon: HugeIcons.strokeRoundedArrowDataTransferVertical,
              label: 'Sırala',
              onTap: () {},
            ),
            SizedBox(width: 8),
            // Kategoriler butonu
            _buildFilterButton(
              icon: HugeIcons.strokeRoundedMenu01,
              label: 'Kategoriler',
              isActive: _selectedFilter != 'all',
              onTap: () => _showCategoryFilterSheet(),
            ),
            SizedBox(width: 8),
            // Ücret butonu
            _buildFilterButton(
              icon: HugeIcons.strokeRoundedMoneyBag02,
              label: 'Ücret',
              isActive: _selectedPriceRange != 'all',
              onTap: () => _showPriceFilterSheet(),
            ),
            SizedBox(width: 8),
            // Mesafe butonu
            _buildFilterButton(
              icon: HugeIcons.strokeRoundedRoute02,
              label: 'Mesafe',
              isActive: _selectedDistance != 'all',
              onTap: () => _showDistanceFilterSheet(),
            ),
          ],
        ),
      ),
    );
  }

  SliverAppBar appBar(BuildContext context) {
    return SliverAppBar(
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
                      // 🔹 Açılan TextField
                      AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        curve: Curves.easeInOut,
                        width: isOpen
                            ? MediaQuery.of(context).size.width - 32
                            : 50,
                        height: 60,
                        child: TextField(
                          controller: _searchController,
                          focusNode: _searchFocusNode,
                          onChanged: _onSearchChanged,
                          style: const TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 15,
                          ),
                          decoration: InputDecoration(
                            hintText: "İş, şirket veya konum ara...",
                            hintStyle: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 15,
                              color: Colors.grey[400],
                            ),
                            filled: true,
                            fillColor: isOpen
                                ? Colors.grey[200]
                                : Colors.transparent,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                              borderSide: BorderSide.none,
                            ),
                            prefixIcon: _searchQuery.isNotEmpty
                                ? IconButton(
                                    icon: Icon(
                                      Icons.close,
                                      size: 20,
                                      color: Colors.grey[600],
                                    ),
                                    onPressed: _clearSearch,
                                  )
                                : null,
                            suffixIcon: IconButton(
                              icon: const Icon(
                                HugeIcons.strokeRoundedSearch01,
                                size: 24,
                              ),
                              style: ButtonStyle(
                                backgroundColor: WidgetStatePropertyAll(
                                  Theme.of(context).colorScheme.primary,
                                ),
                                padding: const WidgetStatePropertyAll(
                                  EdgeInsets.all(8),
                                ),
                              ),
                              color: Colors.white,
                              onPressed: () {
                                if (_searchFocusNode.hasFocus) {
                                  _searchFocusNode.unfocus();
                                } else {
                                  _searchFocusNode.requestFocus();
                                }
                              },
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
    );
  }

  Widget _buildFilterButton({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
    bool isActive = false,
  }) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          height: 40,
          padding: EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            color: isActive
                ? Theme.of(context).colorScheme.primary.withValues(alpha: 0.15)
                : Colors.white,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: isActive
                  ? Theme.of(context).colorScheme.primary
                  : Colors.grey[300]!,
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                icon,
                size: 16,
                color: isActive
                    ? Theme.of(context).colorScheme.primary
                    : Colors.grey[700],
              ),
              SizedBox(width: 4),
              Flexible(
                child: Text(
                  label,
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: isActive
                        ? Theme.of(context).colorScheme.primary
                        : Colors.grey[700],
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showCategoryFilterSheet() {
    _showCategoryFilter();
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => _buildCategoryBottomSheet(),
    );
  }

  void _showPriceFilterSheet() {
    _showPriceFilter();
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => _buildPriceBottomSheet(),
    );
  }

  void _showDistanceFilterSheet() {
    _showDistanceFilter();
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => _buildDistanceBottomSheet(),
    );
  }

  Widget _buildCategoryBottomSheet() {
    return StatefulBuilder(
      builder: (context, setModalState) {
        return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
          ),
          padding: EdgeInsets.fromLTRB(
            20,
            20,
            20,
            MediaQuery.of(context).padding.bottom + 20,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Kategoriler',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.close),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
              SizedBox(height: 16),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  _buildFilterChip(
                    'Tümü',
                    'all',
                    _tempFilter,
                    (val) => setModalState(() => _tempFilter = val),
                  ),
                  _buildFilterChip(
                    'Günlük',
                    'oneTime',
                    _tempFilter,
                    (val) => setModalState(() => _tempFilter = val),
                  ),
                  _buildFilterChip(
                    'Tekrarlı',
                    'recurring',
                    _tempFilter,
                    (val) => setModalState(() => _tempFilter = val),
                  ),
                  _buildFilterChip(
                    'Fotoğrafçılık',
                    'photography',
                    _tempFilter,
                    (val) => setModalState(() => _tempFilter = val),
                  ),
                  _buildFilterChip(
                    'Garsonluk',
                    'waiter',
                    _tempFilter,
                    (val) => setModalState(() => _tempFilter = val),
                  ),
                  _buildFilterChip(
                    'Hayvan Bakımı',
                    'petCare',
                    _tempFilter,
                    (val) => setModalState(() => _tempFilter = val),
                  ),
                  _buildFilterChip(
                    'Tasarım',
                    'design',
                    _tempFilter,
                    (val) => setModalState(() => _tempFilter = val),
                  ),
                  _buildFilterChip(
                    'Barista',
                    'barista',
                    _tempFilter,
                    (val) => setModalState(() => _tempFilter = val),
                  ),
                ],
              ),
              SizedBox(height: 20),
              _buildApplyButton(),
            ],
          ),
        );
      },
    );
  }

  Widget _buildPriceBottomSheet() {
    return StatefulBuilder(
      builder: (context, setModalState) {
        return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
          ),
          padding: EdgeInsets.fromLTRB(
            20,
            20,
            20,
            MediaQuery.of(context).padding.bottom + 20,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Ücret Aralığı',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.close),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
              SizedBox(height: 16),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  _buildFilterChip(
                    'Tümü',
                    'all',
                    _tempPriceRange,
                    (val) => setModalState(() => _tempPriceRange = val),
                  ),
                  _buildFilterChip(
                    '0-500₺',
                    '0-500',
                    _tempPriceRange,
                    (val) => setModalState(() => _tempPriceRange = val),
                  ),
                  _buildFilterChip(
                    '500-1000₺',
                    '500-1000',
                    _tempPriceRange,
                    (val) => setModalState(() => _tempPriceRange = val),
                  ),
                  _buildFilterChip(
                    '1000-2000₺',
                    '1000-2000',
                    _tempPriceRange,
                    (val) => setModalState(() => _tempPriceRange = val),
                  ),
                  _buildFilterChip(
                    '2000₺+',
                    '2000+',
                    _tempPriceRange,
                    (val) => setModalState(() => _tempPriceRange = val),
                  ),
                ],
              ),
              SizedBox(height: 20),
              _buildApplyButton(),
            ],
          ),
        );
      },
    );
  }

  Widget _buildDistanceBottomSheet() {
    return StatefulBuilder(
      builder: (context, setModalState) {
        return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
          ),
          padding: EdgeInsets.fromLTRB(
            20,
            20,
            20,
            MediaQuery.of(context).padding.bottom + 20,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Mesafe',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.close),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
              SizedBox(height: 16),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  _buildFilterChip(
                    'Tümü',
                    'all',
                    _tempDistance,
                    (val) => setModalState(() => _tempDistance = val),
                  ),
                  _buildFilterChip(
                    '0-5 km',
                    '0-5',
                    _tempDistance,
                    (val) => setModalState(() => _tempDistance = val),
                  ),
                  _buildFilterChip(
                    '5-10 km',
                    '5-10',
                    _tempDistance,
                    (val) => setModalState(() => _tempDistance = val),
                  ),
                  _buildFilterChip(
                    '10-20 km',
                    '10-20',
                    _tempDistance,
                    (val) => setModalState(() => _tempDistance = val),
                  ),
                  _buildFilterChip(
                    '20+ km',
                    '20+',
                    _tempDistance,
                    (val) => setModalState(() => _tempDistance = val),
                  ),
                ],
              ),
              SizedBox(height: 20),
              _buildApplyButton(),
            ],
          ),
        );
      },
    );
  }

  Widget _buildFilterChip(
    String label,
    String value,
    String currentValue,
    Function(String) onTap,
  ) {
    final isSelected = currentValue == value;
    return GestureDetector(
      onTap: () => onTap(value),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: isSelected
              ? Theme.of(context).colorScheme.primary
              : Colors.grey[200],
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: isSelected ? Colors.white : Colors.black87,
          ),
        ),
      ),
    );
  }

  Widget _buildApplyButton() {
    return SizedBox(
      width: double.infinity,
      height: 56,
      child: ElevatedButton(
        onPressed: _applyTempFilters,
        style: ElevatedButton.styleFrom(
          backgroundColor: Theme.of(context).colorScheme.primary,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 0,
        ),
        child: Text(
          'Uygula',
          style: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
