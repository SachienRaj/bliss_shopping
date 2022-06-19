import 'package:bliss_shopping/modules/product/model/product.dart';
import 'package:bliss_shopping/modules/product/screen/product_page.dart';
import 'package:bliss_shopping/utils/palette.dart';
import 'package:bliss_shopping/utils/spacing.dart';
import 'package:flutter/material.dart';
import 'package:like_button/like_button.dart';

class CategoryPage extends StatefulWidget {
  const CategoryPage(
      {Key? key, required this.products, required this.categoryName})
      : super(key: key);

  final List<Product> products;
  final String categoryName;

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Spacing(
                height: getHeight(context) * 0.05,
              ),
              Row(
                children: [
                  IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(
                        Icons.arrow_back,
                        color: Palette.textColor,
                      )),
                  Spacing(
                    width: 10,
                  ),
                  Text(
                    widget.categoryName,
                    textAlign: TextAlign.left,
                    style: const TextStyle(
                        color: Palette.textColor,
                        fontSize: 25,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              Spacing(
                height: 20,
              ),
              _buildCategoryList(context, widget.products)
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCategoryList(BuildContext context, List<Product> products) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 15.0,
      ),
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      shrinkWrap: true,
      physics: const ClampingScrollPhysics(),
      itemCount: products.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => ProductPage(
                      pageColor: index.floor().isEven
                          ? Palette.pageColor
                          : Palette.pageColor2,
                      product: products[index],
                    )));
          },
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 8.0),
            padding: const EdgeInsets.all(12.0),
            decoration: BoxDecoration(
                color: index.floor().isEven
                    ? Palette.pageColor
                    : Palette.pageColor2,
                borderRadius: const BorderRadius.all(Radius.circular(40))),
            child: Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      products[index].model.toString(),
                      textAlign: TextAlign.left,
                      style: const TextStyle(
                          color: Palette.textColor,
                          fontSize: 18,
                          fontWeight: FontWeight.w500),
                    ),
                    LikeButton(
                      likeBuilder: (bool isLiked) {
                        return Icon(
                          Icons.favorite,
                          color: isLiked ? Palette.red : Palette.white,
                        );
                      },
                    )
                  ],
                ),
                Spacing(
                  height: 10,
                ),
                Image.network(
                  products[index].imageUrl.toString(),
                  cacheHeight: 90,
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
