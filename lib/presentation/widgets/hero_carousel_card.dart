import 'package:flutter/material.dart';

import '../../constants/strings.dart';
import '../../data/models/models.dart';

class HeroCarouselCard extends StatelessWidget {
  final CategoryModel? category;
  final ProductModel? product;
  final bool isLoading;

  HeroCarouselCard({
    Key? key,
    this.category,
    this.product,
    this.isLoading = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (product == null) {
          // if the product argument is null go to catalog page
          Navigator.of(context,rootNavigator: true).pushNamed(
            catalogScreen,
            arguments: category,
          );
        }
      },
      child: Container(
        margin: const EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 30,
        ),
        child: ClipRRect(
          borderRadius: const BorderRadius.all(Radius.circular(5.0)),
          child: isLoading
              ? const Center(child: CircularProgressIndicator())
              : Stack(
                  children: <Widget>[
                    Image.network(
                        product == null
                            ? category!.imageUrl
                            : product!.imageUrl,
                        fit: BoxFit.cover,
                        width: 1000.0,
                        height: 180),
                    Positioned(
                      bottom: 0.0,
                      left: 0.0,
                      right: 0.0,
                      child: Container(
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Color.fromARGB(200, 0, 0, 0),
                              Color.fromARGB(0, 0, 0, 0)
                            ],
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter,
                          ),
                        ),
                        padding: const EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 20.0),
                        child: Text(product == null ? category!.name : "",
                            style: Theme.of(context)
                                .textTheme
                                .displayMedium!
                                .copyWith(color: Colors.white)),
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
