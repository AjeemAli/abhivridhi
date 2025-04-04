// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'face_image_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class FaceImageAdapter extends TypeAdapter<FaceImage> {
  @override
  final int typeId = 0;

  @override
  FaceImage read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return FaceImage(
      fields[0] as String,
    );
  }

  @override
  void write(BinaryWriter writer, FaceImage obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.imagePath);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FaceImageAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
