
import 'package:flutter_task/events/stage_event.dart';

import 'package:flutter_task/models/stageModel.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class StageBloc extends Bloc<StageEvent, List<String>> {//input event  ...output list
  @override
  List<String> get initialState => List<String>();//emptylist..init

  @override
  Stream<List<String>> mapEventToState(StageEvent event) async* {
    switch (event.eventType) {
      case EventType.add:
        List<String> newState = List.from(state);
        if (event.stage != null) {
          newState.add(event.stage);
        }
        yield newState;
        break;
      case EventType.delete:
        List<String> newState = List.from(state);
        print(newState.length);
        newState.removeAt(event.stageIndex);
        yield newState;
        break;
      default:
        throw Exception('Event not found $event');
    }
  }
}
