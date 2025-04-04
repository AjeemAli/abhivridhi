import 'package:hive/hive.dart';

part 'face_image_model.g.dart';

@HiveType(typeId: 0)
class FaceImage {
  @HiveField(0)
  final String imagePath;

  FaceImage(this.imagePath);
}
