import 'package:flutter/material.dart';
import 'package:koala/employee/features/home/presentation/providers/page_provider.dart';
import 'package:koala/product/theme/theme_provider.dart';
import 'package:koala/product/my_app.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(create: (_) => PageProvider()),
      ],
      child: MyApp(),
    ),
  );
}
