import 'package:image_compression_flutter/image_compression_flutter.dart';
import 'package:flimer/flimer.dart' as fl;

class PhotoUtils {
  static Configuration config = Configuration(
    outputType: ImageOutputType.jpg,
    useJpgPngNativeCompressor: true, //flag ?? false,
    quality: 60,
  );
  static imajvarmi(List<ImageFile> images) {
    if (images.isEmpty) {
      return false;
    } else {
      return true;
    }
  }

  static Future<List<ImageFile>> handleOpenGallery({bool istwo}) async {

    List<ImageFile> images = [];
    List<ImageFile> imageOutputs = [];
    ImageFile ornima;
    final List<XFile> xFiles =
        await fl.flimer.pickImages(); //(source: fl.ImageSource.gallery);
    print("bbb");
    if (xFiles != null && xFiles.isNotEmpty) {
      istwo != null ? () {} : images = [];
      for (XFile i in xFiles) {
        final c = await i.asImageFile;
        ornima = c;

        images.add(ornima);

      }

      return images;
    } else {
      return [];
    }
  }

  static Future<List<ImageFile>> handleCompressImage(
      List<ImageFile> images) async {
    List<ImageFile> imageOutputs = [];
    for (ImageFile i in images) {
      final param = ImageFileConfiguration(input: i, config: PhotoUtils.config);

      final output = await compressor.compress(param);

      imageOutputs.add(output);
    }
    return imageOutputs;
  }
}
