import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:jollibee/app/models/product_promos_model.dart';

import '../firebase_instances/firebase_instance.dart';

class PromoRepository {
  // Add Promo data to Cloud Firestore
  static Future<void> addPromoToFirestore(Promo promo) async {
    try {
      // Access Firestore instance
      FirebaseFirestore firestore = FirebaseFirestore.instance;

      // Convert Promo object to Map
      Map<String, dynamic> promoMap = promo.toMap();

      // Add data to Firestore and get auto-generated ID
      DocumentReference documentRef =
          await firestore.collection('Promos').add(promoMap);

      // Save the auto-generated ID as the collection ID
      String docId = documentRef.id;
      await firestore.collection('Promos').doc(docId).update({'id': docId});

      print('Promo added to Firestore with ID: $docId');
    } catch (e) {
      print('Error adding promo to Firestore: $e');
    }
    // try {
    //   // Access Firestore instance
    //   FirebaseFirestore firestore = FirebaseFirestore.instance;

    //   // Convert Promo object to Map
    //   Map<String, dynamic> promoMap = promo.toMap();

    //   // Add data to Firestore
    //   await firestore.collection('Promos').add(promoMap);

    //   print('Promo added to Firestore successfully');
    // } catch (e) {
    //   print('Error adding promo to Firestore: $e');
    // }
  }

  static Future<List<Promo>> fetchVisitors() async {
    try {
      const limit = 10;
      final collectionRef = firestore.collection('Promos');

      Query query = collectionRef.orderBy('product_name').limit(limit);
      if (lastDocSnapshotVisitors != null) {
        query = query.startAfterDocument(lastDocSnapshotVisitors!);
      } else {
        query = query;
      }

      final result = await query.get();

      if (result.docs.isNotEmpty) {
        lastDocSnapshotVisitors = result.docs.last;
      }

      final promos = result.docs.map((doc) {
        final map = doc.data() as Map<String, dynamic>;
        return Promo.fromMap(map);
      }).toList();

      print('Success Data Response : ${promos.first.product_name}');

      return promos;
    } catch (_) {
      rethrow;
    }
  }
}
