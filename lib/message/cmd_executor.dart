import 'package:basic_engine/common/login_control.dart';

const MANDATORY_OFFLINE = 'MandatoryOffline';

class CmdExecutor {
  static execute(String cmd) {
    if (MANDATORY_OFFLINE == cmd) {
      LoginControl.getInstance().logOut();
    }
  }
}
