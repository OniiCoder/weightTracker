import 'package:firebase_auth/firebase_auth.dart';
import 'package:super_enum/super_enum.dart';

part 'LoginState.super.dart';

@superEnum
enum _LoginState {
  @object
InitialState,
@object
LoginLoading,
@Data(fields: [DataField<User>('user')])
LoginSuccessful,
@Data(fields: [DataField<String>('error')])
LoginFailed,

@object
LogOutLoading,
@object
LogOutSuccessful,
@Data(fields: [DataField<String>('error')])
LogOutFailed,

}