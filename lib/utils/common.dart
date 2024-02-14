import 'package:uuid/uuid.dart';

class CommonUtil {
  static const Uuid _uuid = Uuid();

  static String generateRandomId() {
    return _uuid.v4();
  }
}
