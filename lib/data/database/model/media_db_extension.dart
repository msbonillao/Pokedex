import '../../../domain/models/media/image_media.dart';
import '../../../domain/models/media/media.dart';

extension MediaDatabaseExtension on Media {
  Map<String, dynamic> toDatabase() {
    return {
      'url': url,
    };
  }

  static Media? fromDatabase(Map<String, dynamic>? map) {
    if (map == null) return null;
    return ImageMedia(map['url']);
  }
}
