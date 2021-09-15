import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:weight_tracker/models/UserWeightData.dart';
import 'package:weight_tracker/models/UserWeightEntity.dart';

class UserWeightRepo {
  final userWeightCollection = FirebaseFirestore.instance.collection('userWeights');

  Stream<List<UserWeightData>> userWeights() {

    return userWeightCollection.orderBy('createdAt', descending: true).snapshots().map((snapshot) {
      return snapshot.docs
          .map((doc) => UserWeightData.fromEntity(UserWeightEntity.fromSnapshot(doc)))
          .toList();
    });

  }

  Future<void> addNewWeight(UserWeightData userWeightData) {
    return userWeightCollection.add(userWeightData.toEntity().toDocument());
  }

  Future<void> updateWeight(UserWeightData userWeightData) {
    return userWeightCollection
        .doc(userWeightData.id)
        .update(userWeightData.toEntity().toDocument());
  }

  Future<void> deleteWeight(UserWeightData userWeightData) async {
    return userWeightCollection.doc(userWeightData.id).delete();
  }
}