import 'package:uuid/uuid.dart';

class DataUtil {
  static makeFilePath(){
    return '${Uuid().v4}.jpg';
  }
}