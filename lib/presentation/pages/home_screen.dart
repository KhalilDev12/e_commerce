import 'package:carousel_slider/carousel_slider.dart';
import 'package:e_commerce/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../business_logic/blocs/category/category_bloc.dart';
import '../../business_logic/blocs/product/product_bloc.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: "Zero to unicorn"),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildCarouselSlider(),
            const SectionTitle(title: "RECOMMENDED"),
            // Recommended Products Carousel
            BlocBuilder<ProductBloc, ProductState>(
              builder: (context, state) {
                if (state is ProductLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is ProductLoaded) {
                  return ProductsCarousel(
                    products: state.products
                      ..where((product) => product.isRecommended).toList(),
                  );
                } else {
                  return const Center(child: Text("Something happen"));
                }
              },
            ),
            const SectionTitle(title: "MOST POPULAR"),
            // Most Popular Products Carousel
            BlocBuilder<ProductBloc, ProductState>(
              builder: (context, state) {
                if (state is ProductLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is ProductLoaded) {
                  return ProductsCarousel(
                    products: state.products
                      ..where((product) => product.isPopular).toList(),
                  );
                } else {
                  return const Center(child: Text("Something happend"));
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCarouselSlider() {
    return BlocBuilder<CategoryBloc, CategoryState>(
      builder: (context, state) {
        if (state is CategoryLoading) {
          return CarouselSlider(
              options: CarouselOptions(
                aspectRatio: 1.5,
                enlargeCenterPage: true,
                enlargeStrategy: CenterPageEnlargeStrategy.height,
                //enableInfiniteScroll: false,
                //autoPlay: true,
              ),
              items: [HeroCarouselCard(isLoading: true)]);
        } else if (state is CategoryLoaded) {
          return CarouselSlider(
            options: CarouselOptions(
              aspectRatio: 1.5,
              enlargeCenterPage: true,
              enlargeStrategy: CenterPageEnlargeStrategy.height,
              //enableInfiniteScroll: false,
              //autoPlay: true,
            ),
            items: state.categories
                .map((category) => HeroCarouselCard(category: category))
                .toList(),
          );
        } else {
          return const Center(child: Text("There is an error"));
        }
      },
    );
  }
}
