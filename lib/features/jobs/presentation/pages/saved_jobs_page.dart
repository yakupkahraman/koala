import 'package:flutter/material.dart';
import 'package:koala/core/constants.dart';

class SavedJobsPage extends StatefulWidget {
  const SavedJobsPage({super.key});

  @override
  State<SavedJobsPage> createState() => _SavedJobsPageState();
}

class _SavedJobsPageState extends State<SavedJobsPage> {
  // Örnek veri listesi
  final List<Map<String, String>> savedJobs = const [
    {
      "title": "Flutter Developer",
      "description": "Flutter ile mobil uygulama geliştirme",
      "date": "2023-09-01",
    },
    {
      "title": "Backend Developer",
      "description": "Node.js ile REST API geliştirme",
      "date": "2023-08-15",
    },
    {
      "title": "UI/UX Designer",
      "description": "Mobil uygulama için kullanıcı arayüzü tasarımı",
      "date": "2023-07-30",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        surfaceTintColor: Colors.white,
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          "Kaydettiğim İşlerim",
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
          padding: EdgeInsets.all(UiConstants.defaultPadding),
          child: ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            padding: EdgeInsets.zero, // ListView'in kendi padding'ini kaldır
            itemCount: savedJobs.length,
            itemBuilder: (context, index) {
              final savedJob = savedJobs[index];
              return Column(
                children: [
                  ListTile(
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 0,
                      vertical: 2, // Vertical padding'i azalt
                    ),
                    title: Text(
                      savedJob["title"]!,
                      style: TextStyle(
                        fontFamily: "Poppins",
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    subtitle: Text(
                      savedJob["description"]!,
                      style: TextStyle(color: Colors.black54),
                    ),
                    trailing: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        SizedBox(height: 6),
                        Text(
                          savedJob["date"]!,
                          style: TextStyle(color: Colors.black, fontSize: 14),
                        ),
                        Icon(Icons.bookmark, size: 30),
                      ],
                    ),
                  ),
                  if (index < savedJobs.length - 1)
                    Divider(
                      color: Colors.black.withOpacity(0.3),
                      thickness: 1,
                      height: 1,
                    ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
