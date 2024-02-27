import 'package:carousel_slider/carousel_slider.dart';
import 'package:e_commerce/business_logic/blocs/cart/cart_bloc.dart';
import 'package:e_commerce/business_logic/blocs/wishlist/wishlist_bloc.dart';
import 'package:e_commerce/data/models/models.dart';
import 'package:e_commerce/data/models/product_cart_model.dart';
import 'package:e_commerce/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductScreen extends StatelessWidget {
  final ProductModel product;

  const ProductScreen({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: product.name),
      bottomNavigationBar: _buildBottomNavigationBar(context),
      body: ListView(
        children: [
          _buildCarouselSlider(),
          _buildProductNamePrice(context),
          _buildInformationWidget(context),
          _buildDeliveryWidget(context)
        ],
      ),
    );
  }

  CarouselSlider _buildCarouselSlider() {
    return CarouselSlider(
      options: CarouselOptions(
        aspectRatio: 1.5,
        enlargeCenterPage: true,
        enlargeStrategy: CenterPageEnlargeStrategy.height,
        //enableInfiniteScroll: false,
        //autoPlay: true,
      ),
      items: [HeroCarouselCard(product: product)],
    );
  }

  Padding _buildProductNamePrice(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Stack(
        children: [
          Container(
            height: 60,
            alignment: Alignment.bottomCenter,
            width: MediaQuery.of(context).size.width,
            color: Colors.black54,
          ),
          Container(
            height: 50,
            margin: EdgeInsets.all(5),
            color: Colors.black,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(product.name,
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge!
                          .copyWith(color: Colors.white)),
                  Text(product.price.toString(),
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge!
                          .copyWith(color: Colors.white)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Padding _buildDeliveryWidget(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: ExpansionTile(
        title: Text("Delivery information",
            style: Theme.of(context).textTheme.displaySmall),
        children: [
          ListTile(
            title: Text(
                "Lorem sq sfqsfqsgds sdgSDFQSDF SQDFQSDF?QSDNG?NSD?GN  ldjmlqjslmj sqlmg ljglmqsj lmjglqms jlm jgqsmldgj",
                style: Theme.of(context).textTheme.bodyLarge),
          )
        ],
      ),
    );
  }

  Padding _buildInformationWidget(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: ExpansionTile(
        title: Text("Product information",
            style: Theme.of(context).textTheme.displaySmall),
        children: [
          ListTile(
            title: Text(
                "Lorem sq sfqsfqsgds sdgSDFQSDF SQDFQSDF?QSDNG?NSD?GN  ldjmlqjslmj sqlmg ljglmqsj lmjglqms jlm jgqsmldgj",
                style: Theme.of(context).textTheme.bodyLarge),
          )
        ],
      ),
    );
  }

  BottomAppBar _buildBottomNavigationBar(BuildContext context) {
    return BottomAppBar(
      height: 70,
      color: Colors.black,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.share,
              color: Colors.white,
            ),
          ),
          BlocBuilder<WishlistBloc, WishlistState>(
            builder: (context, state) {
              return IconButton(
                onPressed: () {
                  // Add Product to WishList
                  context.read<WishlistBloc>().add(AddWishlistProduct(product));
                  const snackBar = SnackBar(
                    content: Text("Product added to WishList"),
                  );
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                },
                icon: const Icon(
                  Icons.favorite,
                  color: Colors.white,
                ),
              );
            },
          ),
          BlocBuilder<CartBloc, CartState>(
            builder: (context, state) {
              return ElevatedButton(
                style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                    backgroundColor: Colors.white),
                onPressed: () {
                  // Add Product to Cart
                  context.read<CartBloc>().add(AddCartProduct(product));
                  const snackBar = SnackBar(
                    content: Text("Product Added to Cart"),
                  );
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                },
                child: Text(
                  "Add To Cart",
                  style: Theme.of(context).textTheme.displaySmall,
                ),
              );
            },
          )
        ],
      ),
    );
  }
}
