import 'package:super_enum/super_enum.dart';

part 'CrudState.super.dart';

@superEnum
enum _CrudState {
  @object
InitialState,
@object
AddWeightLoading,
@object
AddWeightSuccessful,
@Data(fields: [DataField<String>('error')])
AddWeightFailed,

@object
UpdateWeightLoading,
@object
UpdateWeightSuccessful,
@Data(fields: [DataField<String>('error')])
UpdateWeightFailed,

@object
DeleteWeightLoading,
@object
DeleteWeightSuccessful,
@Data(fields: [DataField<String>('error')])
DeleteWeightFailed,
}