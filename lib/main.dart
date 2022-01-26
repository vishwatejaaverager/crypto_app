import 'package:crypto_app/constants/themes.dart';
import 'package:crypto_app/models/local_storage.dart';
import 'package:crypto_app/pages/homepage.dart';
import 'package:crypto_app/providers/market_provider.dart';
import 'package:crypto_app/providers/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  String currentT = await LocalStorage.getTheme() ?? "dark";
  runApp( MyApp(theme: currentT,));
}

class MyApp extends StatelessWidget {
  final String theme;
   MyApp({required this.theme});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<MarketProvider>(
          create: (context) => MarketProvider(),
        ),
        ChangeNotifierProvider<ThemeProvider>(
            create: (context) => ThemeProvider(theme))
      ],
      child: Consumer<ThemeProvider>(builder: (context, themeProvider, child) {
        return MaterialApp(
            title: 'Flutter Demo',
            debugShowCheckedModeBanner: false,
            themeMode: themeProvider.themeMode,
            theme: lightTheme,
            darkTheme: darkTheme,
            home: Homepage());
      }),
    );
  }
}
