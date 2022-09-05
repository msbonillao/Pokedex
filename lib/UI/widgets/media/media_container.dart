import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:pokedex_flutter/domain/models/media/image_media.dart';
import 'package:pokedex_flutter/domain/models/models.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MediaContainer extends StatelessWidget {
  final Media? media;
  final BoxFit? fit;

  const MediaContainer({
    Key? key,
    required this.media,
    this.fit,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (media == null) return Container();
    if (media is ImageMedia) return _buildImageContainer();
    return Container();
  }

  Widget _buildImageContainer() {
    if (isSVG(media!.url!)) {
      return Padding(
        padding: EdgeInsets.all(0),
        child: SvgPicture.network(
          media!.url!,
          fit: fit ?? BoxFit.contain,
        ),
      );
    }
    return CachedNetworkImage(
      imageUrl: media!.url!,
      fit: fit,
      errorWidget: (context, _, __) => Container(),
    );
  }

  bool isSVG(String string) => string.endsWith('.svg');
}
