import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:shimmer/shimmer.dart';

class OnlineImage extends StatefulWidget {
  OnlineImage({
    Key? key,
    required String imageUrl,
    required double width,
  })  : _imageUrl = imageUrl,
        _width = width,
        super(key: key);

  final String _imageUrl;
  final double _width;

  @override
  State<OnlineImage> createState() => _OnlineImageState();
}

class _OnlineImageState extends State<OnlineImage> {
  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: widget()._imageUrl,
      placeholder: (context, url) {
        return Shimmer.fromColors(
          baseColor: Colors.grey[300]!,
          highlightColor: Colors.grey[100]!,
          child: Container(
            width: widget()._width,
            color: Colors.grey[300],
          ),
        );
      },
      errorWidget: (context, url, error) {
        return Icon(Icons.error);
      },
    );
  }
}
