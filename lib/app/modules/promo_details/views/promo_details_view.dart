import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../global_variable/global_variable.dart';
import '../controllers/promo_details_controller.dart';

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
                          return ListTile(
                            title: Text(promo.product_name),
                            subtitle: Text(promo.price.toString()),
                          );
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
