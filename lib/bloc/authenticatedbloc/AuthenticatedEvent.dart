import 'package:super_enum/super_enum.dart';

part 'AuthenticatedEvent.super.dart';

@superEnum
enum _AuthenticatedEvent {
@object
CheckAuthentication,
@object
Authenticate,
@object
UnAuthenticate
}