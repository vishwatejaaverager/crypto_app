import 'package:crypto_app/models/crypto_currency.dart';
import 'package:crypto_app/providers/market_provider.dart';
import 'package:crypto_app/providers/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  Widget build(BuildContext context) {
    ThemeProvider themeProvider =
        Provider.of<ThemeProvider>(context, listen: false);
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding:
              const EdgeInsets.only(top: 20, left: 20, right: 20, bottom: 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Welcome Back ",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Crypto Today ",
                    style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                  ),
                  IconButton(
                      padding: EdgeInsets.all(0),
                      onPressed: () {
                        themeProvider.toggleTheme();
                      },
                      icon: (themeProvider.themeMode==ThemeMode.light) ?Icon(Icons.dark_mode) :  Icon(Icons.light_mode)), 
                ],
              ),
              Expanded(child: Consumer<MarketProvider>(
                builder: (context, marketProvider, child) {
                  if (marketProvider.isLoading == true) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else {
                    if (marketProvider.markets.isNotEmpty) {
                      return ListView.builder(
                          physics: const BouncingScrollPhysics(
                              parent: AlwaysScrollableScrollPhysics()),
                          itemCount: marketProvider.markets.length,
                          itemBuilder: (context, index) {
                            CryptoCurrency cryptoCurrency =
                                marketProvider.markets[index];
                            return ListTile(
                              contentPadding: const EdgeInsets.all(0),
                              leading: CircleAvatar(
                                backgroundColor: Colors.white,
                                backgroundImage:
                                    NetworkImage(cryptoCurrency.image!),
                              ),
                              title: Text(cryptoCurrency.name!),
                              subtitle:
                                  Text(cryptoCurrency.symbol!.toUpperCase()),
                              trailing: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    cryptoCurrency.currentPrice!
                                        .toStringAsFixed(4),
                                    style: const TextStyle(
                                        color: Color(0xff0395eb),
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18),
                                  ),
                                  Builder(builder: (context) {
                                    double priceChange =
                                        cryptoCurrency.priceChange24!;
                                    double priceChangePercentage =
                                        cryptoCurrency.priceChangePercentage24!;

                                    if (priceChange < 0) {
                                      return Text(
                                        "${priceChangePercentage.toStringAsFixed(2)} % (${priceChange.toStringAsFixed(4)})",
                                        style:
                                            const TextStyle(color: Colors.red),
                                      );
                                    } else {
                                      return Text(
                                        "${priceChangePercentage.toStringAsFixed(2)} % (${priceChange.toStringAsFixed(4)})",
                                        style: const TextStyle(
                                            color: Colors.green),
                                      );
                                    }
                                  })
                                ],
                              ),
                            );
                          });
                    } else {
                      return Text("no data");
                    }
                  }
                },
              ))
            ],
          ),
        ),
      ),
    );
  }
}
