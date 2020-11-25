import 'package:linkup/app/config/push_notification/strategy/chatMessage_strategy.dart';
import 'package:linkup/app/config/push_notification/strategy/i_push_strategy.dart';
import 'package:linkup/app/config/push_notification/strategy/update_appointment_strategy.dart';

class PushNotificationFactory {
  IPushStrategy strategy;

  Map<String, dynamic> pushPayload;
  PushNotificationFactory.create(this.pushPayload) {
    switch (pushPayload["type"]) {
      case "updateAppointment":
        strategy = UpdateAppointmentStrategy();
        break;
      case "chatMessage":
        strategy = ChatMessageStrategy();
        break;
      default:
        throw Exception("Estrategia não implementada");
    }
  }

  void execute() {
    strategy.execut(pushPayload);
  }
}
