import 'package:bliss_shopping/modules/product/model/product.dart';
import 'package:bliss_shopping/modules/product/screen/product_page.dart';
import 'package:bliss_shopping/utils/palette.dart';
import 'package:flutter/material.dart';

class ProductSearchDelegate extends SearchDelegate {
  ProductSearchDelegate({required this.models, required this.products});

  final List<String> models;
  final List<Product> products;

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.close),
        onPressed: () {
          if (query.isEmpty) {
            close(context, null);
          } else {
            query = '';
          }
        },
      )
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final List<String> allResults = models
        .where((model) => model.toLowerCase().contains(query.toLowerCase()))
        .toList();

    return ListView.builder(
        itemCount: allResults.length,
        itemBuilder: (context, index) => ListTile(
              title: Text(allResults[index]),
              onTap: () {
                Product product = Product();
                for (Product element in products) {
                  if (element.model == allResults[index]) {
                    product = element;
                  }
                }
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => ProductPage(
                          pageColor: index.floor().isEven
                              ? Palette.pageColor
                              : Palette.pageColor2,
                          product: product,
                        )));
              },
            ));
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<String> suggestions = models
        .where((searchResult) =>
            searchResult.toLowerCase().contains(query.toLowerCase()))
        .toList();

    return ListView.builder(
        itemCount: suggestions.length,
        itemBuilder: (context, index) {
          final suggestion = suggestions[index];

          return ListTile(
            title: Text(suggestion),
            onTap: () {
              Product product = Product();
              for (Product element in products) {
                if (element.model == suggestion) {
                  product = element;
                }
              }
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => ProductPage(
                        pageColor: index.floor().isEven
                            ? Palette.pageColor
                            : Palette.pageColor2,
                        product: product,
                      )));
            },
          );
        });
  }
}
