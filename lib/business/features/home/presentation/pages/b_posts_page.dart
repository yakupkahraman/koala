import 'package:flutter/material.dart';

class BPostsPage extends StatelessWidget {
  const BPostsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('İş İlanlarım')),
      body: const Center(
        child: Text('Bu sayfa iş ilanlarınızı göstermek için tasarlandı.'),
      ),
    );
  }
}
