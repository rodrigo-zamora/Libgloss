import 'package:flutter/material.dart';

import '../../widgets/shared/online_image.dart';

class WishItem extends StatelessWidget {
  final Map<String, String> item;

  const WishItem({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    final Color _primaryColor = Color.fromRGBO(244, 210, 255, 1);
    final Color _secondaryColor = Color.fromRGBO(215, 132, 243, 1);
    final Color _blueColor = Color.fromRGBO(16, 112, 130, 1);
    
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
                  SizedBox(
                    width: 100,
                    height: 150,
                    child: OnlineImage(
                      imageUrl: item["image"]!,
                      width: 100,
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  Container(
                    padding: EdgeInsets.only(bottom: 12, left: 12),
                    child: Column(
                      children: [
                        Text(
                          item["title"]!,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.center,
                          maxLines: 2,
                          style: TextStyle(
                            fontSize: 14,
                          ),
                        ),
                        Text(
                          item["author"]!,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: _blueColor,
                            fontSize: 12,
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