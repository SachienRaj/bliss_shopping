import 'package:bliss_shopping/modules/cart/bloc/cart_bloc.dart';
import 'package:bliss_shopping/modules/cart/screen/cart_page.dart';
import 'package:bliss_shopping/modules/product/model/product.dart';
import 'package:bliss_shopping/utils/palette.dart';
import 'package:bliss_shopping/utils/spacing.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:like_button/like_button.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductPage extends StatefulWidget {
  const ProductPage({Key? key, required this.product, required this.pageColor})
      : super(key: key);

  final Product product;
  final Color pageColor;

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: widget.pageColor,
      body:
          Column(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Container(
          margin: const EdgeInsets.only(top: 30.0),
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(
                    Icons.arrow_back,
                    color: Palette.white,
                  )),
              Row(
                children: [
                  const Icon(
                    Icons.share,
                    color: Palette.white,
                  ),
                  Spacing(
                    width: 10.0,
                  ),
                  LikeButton(
                    likeBuilder: (bool isLiked) {
                      return Icon(
                        Icons.favorite,
                        color: isLiked ? Palette.red : Palette.white,
                      );
                    },
                  ),
                  IconButton(
                    icon: Stack(
                      children: [
                        const Align(
                          child: Icon(
                            Icons.shopping_cart,
                            color: Palette.white,
                          ),
                          alignment: Alignment.centerLeft,
                        ),
                        Align(
                            alignment: Alignment.topRight,
                            child: CircleAvatar(
                              radius: 8,
                              child: BlocBuilder<CartBloc, CartState>(
                                  builder: (context, state) {
                                Widget widget = Container();
                                if (state is CartLoaded) {
                                  widget = Text('${state.cart.products.length}',
                                      style: const TextStyle(
                                          fontSize: 11,
                                          fontWeight: FontWeight.bold));
                                }
                                return widget;
                              }),
                              backgroundColor: Colors.red,
                            ))
                      ],
                    ),
                    onPressed: () => Navigator.of(context).pushNamed('/cart'),
                  )
                ],
              ),
            ],
          ),
        ),
        SizedBox(
          height: getHeight(context) / 2.35,
          child: Image.network(
            widget.product.imageUrl.toString(),
          ),
        ),
        Container(
          width: getWidth(context),
          padding: const EdgeInsets.all(30.0),
          decoration: BoxDecoration(
              color: Palette.white.withOpacity(0.45),
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(40), topRight: Radius.circular(40))),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                widget.product.model.toString(),
                textAlign: TextAlign.left,
                style: const TextStyle(
                    color: Palette.textColor,
                    fontSize: 30,
                    fontWeight: FontWeight.w500),
              ),
              Spacing(
                height: 10,
              ),
              Table(
                children: [
                  TableRow(children: [
                    const Text("Brand",
                        style: TextStyle(
                            color: Palette.textColor,
                            fontSize: 20,
                            fontWeight: FontWeight.bold)),
                    Text(
                      widget.product.brand.toString(),
                      style: const TextStyle(
                          color: Palette.textColor, fontSize: 20),
                    ),
                  ]),
                  TableRow(children: [
                    const Text("Price",
                        style: TextStyle(
                            color: Palette.textColor,
                            fontSize: 20,
                            fontWeight: FontWeight.bold)),
                    Text(widget.product.price.toString(),
                        style: const TextStyle(
                            color: Palette.textColor, fontSize: 20)),
                  ]),
                  TableRow(children: [
                    const Text("Color",
                        style: TextStyle(
                            color: Palette.textColor,
                            fontSize: 20,
                            fontWeight: FontWeight.bold)),
                    Text(widget.product.colour.toString(),
                        style: const TextStyle(
                            color: Palette.textColor, fontSize: 20)),
                  ]),
                  TableRow(children: [
                    const Text("Weight",
                        style: TextStyle(
                            color: Palette.textColor,
                            fontSize: 20,
                            fontWeight: FontWeight.bold)),
                    Text(widget.product.weight.toString(),
                        style: const TextStyle(
                            color: Palette.textColor, fontSize: 20)),
                  ]),
                ],
              ),
              Spacing(
                height: 40,
              ),
              SizedBox(
                  height: 50,
                  width: getWidth(context),
                  child: ElevatedButton(
                    child: const Text("Add to Cart",
                        style: TextStyle(color: Palette.white, fontSize: 20.0)),
                    style: ElevatedButton.styleFrom(
                      elevation: 0,
                      primary: Palette.primaryColor,
                      onPrimary: Palette.white,
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                    ),
                    onPressed: () {
                      context.read<CartBloc>().add(AddProduct(widget.product));
                    },
                  )),
            ],
          ),
        ),
      ]),
    );
  }
}
