
import 'package:cloud_firestore/cloud_firestore.dart';

class UserWeightEntity {
  final String id;
  final String userId;
  final int weight;
  final Timestamp timestamp;

  UserWeightEntity({this.id, this.userId, this.weight, this.timestamp});

  Map<String, Object> toJson() => {
    'id': id,
    'userId': userId,
    'weight': weight,
    'createdAt': timestamp,
  };

  static UserWeightEntity fromJson(Map<String, Object> json) {
    return UserWeightEntity(
      id: json['id'],
      userId: json['userId'],
      weight: json['weight'],
      timestamp: json['createdAt'],
    );
  }

  static UserWeightEntity fromSnapshot(DocumentSnapshot snap) {
    return UserWeightEntity(
      id: snap.reference.id,
      userId: snap.data()['userId'],
      weight: snap.data()['weight'],
      timestamp: snap.data()['createdAt'],
    );
  }

  Map<String, Object> toDocument() {
    return {
      'id': id,
      'userId': userId,
      'weight': weight,
      'createdAt': timestamp,
    };
  }
}