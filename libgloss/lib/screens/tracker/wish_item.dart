import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:libgloss/config/app_color.dart';
import 'package:libgloss/config/routes.dart';
import 'package:libgloss/repositories/auth/user_auth_repository.dart';
import 'package:libgloss/blocs/tracking/bloc/tracking_bloc.dart';
import 'package:libgloss/widgets/shared/online_image.dart';

class WishItem extends StatefulWidget {
  const WishItem({super.key, required this.item});
  final Map<String, dynamic> item;

  @override
  State<WishItem> createState() => _WishItemState();
}

class _WishItemState extends State<WishItem> {
  final Color _secondaryColor = AppColor.getSecondary(Routes.bookTracker);
  final Color _blueColor = AppColor.getTertiary(Routes.home);

  @override
  Widget build(BuildContext context) {
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
          Stack(
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
                        width: MediaQuery.of(context).size.width * 0.39,
                        padding: EdgeInsets.only(bottom: 12, left: 12),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
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
                                widget.item["authors"].join(', '),
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
              Positioned(
                top: 0,
                right: 0,
                child: IconButton(
                  icon: Icon(
                    Icons.delete_forever,
                    color: _secondaryColor,
                  ),
                  onPressed: () {
                    _delete(context);
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _delete(BuildContext _context) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Eliminar de lista"),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(25.0))),
            contentPadding: EdgeInsets.all(22.0),
            content: Text(
                "¿Estás seguro que deseas eliminar este libro a tu lista de deseos?"),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context, 'Cancel');
                },
                child: Text("Cancelar"),
              ),
              TextButton(
                onPressed: () async {
                  Navigator.pop(context);
                  Map<String, dynamic> toRemove = widget.item;
                  try {
                    // TODO: Remove from list of books in Amplify
                    BlocProvider.of<TrackingBloc>(_context)
                        .add(UpdateTracking());
                    ScaffoldMessenger.of(_context)
                      ..hideCurrentSnackBar()
                      ..showSnackBar(
                        SnackBar(
                          content:
                              Text("Libro eliminado de tu lista de deseos"),
                        ),
                      );
                  } catch (e) {
                    print(e);
                  }
                },
                child: Text("Eliminar"),
              ),
            ],
          );
        });
  }
}
