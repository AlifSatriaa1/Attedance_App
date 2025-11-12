import 'package:attendance_app/utils/face detection/vision.dart';

// Face recognition using Google ML Kit
class GoogleMlKit {
  GoogleMlKit._();

  static final Vision vision = Vision.instance;
}