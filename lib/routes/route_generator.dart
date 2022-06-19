import 'package:bliss_shopping/main.dart';
import 'package:bliss_shopping/modules/cart/screen/cart_page.dart';
import 'package:bliss_shopping/modules/home/screen/category_page.dart';
import 'package:bliss_shopping/modules/home/screen/home_page.dart';
import 'package:bliss_shopping/modules/product/model/product.dart';
import 'package:bliss_shopping/modules/product/screen/product_page.dart';
import 'package:flutter/material.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;

    switch (settings.name) {
      case RoutePaths.splashScreen:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case RoutePaths.homePage:
        return MaterialPageRoute(builder: (_) => const HomePage());
      case RoutePaths.cartPage:
        return MaterialPageRoute(builder: (_) => const CartPage());
      case RoutePaths.categoryPage:
        return MaterialPageRoute(
            builder: (_) => CategoryPage(
                products: args as List<Product>, categoryName: args as String));
      case RoutePaths.productPage:
        return MaterialPageRoute(
            builder: (_) => ProductPage(
                product: args as Product, pageColor: args as Color));
      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Error'),
        ),
        body: const Center(
          child: Text('ERROR'),
        ),
      );
    });
  }
}

class RoutePaths {
  static const String splashScreen = '/';
  static const String homePage = '/home';
  static const String categoryPage = '/category';
  static const String productPage = '/product';
  static const String cartPage = '/cart';
}
