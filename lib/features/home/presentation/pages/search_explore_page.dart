import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:koala/core/constants.dart';

class SearchExplorePage extends StatelessWidget {
  const SearchExplorePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 400),
            curve: Curves.easeInOut,
            width: MediaQuery.of(context).size.width - 50,
            height: 60,
            child: TextField(
              autofocus: true, // Sayfa açılınca otomatik focus
              decoration: InputDecoration(
                suffixIcon: Hero(
                  tag: 'search_button',
                  child: IconButton(
                    icon: const Icon(HugeIcons.strokeRoundedSearch01, size: 24),
                    style: ButtonStyle(
                      backgroundColor: WidgetStatePropertyAll(
                        ThemeConstants.primaryColor,
                      ),
                      padding: WidgetStatePropertyAll(EdgeInsets.all(8)),
                    ),
                    color: Colors.white,
                    onPressed: () {},
                  ),
                ),
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
        ],
      ),
    );
  }
}
