
import 'package:super_enum/super_enum.dart';
import 'package:weight_tracker/models/UserWeightData.dart';

part 'UserWeightsEvent.super.dart';

@superEnum
enum _UserWeightsEvent {
@object
FetchUserWeights,
@Data(fields: [DataField<List<UserWeightData>>('userWeights')])
RefreshUserWights,

}