import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jollibee/app/models/product_promos_model.dart';
import 'package:jollibee/app/repositories/promo_repository.dart';

class HomeController extends GetxController {
  //TODO: Implement HomeController

  final count = 0.obs;
  late PageController pageController;
  final currentIndex = 2.obs;

  final _promos = <Promo>[].obs;

  List<ProductPromosModel> mainList = [
    ProductPromosModel(
      imageUrl:
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRaaCCDZoZmI7mLdWOPozySjMZ2AQOWWuAt1A&s",
      name: "Casual Jeans Pant",
      price: 155.99,
      review: 3.6,
      star: 4.8,
      id: 1,
      value: 1,
    ),
    ProductPromosModel(
      imageUrl:
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTiN_2jFlNQrtCWjAY8xzgN46-QZDg1Ja6WxQ&s",
      name: "blue Coat",
      price: 143.99,
      review: 5.6,
      star: 5.0,
      id: 2,
      value: 1,
    ),
    ProductPromosModel(
      imageUrl:
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRaaCCDZoZmI7mLdWOPozySjMZ2AQOWWuAt1A&s",
      name: "Deep Green Jacket",
      price: 212.99,
      review: 2.6,
      star: 3.7,
      id: 3,
      value: 1,
    ),
    ProductPromosModel(
      imageUrl:
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRaaCCDZoZmI7mLdWOPozySjMZ2AQOWWuAt1A&s",
      name: "Orange Shirt",
      price: 432.99,
      review: 1.4,
      star: 2.4,
      id: 4,
      value: 1,
    ),
    ProductPromosModel(
      imageUrl:
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRaaCCDZoZmI7mLdWOPozySjMZ2AQOWWuAt1A&s",
      name: "Grey Pullover",
      price: 112.99,
      review: 4.2,
      star: 1.8,
      id: 5,
      value: 1,
    ),
    ProductPromosModel(
      imageUrl:
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRaaCCDZoZmI7mLdWOPozySjMZ2AQOWWuAt1A&s",
      name: "Pullover Sleeveless",
      price: 320.99,
      review: 2.1,
      star: 3.1,
      id: 6,
      value: 1,
    ),
    ProductPromosModel(
      imageUrl:
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRaaCCDZoZmI7mLdWOPozySjMZ2AQOWWuAt1A&s",
      name: "Black Coat",
      price: 113.99,
      review: 3.1,
      star: 4.8,
      id: 7,
      value: 1,
    ),
    ProductPromosModel(
      imageUrl:
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRaaCCDZoZmI7mLdWOPozySjMZ2AQOWWuAt1A&s",
      name: "White Shirt",
      price: 178.99,
      review: 2.6,
      star: 4.8,
      id: 8,
      value: 1,
    ),
  ];
  @override
  void onInit() {
    super.onInit();
    //_fetchPromos();
    pageController =
        PageController(initialPage: currentIndex.value, viewportFraction: 0.7);
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
    pageController.dispose();
  }

  Future<void> addPromo() async {
    List<Promo> promos = List.generate(
        24,
        (index) => Promo(
              id: "${index + 1}",
              product_name: 'Promo Name ${index + 1}',
              product_description: 'Description for Promo ${index + 1}',
              image_url:
                  'https://source.unsplash.com/random/200x200?sig=${index + 1}',
              price: (Random().nextDouble() * 100).roundToDouble(),
            ));

    // Add each promo to Firestore
    for (var promo in promos) {
      await PromoRepository.addPromoToFirestore(promo);
    }
    // Promo promo = Promo(
    //   id: "1",
    //   name: 'Sample Promo',
    //   description: 'This is a sample promo',
    //   imageUrl:
    //       'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTppztPxkqBejsx9Y30Z1x5a7zCHCGJnM4mUg&s',
    //   price: 119.99,
    // );

    // await PromoRepository.addPromoToFirestore(promo);
  }

  Future<void> _fetchPromos() async {
    try {
      final fetchedVisitors = await PromoRepository.fetchVisitors();

      fetchedVisitors.sort((a, b) => a.product_name.compareTo(b.product_name));
      _promos.addAll(fetchedVisitors);
    } on Exception catch (e) {
      print(e);
    } catch (e) {
      print(e);
    }
  }
}
