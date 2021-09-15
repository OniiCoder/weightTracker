
import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:weight_tracker/bloc/userweightsbloc/UserWeightsEvent.dart';
import 'package:weight_tracker/bloc/userweightsbloc/UserWeightsState.dart';
import 'package:weight_tracker/models/UserWeightData.dart';
import 'package:weight_tracker/repository/UserWeightRepo.dart';

class UserWeightsBloc extends Bloc<UserWeightsEvent, UserWeightsState> {
  UserWeightsBloc() : super(UserWeightsState.initialState());

  UserWeightRepo _userWeightRepo = UserWeightRepo();
  StreamSubscription _todosSubscription;

  @override
  Stream<UserWeightsState> mapEventToState(UserWeightsEvent event) async* {
    yield* event.when(
      fetchUserWeights: () => mapToFetchUserWeights(),
      refreshUserWights: (data) => mapToRefreshUserWeights(data.userWeights),
    );
  }

  Stream<UserWeightsState> mapToFetchUserWeights() async* {
    yield UserWeightsState.fetchUserWeightsLoading();

    _todosSubscription?.cancel();
    try {
      _todosSubscription = _userWeightRepo.userWeights().listen((userWeights) {
        // print(userWeights);
        add(UserWeightsEvent.refreshUserWights(userWeights: userWeights));
      });
    } catch (e) {
      yield UserWeightsState.fetchUserWeightsFailed(error: e.toString());
    }
  }

  Stream<UserWeightsState> mapToRefreshUserWeights(List<UserWeightData> userWeights) async* {
    yield UserWeightsState.fetchUserWeightsSuccessful(userWeights: userWeights);
  }



}