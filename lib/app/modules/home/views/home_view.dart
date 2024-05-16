import 'package:animate_do/animate_do.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import 'package:get/get.dart';
import 'package:jollibee/app/models/product_promos_model.dart';
import 'package:jollibee/app/routes/app_pages.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(HomeController());
    var size = MediaQuery.of(context).size;
    var textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('HomeView'),
        centerTitle: true,
        leading: IconButton(
          icon: Text('Add'),
          onPressed: () async {
            controller.addPromo();
          },
        ),
      ),
      body: SizedBox(
        width: size.width,
        height: size.height,
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              FadeInUp(
                delay: const Duration(milliseconds: 300),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RichText(
                        text: TextSpan(
                          text: "Find your favorite",
                          style: textTheme.bodyLarge,
                          children: [
                            TextSpan(
                              text: " Food",
                              style: textTheme.bodySmall?.copyWith(
                                color: Colors.orange,
                                fontSize: 40,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      RichText(
                        text: const TextSpan(
                          text: "Be more beautiful with our ",
                          style: TextStyle(
                            color: Color.fromARGB(186, 0, 0, 0),
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                          ),
                          children: [
                            TextSpan(
                              text: "promos :)",
                              style: TextStyle(
                                color: Colors.orange,
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              /// Body Slider
              FadeInUp(
                delay: const Duration(milliseconds: 550),
                child: Container(
                  margin: const EdgeInsets.only(top: 10),
                  width: size.width,
                  height: size.height * 0.40,
                  child: Obx(() => PageView.builder(
                        controller: controller.pageController,
                        itemCount: controller.productList.length,
                        physics: const BouncingScrollPhysics(),
                        onPageChanged: (int index) {
                          controller.currentIndex.value = index;
                        },
                        itemBuilder: (context, index) {
                          return Column(
                            children: [
                              view(index, textTheme, size),
                            ],
                          );
                        },
                      )),
                ),
              ),
              Obx(() => Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      controller.productList.length,
                      (index) => AnimatedContainer(
                        duration: Duration(seconds: 1),
                        curve: Curves.easeInOutQuint,
                        margin: EdgeInsets.all(4),
                        height: controller.currentIndex.value == index ? 12 : 8,
                        width: controller.currentIndex.value == index ? 12 : 8,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: controller.currentIndex.value == index
                              ? Colors.red
                              : Colors.black,
                          boxShadow: const [
                            BoxShadow(
                              offset: Offset(0, 4),
                              blurRadius: 4,
                              color: Color.fromARGB(61, 0, 0, 0),
                            )
                          ],
                        ),
                      ),
                    ),
                  )),

              SizedBox(
                height: 10,
              ),

              /// Most Popular Text
              FadeInUp(
                delay: const Duration(milliseconds: 650),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 8.0, vertical: 5.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        splashColor: Colors.blue.withOpacity(0.5),
                        onTap: () {},
                        child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Text(
                            "Most Popular",
                            style: textTheme.bodySmall?.copyWith(
                              color: Colors.orange,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      InkWell(
                        splashColor: Colors.blue.withOpacity(0.5),
                        onTap: () {
                          Get.toNamed(AppPages.PROMO_DETAILS);
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Text(
                            "See all",
                            style: textTheme.bodySmall?.copyWith(
                              color: Colors.orange,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              /// Most Popular Content
              FadeInUp(
                delay: const Duration(milliseconds: 750),
                child: Container(
                  margin: const EdgeInsets.only(top: 10.0),
                  padding: EdgeInsets.all(8),
                  width: size.width,
                  height: size.height * 1.28,
                  child: Obx(() => GridView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: controller.productList.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 10,
                        childAspectRatio: 0.55,
                      ),
                      itemBuilder: (context, index) {
                        final data = controller.productList[index];

                        return InkWell(
                          splashColor: Colors.blue.withOpacity(0.5),
                          onTap: () {},
                          child: Column(
                            children: [
                              Ink(
                                width: size.width * 0.5,
                                height: size.height * 0.3,
                                //margin: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(3),
                                  image: DecorationImage(
                                    image: CachedNetworkImageProvider(
                                        data.image_url),
                                    fit: BoxFit.cover,
                                  ),
                                  boxShadow: const [
                                    BoxShadow(
                                      offset: Offset(0, 4),
                                      blurRadius: 4,
                                      color: Color.fromARGB(61, 0, 0, 0),
                                    )
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 2.0),
                                child: Text(
                                  data.product_name,
                                  style: textTheme.bodyMedium,
                                ),
                              ),
                              RichText(
                                  text: TextSpan(
                                      text: "€",
                                      style: textTheme.bodyMedium?.copyWith(
                                        color: Colors.blue,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      children: [
                                    TextSpan(
                                      text: data.price.toString(),
                                      style: textTheme.subtitle2?.copyWith(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    )
                                  ])),
                            ],
                          ),
                        );
                      })),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Page View
  Widget view(int index, TextTheme theme, Size size) {
    return AnimatedBuilder(
        animation: controller.pageController,
        builder: (context, child) {
          double value = 0.0;
          if (controller.pageController.position.haveDimensions) {
            value = index.toDouble() - (controller.pageController.page ?? 0);
            value = (value * 0.04).clamp(-1, 1);
          }
          return Transform.rotate(
            angle: 3.14 * value,
            child: card(controller.productList[index], theme, size),
          );
        });
  }

  /// Page view Cards
  Widget card(Promo data, TextTheme theme, Size size) {
    return Padding(
      padding: const EdgeInsets.only(top: 15.0),
      child: Column(
        children: [
          InkWell(
            splashColor: Colors.blue.withOpacity(0.5),
            onTap: () {},
            child: Hero(
              tag: data.id,
              child: Ink(
                width: size.width * 0.6,
                height: size.height * 0.27,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(3),
                  image: DecorationImage(
                    image: CachedNetworkImageProvider(data.image_url),
                    fit: BoxFit.cover,
                  ),
                  boxShadow: const [
                    BoxShadow(
                        offset: Offset(0, 4),
                        blurRadius: 4,
                        color: Color.fromARGB(61, 0, 0, 0))
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child: Text(
              data.product_name,
              style: theme.bodyMedium,
            ),
          ),
          RichText(
            text: TextSpan(
              text: "€",
              style: theme.bodyMedium?.copyWith(
                color: Colors.blue,
                fontSize: 26,
                fontWeight: FontWeight.bold,
              ),
              children: [
                TextSpan(
                  text: data.price.toString(),
                  style: theme.subtitle2
                      ?.copyWith(fontWeight: FontWeight.w600, fontSize: 25),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
