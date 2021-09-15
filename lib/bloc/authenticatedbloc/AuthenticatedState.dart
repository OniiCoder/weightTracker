import 'package:super_enum/super_enum.dart';

part 'AuthenticatedState.super.dart';

@superEnum
enum _AuthenticatedState {
  @object
InitialState,
@object
UserAuthenticated,
@object
UserNotAuthenticated,
}