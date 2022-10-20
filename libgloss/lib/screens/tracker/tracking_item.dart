import 'package:flutter/material.dart';

import '../../config/colors.dart';
import '../../config/routes.dart';
import '../../widgets/shared/online_image.dart';

class TrackingItem extends StatelessWidget {
  final Map<String, String> item;

  const TrackingItem({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    final Color _primaryColor = ColorSelector.getPrimary(LibglossRoutes.BOOK_TRACKER);
  final Color _secondaryColor = ColorSelector.getSecondary(LibglossRoutes.BOOK_TRACKER);
  final Color _blueColor = ColorSelector.getTertiary(LibglossRoutes.HOME);

    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Colors.grey.shade300,
        ),
      ),
      padding: EdgeInsets.only(left: 12, right: 12),
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Stack(
            children: [
              Positioned(
                child: Row(
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
                          padding: EdgeInsets.only(bottom: 12),
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
              ),
              Positioned(
                  top: 0,
                  right: 0,
                  child: IconButton(
                    icon: Icon(
                      Icons.edit,
                      color: _secondaryColor,
                    ),
                    onPressed: () {
                      print("HI");
                    },
                  )),
            ],
          ),
          SizedBox(
            height: 15,
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Plataforma: ${item["plataforma"]}",
                      style: TextStyle(
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Precio deseado: \$${item["precio"]}",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Tiempo: ${item["tiempo"]}",
                      style: TextStyle(
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
