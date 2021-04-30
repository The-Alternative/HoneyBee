
import 'package:flutter_task/models/stageModel.dart';

enum EventType { add, delete }

class StageEvent {
  String stage;
  int stageIndex;
  EventType eventType;

  StageEvent.add(String stage) {
    this.eventType = EventType.add;
    this.stage = stage;
  }

  StageEvent.delete(int index) {
    this.eventType = EventType.delete;
    this.stageIndex = index;
  }
}
