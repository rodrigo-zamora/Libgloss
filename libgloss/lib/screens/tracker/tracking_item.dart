import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:libgloss/repositories/auth/user_auth_repository.dart';

import '../../blocs/tracking/bloc/tracking_bloc.dart';
import '../../config/colors.dart';
import '../../config/routes.dart';
import '../../widgets/shared/online_image.dart';

class TrackingItem extends StatefulWidget {
  final Map<String, dynamic> item;

  const TrackingItem({super.key, required this.item});

  @override
  State<TrackingItem> createState() => _TrackingItemState();
}

class _TrackingItemState extends State<TrackingItem> {
  final Color _primaryColor =
      ColorSelector.getPrimary(LibglossRoutes.BOOK_TRACKER);
  final Color _secondaryColor =
      ColorSelector.getSecondary(LibglossRoutes.BOOK_TRACKER);
  final Color _blueColor = ColorSelector.getTertiary(LibglossRoutes.HOME);

  late TextEditingController _priceController =
      TextEditingController(text: "${widget.item["price"]}");
  late int _monthsTracking = widget.item["time"];
  late String _storeTracking = widget.item["store"];

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
                        Container(
                          width: 100,
                          height: 150,
                          child: OnlineImage(
                            imageUrl: widget.item["thumbnail"] != null
                                ? widget.item["thumbnail"]
                                : "https://vip12.hachette.co.uk/wp-content/uploads/2018/07/missingbook.png",
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
                    _openEdit(context);
                  },
                ),
              ),
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
                      "Plataforma: ${widget.item["store"] == "all" ? "Todas las plataformas" : widget.item["store"]}",
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
                      "Precio deseado: \$${widget.item["price"]}",
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
                      "Tiempo: ${widget.item["time"]} meses",
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

  void _openEdit(BuildContext _context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return SingleChildScrollView(
            child: AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(25.0))),
              //contentPadding: EdgeInsets.all(22.0),
              title: Text("Editar Seguimiento"),
              content: Container(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      '¿Quiere editar del libro?\n',
                      style: TextStyle(
                          fontSize: 16.0, fontStyle: FontStyle.italic),
                    ),
                    Text(
                      '${widget.item["title"]!}',
                      style: TextStyle(
                          fontSize: 18.0, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      '${widget.item["authors"].join(', ')}',
                      style: TextStyle(
                        fontSize: 16.0,
                        color: _blueColor,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      height: MediaQuery.of(context).size.height / 4,
                      child: OnlineImage(
                        imageUrl: widget.item["thumbnail"] != null
                            ? widget.item["thumbnail"]
                            : "https://vip12.hachette.co.uk/wp-content/uploads/2018/07/missingbook.png",
                        height: 100,
                      ),
                    ),
                    Form(
                      child: Column(
                        children: [
                          TextFormField(
                            controller: _priceController,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              labelText: "Precio",
                              hintText: "Precio",
                            ),
                          ),
                          DropdownButtonFormField(
                            items: [
                              DropdownMenuItem(
                                child: Text("Todas las tiendas"),
                                value: "all",
                              ),
                              DropdownMenuItem(
                                child: Text("Amazon"),
                                value: "amazon",
                              ),
                              DropdownMenuItem(
                                child: Text("Gandhi"),
                                value: "gandhi",
                              ),
                              DropdownMenuItem(
                                child: Text("Gonvill"),
                                value: "gonvill",
                              ),
                              DropdownMenuItem(
                                child: Text("El Sótano"),
                                value: "el_sotano",
                              ),
                            ],
                            onChanged: (value) {
                              _storeTracking = value!;
                            },
                            decoration: InputDecoration(
                              labelText:
                                  "${widget.item["store"] == "all" ? "Todas las plataformas" : widget.item["store"]}",
                            ),
                          ),
                          DropdownButtonFormField(
                            items: [
                              DropdownMenuItem(
                                child: Text("1 mes"),
                                value: 1,
                              ),
                              DropdownMenuItem(
                                child: Text("3 meses"),
                                value: 3,
                              ),
                              DropdownMenuItem(
                                child: Text("6 meses"),
                                value: 6,
                              ),
                              DropdownMenuItem(
                                child: Text("1 año"),
                                value: 12,
                              ),
                            ],
                            onChanged: (value) {
                              _monthsTracking = value!;
                            },
                            decoration: InputDecoration(
                              labelText: "${widget.item["time"]} meses",
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              actions: [
                IconButton(
                  icon: Icon(
                    Icons.delete_forever,
                    color: _secondaryColor,
                  ),
                  onPressed: () {
                    _delete(_context);
                  },
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context, 'Cancel');
                  },
                  child: Text("Cancelar",
                      style: TextStyle(color: _secondaryColor)),
                ),
                TextButton(
                  onPressed: () async {
                    Navigator.pop(context);

                    if (_priceController.text.isEmpty) {
                      ScaffoldMessenger.of(_context)
                        ..hideCurrentSnackBar()
                        ..showSnackBar(
                          SnackBar(
                            content: Text("El precio no puede estar vacío"),
                          ),
                        );
                      return;
                    }

                    print("Meses: $_monthsTracking");
                    print("Tienda: $_storeTracking");
                    print("Precio: ${_priceController.text}");

                    print("ID: ${widget.item["isbn"]}");
                    try {
                      QuerySnapshot listDocument = await FirebaseFirestore
                          .instance
                          .collection('lists')
                          .where('useruid',
                              isEqualTo: UserAuthRepository().getuid())
                          .get();
                      String listuid = listDocument.docs[0].id;

                      // Get the item tracking from the list
                      List<dynamic> tracking = listDocument.docs[0]["tracking"];

                      // Get the index of the item tracking
                      int index = tracking.indexWhere(
                          (element) => element["isbn"] == widget.item["isbn"]);

                      // Update the item tracking
                      tracking[index]["price"] = _priceController.text;
                      tracking[index]["time"] = _monthsTracking;
                      tracking[index]["store"] = _storeTracking;

                      // Update the list
                      await FirebaseFirestore.instance
                          .collection('lists')
                          .doc(listuid)
                          .update({"tracking": tracking});

                      BlocProvider.of<TrackingBloc>(_context)
                          .add(UpdateTracking());

                      ScaffoldMessenger.of(context)
                        ..hideCurrentSnackBar()
                        ..showSnackBar(
                          SnackBar(
                            content: Text("Seguimiento actualizado"),
                          ),
                        );
                    } catch (e) {
                      print(e);
                    }
                  },
                  child:
                      Text("Guardar", style: TextStyle(color: _secondaryColor)),
                ),
              ],
            ),
          );
        });
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
                "¿Estás seguro que deseas eliminar este libro a tu lista de segumientos?"),
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
                  Navigator.pop(context);
                  try {
                    QuerySnapshot listDocument = await FirebaseFirestore
                        .instance
                        .collection('lists')
                        .where('useruid',
                            isEqualTo: UserAuthRepository().getuid())
                        .get();
                    String listuid = listDocument.docs[0].id;

                    // Get the item tracking from the list
                    List<dynamic> tracking = listDocument.docs[0]["tracking"];

                    // Get the index of the item tracking
                    int index = tracking.indexWhere(
                        (element) => element["isbn"] == widget.item["isbn"]);

                    // Remove the item tracking
                    tracking.removeAt(index);

                    // Update the list
                    await FirebaseFirestore.instance
                        .collection('lists')
                        .doc(listuid)
                        .update({"tracking": tracking});

                    BlocProvider.of<TrackingBloc>(_context)
                        .add(UpdateTracking());

                    ScaffoldMessenger.of(_context)
                      ..hideCurrentSnackBar()
                      ..showSnackBar(
                        SnackBar(
                          content: Text("Seguimiento eliminado"),
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
