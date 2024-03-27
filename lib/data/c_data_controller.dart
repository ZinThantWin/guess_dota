import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dota_guess_the_hero/data/m_data_model.dart';
import 'package:get/get.dart';

import '../utils/gobal_functions.dart';

class DataController extends GetxController {
  DataModel? model;

  final FirebaseFirestore fireStore = FirebaseFirestore.instance;

  Future<void> getData() async {
    DocumentSnapshot documentSnapshot =
        await fireStore.collection("classic_leaderboards").doc("001").get();
    var data = documentSnapshot.data() as Map<String, dynamic>;
    superPrint(data);
  }
}
