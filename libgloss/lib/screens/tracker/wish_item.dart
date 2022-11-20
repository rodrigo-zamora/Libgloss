import 'package:flutter/material.dart';

import '../../config/colors.dart';
import '../../config/routes.dart';
import '../../widgets/shared/online_image.dart';

class WishItem extends StatefulWidget {
  final Map<String, dynamic> item;

  const WishItem({super.key, required this.item});

  @override
  State<WishItem> createState() => _WishItemState();
}

class _WishItemState extends State<WishItem> {
  @override
  Widget build(BuildContext context) {
    final Color _primaryColor =
        ColorSelector.getPrimary(LibglossRoutes.BOOK_TRACKER);
    final Color _secondaryColor =
        ColorSelector.getSecondary(LibglossRoutes.BOOK_TRACKER);
    final Color _blueColor = ColorSelector.getTertiary(LibglossRoutes.HOME);

    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Colors.grey.shade300,
        ),
      ),
      padding: EdgeInsets.only(left: 12, right: 12, top: 8, bottom: 8),
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            children: [
              Column(
                children: [
                  Container(
                    width: 100,
                    height: 150,
                    child: OnlineImage(
                      imageUrl: widget.item["thumbnail"]!,
                      height: 100,
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * 0.42,
                    padding: EdgeInsets.only(bottom: 12, left: 12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          child: Text(
                            widget.item["title"]!,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.center,
                            maxLines: 2,
                            style: TextStyle(
                              fontSize: 14,
                            ),
                          ),
                        ),
                        Container(
                          child: Text(
                            widget.item["authors"].toString(),
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.center,
                            maxLines: 2,
                            style: TextStyle(
                              color: _blueColor,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
