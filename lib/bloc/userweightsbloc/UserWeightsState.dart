
import 'package:super_enum/super_enum.dart';
import 'package:weight_tracker/models/UserWeightData.dart';

part 'UserWeightsState.super.dart';

@superEnum
enum _UserWeightsState {
@object
InitialState,
@object
FetchUserWeightsLoading,
@Data(fields: [DataField<List<UserWeightData>>('userWeights')])
FetchUserWeightsSuccessful,
@Data(fields: [DataField<String>('error')])
FetchUserWeightsFailed,

}