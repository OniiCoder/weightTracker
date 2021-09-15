
import 'package:bloc/bloc.dart';
import 'package:weight_tracker/bloc/crudbloc/CrudEvent.dart';
import 'package:weight_tracker/bloc/crudbloc/CrudState.dart';
import 'package:weight_tracker/models/UserWeightData.dart';
import 'package:weight_tracker/repository/UserWeightRepo.dart';

class CrudBloc extends Bloc<CrudEvent, CrudState> {
  CrudBloc() : super(CrudState.initialState());

  UserWeightRepo _userWeightRepo = UserWeightRepo();

  @override
  Stream<CrudState> mapEventToState(CrudEvent event) async* {
    yield* event.when(
      addWeight: (data) => mapToAddWeight(data.userWeight),
      updateWeight: (data) => mapToUpdateWeight(data.userWeight),
      deleteWeight: (data) => mapToDeleteWeight(data.userWeight)
    );
  }

  Stream<CrudState> mapToAddWeight(UserWeightData userWeightData) async* {
    yield CrudState.addWeightLoading();
    try {
      _userWeightRepo.addNewWeight(userWeightData);
    } catch (e) {
      yield CrudState.addWeightFailed(error: e.toString());
    }
  }

  Stream<CrudState> mapToUpdateWeight(UserWeightData userWeightData) async* {
    yield CrudState.updateWeightLoading();
    try {
      _userWeightRepo.updateWeight(userWeightData);
    } catch (e) {
      yield CrudState.updateWeightFailed(error: e.toString());
    }
  }

  Stream<CrudState> mapToDeleteWeight(UserWeightData userWeightData) async* {
    yield CrudState.deleteWeightLoading();
    try {
      _userWeightRepo.deleteWeight(userWeightData);
    } catch (e) {
      yield CrudState.deleteWeightFailed(error: e.toString());
    }
  }

}