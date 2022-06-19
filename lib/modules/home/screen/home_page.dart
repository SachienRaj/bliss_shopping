import 'package:bliss_shopping/api/response_model.dart';
import 'package:bliss_shopping/modules/home/screen/category_page.dart';
import 'package:bliss_shopping/modules/home/screen/search_page.dart';
import 'package:bliss_shopping/modules/product/bloc/product_bloc.dart';
import 'package:bliss_shopping/modules/product/model/product.dart';
import 'package:bliss_shopping/modules/product/screen/product_page.dart';
import 'package:bliss_shopping/utils/palette.dart';
import 'package:bliss_shopping/utils/spacing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:like_button/like_button.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<String> models = [];
  List<Product> products = [];

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
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "BLISS",
                    style: TextStyle(
                        color: Palette.primaryColor,
                        fontSize: 30,
                        fontWeight: FontWeight.bold),
                  ),
                  Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 8),
                      height: 60,
                      width: 60,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(80),
                        child: Image.asset(
                          "assets/images/profile_pic.jpg",
                          fit: BoxFit.cover,
                        ),
                      ),
                      decoration: const BoxDecoration(
                          color: Palette.pageColor, shape: BoxShape.circle))
                ],
              ),
              Spacing(
                height: 10,
              ),
              const Text(
                "Hello,",
                textAlign: TextAlign.left,
                style: TextStyle(
                  color: Palette.textColorLight,
                  fontSize: 20,
                ),
              ),
              Spacing(
                height: 20,
              ),
              const Text(
                "Sudesh Kumara",
                textAlign: TextAlign.left,
                style: TextStyle(
                    color: Palette.textColor,
                    fontSize: 25,
                    fontWeight: FontWeight.bold),
              ),
              Spacing(
                height: 30,
              ),
              _buildSearchBox(),
              Spacing(
                height: 30,
              ),
              const Text(
                "By Category",
                textAlign: TextAlign.left,
                style: TextStyle(
                    color: Palette.textColor,
                    fontSize: 20,
                    fontWeight: FontWeight.w500),
              ),
              Spacing(
                height: 20,
              ),
              _buildCategories(),
              Spacing(
                height: 20,
              ),
              const Text(
                "All Products",
                textAlign: TextAlign.left,
                style: TextStyle(
                    color: Palette.textColor,
                    fontSize: 20,
                    fontWeight: FontWeight.w500),
              ),
              Spacing(
                height: 10,
              ),
              _buildListProduct()
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSearchBox() {
    return BlocBuilder<ProductBloc, ProductState>(
      builder: (context, state) {
        models.clear();
        products.clear();
        if (state is ProductLoaded) {
          for (Product product in state.responseModel.products!) {
            models.add(product.model.toString());
            products.add(product);
          }
        }
        return GestureDetector(
          onTap: () {
            showSearch(
                context: context,
                delegate:
                    ProductSearchDelegate(models: models, products: products));
          },
          child: Container(
            height: 60.0,
            margin: const EdgeInsets.symmetric(vertical: 10.0),
            padding:
                const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
            decoration: BoxDecoration(
                border: Border.all(color: Palette.black.withOpacity(0.3)),
                color: Palette.white,
                borderRadius: const BorderRadius.all(Radius.circular(20))),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Search Your Model",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    color: Palette.textColorLight,
                    fontSize: 15,
                  ),
                ),
                Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      width: 50,
                      decoration: const BoxDecoration(
                          color: Palette.primaryColor,
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                    ),
                    const Icon(
                      Icons.search,
                      color: Palette.white,
                      size: 30,
                    ),
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }

  List<Product> filterByCategory(String category, List<Product> products) {
    List<Product> filtered = [];

    for (Product product in products) {
      if (product.category!.contains(category)) {
        filtered.add(product);
      }
    }

    return filtered;
  }

  Widget _buildCategories() {
    return BlocBuilder<ProductBloc, ProductState>(
      builder: (context, state) {
        List<Product> products = [];
        if (state is ProductLoaded) {
          products = state.responseModel.products!;
        }
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            GestureDetector(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => CategoryPage(
                          products: filterByCategory("guitar", products),
                          categoryName: "Guitar",
                        )));
              },
              child: Container(
                height: 60.0,
                width: 100.0,
                margin: const EdgeInsets.symmetric(vertical: 10.0),
                padding:
                    const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                decoration: BoxDecoration(
                    color: Palette.pink,
                    borderRadius: const BorderRadius.all(Radius.circular(20))),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SvgPicture.asset(
                      "assets/svg/guitar.svg",
                      height: 25.0,
                      color: Palette.white,
                    ),
                    const Text(
                      "Guitar",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        color: Palette.white,
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => CategoryPage(
                          products: filterByCategory("piano", products),
                          categoryName: "Piano",
                        )));
              },
              child: Container(
                height: 60.0,
                width: 100.0,
                margin: const EdgeInsets.symmetric(vertical: 10.0),
                padding:
                    const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                decoration: BoxDecoration(
                    color: Palette.yellow,
                    borderRadius: const BorderRadius.all(Radius.circular(20))),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SvgPicture.asset(
                      "assets/svg/piano.svg",
                      height: 25.0,
                      color: Palette.white,
                    ),
                    const Text(
                      "Piano",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        color: Palette.white,
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => CategoryPage(
                          products: filterByCategory("drums", products),
                          categoryName: "Drum",
                        )));
              },
              child: Container(
                height: 60.0,
                width: 100.0,
                margin: const EdgeInsets.symmetric(vertical: 10.0),
                padding:
                    const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                decoration: BoxDecoration(
                    color: Palette.green,
                    borderRadius: const BorderRadius.all(Radius.circular(20))),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SvgPicture.asset(
                      "assets/svg/drum.svg",
                      height: 25.0,
                      color: Palette.white,
                    ),
                    const Text(
                      "Drum",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        color: Palette.white,
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        );
      },
    );
  }

  Widget _buildListProduct() {
    return BlocListener<ProductBloc, ProductState>(
      listener: (context, state) {
        if (state is ProductError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message!),
            ),
          );
        }
      },
      child: BlocBuilder<ProductBloc, ProductState>(
        builder: (context, state) {
          if (state is ProductInitial) {
            return _buildLoading();
          }
          if (state is ProductLoading) {
            return _buildLoading();
          }
          if (state is ProductLoaded) {
            return _buildCard(context, state.responseModel);
          }
          if (state is ProductError) {
            return Container();
          } else {
            return Container();
          }
        },
      ),
    );
  }

  Widget _buildCard(BuildContext context, ResponseModel model) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 15.0,
      ),
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      shrinkWrap: true,
      physics: const ClampingScrollPhysics(),
      itemCount: model.products!.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => ProductPage(
                      pageColor: index.floor().isEven
                          ? Palette.pageColor
                          : Palette.pageColor2,
                      product: model.products![index],
                    )));
          },
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 8.0),
            padding: const EdgeInsets.all(12.0),
            decoration: BoxDecoration(
                color: index.floor().isEven
                    ? Palette.pageColor
                    : Palette.pageColor2,
                borderRadius: const BorderRadius.all(Radius.circular(20))),
            child: Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      model.products![index].model.toString(),
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
                Center(
                  child: Image.network(
                    model.products![index].imageUrl.toString(),
                    cacheHeight: 90,
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildLoading() => const Center(child: CircularProgressIndicator());
}
