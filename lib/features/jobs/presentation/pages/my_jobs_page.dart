import 'package:flutter/material.dart';
import 'package:koala/core/constants.dart';

class MyJobsPage extends StatefulWidget {
  const MyJobsPage({super.key});

  @override
  State<MyJobsPage> createState() => _MyJobsPageState();
}

class _MyJobsPageState extends State<MyJobsPage> {
  bool showAllPastJobs = false;

  // Örnek veri listesi
  final List<Map<String, String>> jobs = const [
    {"title": "İş 1", "description": "İş açıklaması 1", "date": "17.07.2025"},
    {"title": "İş 2", "description": "İş açıklaması 2", "date": "18.07.2025"},
    {"title": "İş 3", "description": "İş açıklaması 3", "date": "19.07.2025"},
    {"title": "İş 4", "description": "İş açıklaması 4", "date": "20.07.2025"},
  ];

  final List<Map<String, String>> pastJobs = const [
    {
      "title": "Geçmiş İş 1",
      "description": "Geçmiş iş açıklaması 1",
      "date": "10.07.2025",
    },
    {
      "title": "Geçmiş İş 2",
      "description": "Geçmiş iş açıklaması 2",
      "date": "11.07.2025",
    },
    {
      "title": "Geçmiş İş 3",
      "description": "Geçmiş iş açıklaması 3",
      "date": "12.07.2025",
    },
    {
      "title": "Geçmiş İş 4",
      "description": "Geçmiş iş açıklaması 4",
      "date": "13.07.2025",
    },
    {
      "title": "Geçmiş İş 5",
      "description": "Geçmiş iş açıklaması 5",
      "date": "14.07.2025",
    },
    {
      "title": "Geçmiş İş 6",
      "description": "Geçmiş iş açıklaması 6",
      "date": "15.07.2025",
    },
  ];

  @override
  Widget build(BuildContext context) {
    // Gösterilecek geçmiş iş sayısını belirle
    int pastJobsToShow = showAllPastJobs ? pastJobs.length : 2;

    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        surfaceTintColor: Colors.white,
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          "İşlerim",
          style: TextStyle(
            fontFamily: "Poppins",
            color: Colors.black,
            fontSize: 24,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: UiConstants.defaultPadding),
          child: Column(
            mainAxisSize: MainAxisSize.min, // Column'u minimum boyutta tut
            children: [
              // Aktif İşler Container'ı
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: ThemeConstants.primaryColor,
                ),
                child: Column(
                  mainAxisSize:
                      MainAxisSize.min, // Column'u minimum boyutta tut
                  children: [
                    Text(
                      "Aktif",
                      style: TextStyle(
                        fontFamily: "Poppins",
                        color: Colors.white,
                        fontSize: 28.0,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 16),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      padding: EdgeInsets
                          .zero, // ListView'in kendi padding'ini kaldır
                      itemCount: jobs.length,
                      itemBuilder: (context, index) {
                        final job = jobs[index];
                        return Column(
                          children: [
                            ListTile(
                              contentPadding: EdgeInsets.symmetric(
                                horizontal: 0,
                                vertical: 2, // Vertical padding'i azalt
                              ),
                              title: Text(
                                job["title"]!,
                                style: TextStyle(
                                  fontFamily: "Poppins",
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              subtitle: Text(
                                job["description"]!,
                                style: TextStyle(color: Colors.white70),
                              ),
                              trailing: Text(
                                job["date"]!,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                            if (index < jobs.length - 1)
                              Divider(
                                color: Colors.white.withOpacity(0.3),
                                thickness: 1,
                                height: 1,
                              ),
                          ],
                        );
                      },
                    ),
                  ],
                ),
              ),

              SizedBox(height: 24),

              // Geçmiş İşler Bölümü
              Column(
                mainAxisSize: MainAxisSize.min, // Column'u minimum boyutta tut
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Geçmiş",
                    style: TextStyle(
                      fontFamily: "Poppins",
                      color: Colors.black,
                      fontSize: 28.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 16),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    padding:
                        EdgeInsets.zero, // ListView'in kendi padding'ini kaldır
                    itemCount: pastJobsToShow,
                    itemBuilder: (context, index) {
                      final pastJob = pastJobs[index];
                      return Column(
                        children: [
                          ListTile(
                            contentPadding: EdgeInsets.symmetric(
                              horizontal: 0,
                              vertical: 2, // Vertical padding'i azalt
                            ),
                            title: Text(
                              pastJob["title"]!,
                              style: TextStyle(
                                fontFamily: "Poppins",
                                color: Colors.black,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            subtitle: Text(
                              pastJob["description"]!,
                              style: TextStyle(color: Colors.black54),
                            ),
                            trailing: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                SizedBox(height: 6),
                                Text(
                                  pastJob["date"]!,
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 14,
                                  ),
                                ),
                                Icon(Icons.file_present_rounded, size: 30),
                              ],
                            ),
                          ),
                          if (index < pastJobs.length - 1)
                            Divider(
                              color: Colors.black.withOpacity(0.3),
                              thickness: 1,
                              height: 1,
                            ),
                        ],
                      );
                    },
                  ),

                  // Daha fazla göster butonu
                  if (pastJobs.length > 2)
                    Padding(
                      padding: EdgeInsets.only(
                        top: 8,
                      ), // Sadece üstte biraz boşluk
                      child: TextButton.icon(
                        onPressed: () {
                          setState(() {
                            showAllPastJobs = !showAllPastJobs;
                          });
                        },
                        icon: Icon(
                          showAllPastJobs
                              ? Icons.keyboard_arrow_up
                              : Icons.keyboard_arrow_down,
                          color: ThemeConstants.primaryColor,
                        ),
                        label: Text(
                          showAllPastJobs
                              ? "Daha az göster"
                              : "Daha fazla göster (${pastJobs.length - 2} daha)",
                          style: TextStyle(
                            color: ThemeConstants.primaryColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                ],
              ),

              SizedBox(height: 100), // Bottom navigation için boşluk
            ],
          ),
        ),
      ),
    );
  }
}
