import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:jollibee/app/models/product_promos_model.dart';
import 'package:jollibee/app/utils/parallax_flow_delegate.dart';

import '../../../global_variable/global_variable.dart';
import '../controllers/promo_details_controller.dart';

// class PromoDetailsView extends StatefulWidget {
//   const PromoDetailsView({super.key});

//   @override
//   State<PromoDetailsView> createState() => _PromoDetailsViewState();
// }

// class _PromoDetailsViewState extends State<PromoDetailsView> {
//   final controller = Get.put(PromoDetailsController());
//   void onlistenerController() {
//     setState(() {});
//   }

//   @override
//   void initState() {
//     controller.scrollController.addListener(onlistenerController);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('PromoDetailsView'),
//         centerTitle: true,
//       ),
//       body: Obx(
//         () => promos.isEmpty
//             ? CircularProgressIndicator()
//             : Column(
//                 children: [
//                   Expanded(
//                     child: ListView.separated(
//                         padding: const EdgeInsets.all(12),
//                         controller: controller.scrollController,
//                         itemBuilder: (context, index) {
//                           final promo = promos[index];

//                           final itemOffSet = index * 200;
//                           final difference =
//                               controller.scrollController.offset - itemOffSet;
//                           final percent = 1 - (difference / (200 / 2));
//                           double opacity = percent;
//                           double scale = percent;

//                           if (opacity > 1.0) opacity = 1.0;
//                           if (opacity < 0.0) opacity = 0.0;
//                           if (scale > 1.0) scale = 1.0;
//                           return Opacity(
//                             opacity: opacity,
//                             child:
//                                 // ConstrainedBox(
//                                 //   constraints: BoxConstraints(
//                                 //     maxWidth: MediaQuery.of(context).size.width,
//                                 //     maxHeight: 200,
//                                 //   ),
//                                 Transform(
//                               alignment: Alignment.topCenter,
//                               transform: Matrix4.identity()..scale(scale, 1.0),
//                               child: ConstrainedBox(
//                                 constraints: BoxConstraints(
//                                   maxWidth: MediaQuery.of(context).size.width,
//                                   maxHeight: 200,
//                                 ),
//                                 child: CachedNetworkImage(
//                                   imageUrl: promo
//                                       .image_url, // Replace with your image URL
//                                   placeholder: (context, url) => Center(
//                                     child: SizedBox(
//                                         height: 50,
//                                         width: 50,
//                                         child: CircularProgressIndicator()),
//                                   ),
//                                   errorWidget: (context, url, error) =>
//                                       Icon(Icons.error),
//                                   fit: BoxFit.cover,
//                                 ),
//                               ),
//                             ),
//                           );
//                           // return ListTile(
//                           //   leading: CachedNetworkImage(
//                           //     imageUrl: promo.image_url,
//                           //     fit: BoxFit.cover,
//                           //     placeholder: (context, url) =>
//                           //         CircularProgressIndicator(),
//                           //     errorWidget: (context, url, error) =>
//                           //         Icon(Icons.error),
//                           //   ),
//                           //   title: Text(promo.product_name),
//                           //   subtitle: Text(promo.price.toString()),
//                           // );
//                         },
//                         separatorBuilder: (context, index) =>
//                             const SizedBox(height: 10),
//                         itemCount: promos.length),
//                   ),
//                 ],
//               ),
//       ),
//     );
//   }
// }

class PromoDetailsView extends GetView<PromoDetailsController> {
  const PromoDetailsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(PromoDetailsController());
    return Scaffold(
      appBar: AppBar(
        title: const Text('PromoDetailsView'),
        centerTitle: true,
      ),
      body: Obx(
        () => promos.isEmpty
            ? CircularProgressIndicator()
            : Column(
                children: [
                  Expanded(
                    child: ListView.separated(
                        padding: const EdgeInsets.all(12),
                        controller: controller.scrollController,
                        itemBuilder: (context, index) {
                          final promo = promos[index];

                          return detailsPromoList(
                            controller: controller,
                            promo: promo,
                          );
                          // return ListTile(
                          //   leading: CachedNetworkImage(
                          //     imageUrl: promo.image_url,
                          //     fit: BoxFit.cover,
                          //     placeholder: (context, url) =>
                          //         CircularProgressIndicator(),
                          //     errorWidget: (context, url, error) =>
                          //         Icon(Icons.error),
                          //   ),
                          //   title: Text(promo.product_name),
                          //   subtitle: Text(promo.price.toString()),
                          // );
                        },
                        separatorBuilder: (context, index) =>
                            const SizedBox(height: 10),
                        itemCount: promos.length),
                  ),
                ],
              ),
      ),
    );
  }
}

class detailsPromoList extends StatelessWidget {
  const detailsPromoList({
    super.key,
    required this.controller,
    required this.promo,
  });

  final PromoDetailsController controller;
  final Promo promo;

  @override
  Widget build(BuildContext context) {
    final GlobalKey backgroundImageKey = GlobalKey();
    return ClipRRect(
      borderRadius: BorderRadius.circular(20.0),
      child: AspectRatio(
        aspectRatio: 16 / 9,
        child: Flow(
          delegate: ParallaxFlowDelegate(
            /// Access the scrollable widget
            scrollable: Scrollable.of(context),

            // Context of the list item
            listItemContext: context,

            // Pass the background image key
            backgroundImageKey: backgroundImageKey,
          ),
          // Apply anti-aliasing to the clipping
          clipBehavior: Clip.antiAlias,
          children: [
            CachedNetworkImage(
              key: backgroundImageKey,
              imageUrl: promo.image_url,
              placeholder: (context, url) => Center(
                child: SizedBox(
                    height: 50, width: 50, child: CircularProgressIndicator()),
              ),
              errorWidget: (context, url, error) => Icon(Icons.error),
              fit: BoxFit.cover,
            ),
          ],
        ),
      ),
    );
  }
}
