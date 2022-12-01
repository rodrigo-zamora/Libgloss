import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:shimmer/shimmer.dart';

class OnlineImage extends StatelessWidget {

  OnlineImage({
    Key? key,
    required String imageUrl,
    required double height,
  })  : _imageUrl = imageUrl,
        _height = height,
        super(key: key);

  final String _imageUrl;
  final double _height;

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: _imageUrl,
      placeholder: (context, url) {
        return Shimmer.fromColors(
          baseColor: Colors.grey[300]!,
          highlightColor: Colors.grey[100]!,
          child: Container(
            height: _height,
            color: Colors.grey[300],
          ),
        );
      },
      imageBuilder: (context, imageProvider) => Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: imageProvider,
            fit: BoxFit.fitHeight,
          ),
        ),
      ),
      errorWidget: (context, url, error) {
        return Icon(Icons.error);
      },
    );
  }
}
