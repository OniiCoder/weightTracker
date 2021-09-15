import 'package:super_enum/super_enum.dart';
import 'package:weight_tracker/models/UserWeightData.dart';

part 'CrudEvent.super.dart';

@superEnum
enum _CrudEvent {
@Data(fields: [DataField<UserWeightData>('userWeight')])
AddWeight,
@Data(fields: [DataField<UserWeightData>('userWeight')])
UpdateWeight,
@Data(fields: [DataField<UserWeightData>('userWeight')])
DeleteWeight
}