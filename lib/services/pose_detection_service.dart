import 'package:google_mlkit_pose_detection/google_mlkit_pose_detection.dart';

class PoseDetectionService {
  PoseDetectionService()
      : _poseDetector = PoseDetector(options: PoseDetectorOptions(mode: PoseDetectionMode.stream));

  final PoseDetector _poseDetector;

  Future<List<Pose>> processFrame(InputImage image) {
    return _poseDetector.processImage(image);
  }

  Future<void> dispose() async {
    await _poseDetector.close();
  }
}

