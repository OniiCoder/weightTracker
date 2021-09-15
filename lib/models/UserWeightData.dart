
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:weight_tracker/models/UserWeightEntity.dart';

class UserWeightData {
  final id;
  final String userId;
  int weight;
  final Timestamp timestamp;

  UserWeightData({this.id, this.userId, this.weight, this.timestamp});

  factory UserWeightData.fromJson(Map<String, dynamic> json) => UserWeightData(
    id: json['id'],
    userId: json['userId'],
    weight: json['weight'],
    timestamp: json['createdAt'],
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'userId': userId,
    'weight': weight,
    'createdAt': timestamp,
  };

  UserWeightEntity toEntity() {
    return UserWeightEntity(
      id: id,
      weight: weight,
      userId: userId,
      timestamp: timestamp
    );
  }

  static UserWeightData fromEntity(UserWeightEntity entity) {
    return UserWeightData(
      id: entity.id,
      userId: entity.userId,
      weight: entity.weight,
      timestamp: entity.timestamp,
    );
  }

}