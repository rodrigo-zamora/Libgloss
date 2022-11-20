import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:geocode/geocode.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../config/colors.dart';
import '../../config/routes.dart';
import '../../widgets/shared/search_appbar.dart';
import '../../widgets/shared/side_menu.dart';

import 'package:image_picker/image_picker.dart';

class UsedBookAdd extends StatefulWidget {
  UsedBookAdd({
    Key? key,
  }) : super(key: key);

  @override
  State<UsedBookAdd> createState() => _UsedBookAddState();
}

class _UsedBookAddState extends State<UsedBookAdd> {
  final Color _primaryColor =
      ColorSelector.getPrimary(LibglossRoutes.HOME_USED);
  final Color _secondaryColor =
      ColorSelector.getSecondary(LibglossRoutes.HOME_USED);
  final Color _blueColor = ColorSelector.getTertiary(LibglossRoutes.HOME);
  final Color _greenColor = ColorSelector.getTertiary(LibglossRoutes.HOME_USED);
  final Color _defaultColor = ColorSelector.getBlack();

  TextEditingController _controller = TextEditingController();

  List<XFile>? _imageFileList;

  void _setImageFileListFromFile(XFile? value) {
    _imageFileList = value == null ? null : <XFile>[value];
  }

  dynamic _pickImageError;
  bool isVideo = false;

  String? _retrieveDataError;

  final ImagePicker _picker = ImagePicker();
  final TextEditingController maxWidthController = TextEditingController();
  final TextEditingController maxHeightController = TextEditingController();
  final TextEditingController qualityController = TextEditingController();

  Widget build(BuildContext context) {
    final _args = ModalRoute.of(context)!.settings.arguments;
    _args as Map<String, dynamic>;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(80),
        child: SearchAppBar(
          primaryColor: _primaryColor,
          secondaryColor: _secondaryColor,
          showMenuButton: false,
          showCameraButton: false,
          showSearchField: true,
        ),
      ),
      drawer: SideMenu(
        sideMenuColor: _primaryColor,
      ),
      body: _main(context, _args),
    );
  }

  SingleChildScrollView _main(
      BuildContext context, Map<String, dynamic> _args) {
    return SingleChildScrollView(
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding:
            EdgeInsets.only(left: 30.0, right: 30.0, top: 15.0, bottom: 15.0),
        child: Column(
          //crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _text("${_args["title"]}", _defaultColor, 20.0, FontWeight.bold,
                TextAlign.center),
            SizedBox(height: 5),
            _text("${_args["authors"].join(', ')}", _blueColor, 15.0,
                FontWeight.normal, TextAlign.center),
            SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _text("Vendido por:  ", _defaultColor, 14.0, FontWeight.normal,
                    TextAlign.center),
                _text("${_args["vendedor"]}", _greenColor, 14.0,
                    FontWeight.normal, TextAlign.center),
              ],
            ),
            SizedBox(height: 8),
            _text("${_args["isbn"]}", _defaultColor, 15.0, FontWeight.normal,
                TextAlign.center),
            SizedBox(height: 20.0),
            _image(_args["thumbnail"]),
            SizedBox(height: 30.0),
            _text("Información", _defaultColor, 15.0, FontWeight.normal,
                TextAlign.center),
            Container(
              width: MediaQuery.of(context).size.width / 2.5,
              child: Divider(
                color: _defaultColor,
                thickness: 0.5,
              ),
            ),
            _table(_args),
            SizedBox(height: 20.0),
            _buttonSeller(context, _args),
          ],
        ),
      ),
    );
  }

  Container _table(Map<String, dynamic> _args) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: _secondaryColor),
        borderRadius: BorderRadius.all(Radius.circular(5)),
      ),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: 5.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width / 3,
                  child: Column(
                    children: [
                      _text("Precio", _defaultColor, 15.0, FontWeight.normal,
                          TextAlign.center),
                      TextField(
                        decoration: InputDecoration(
                          hintText: "Precio",
                        ),
                        textAlign: TextAlign.center,
                        controller: _controller,
                        keyboardType: TextInputType.number,
                        maxLength: 10,
                        maxLines: 1,
                      )
                    ],
                  ),
                ),
                VerticalDivider(
                  color: _secondaryColor,
                  thickness: 1,
                ),
                Container(
                  width: MediaQuery.of(context).size.width / 3,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _text("Contacto", _defaultColor, 15.0, FontWeight.normal,
                          TextAlign.center),
                      //_text("${_args["contacto"]}", _greenColor, 15.0,
                      //    FontWeight.normal, TextAlign.center),
                      TextField(
                        textAlign: TextAlign.center,
                        controller: TextEditingController(text: _args["contacto"]),
                        style: TextStyle(color: _secondaryColor),
                        maxLines: 1,
                        enabled: false,
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          FutureBuilder(
            future: _getLocalizacion(_args["localizacion"]),
            builder: (context, snapshot) {
              print("CONNECTION STATE: ${snapshot.connectionState}");
              if (snapshot.hasData &&
                  snapshot.connectionState == ConnectionState.done) {
                Completer<GoogleMapController> _controller = Completer();
                final CameraPosition _kGooglePlex = CameraPosition(
                  target: LatLng(
                      snapshot.data!["latitude"], snapshot.data!["longitude"]),
                  zoom: 11.5,
                );
                return Container(
                  height: MediaQuery.of(context).size.height / 3,
                  child: GoogleMap(
                    mapType: MapType.normal,
                    initialCameraPosition: _kGooglePlex,
                    onMapCreated: (GoogleMapController controller) {
                      controller.animateCamera(
                        CameraUpdate.newCameraPosition(
                          _kGooglePlex,
                        ),
                      );
                      _controller.complete(controller);
                    },
                  ),
                );
              } else {
                return Container(
                  height: MediaQuery.of(context).size.height / 3,
                  child: Center(
                    child: CircularProgressIndicator(
                      color: _secondaryColor,
                    ),
                  ),
                );
              }
            },
          ),
        ],
      ),
    );
  }

  Future<Map> _getLocalizacion(String zipCode) async {
    double _latitude = 0.0;
    double _longitude = 0.0;
    GeoCode geoCode = GeoCode();
    try {
      Coordinates coordinates = await geoCode.forwardGeocoding(
        address: "$zipCode, Mexico",
      );
      return await Future.value({
        "latitude": coordinates.latitude,
        "longitude": coordinates.longitude,
      });
    } catch (e) {
      print(e);
      return {
        "latitude": _latitude,
        "longitude": _longitude,
      };
    }
  }

  Text _text(String text, Color color, double size, FontWeight weight,
      TextAlign align) {
    return Text(
      text,
      textAlign: align,
      style: TextStyle(
        fontSize: size,
        fontWeight: weight,
        color: color,
      ),
    );
  }

  Widget _image(String? image) {
    return GestureDetector(
      onTap: () {
        _onImageButtonPressed(context);
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: _secondaryColor),
          borderRadius: BorderRadius.all(Radius.circular(20)),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.6),
              spreadRadius: 7,
              blurRadius: 7,
              offset: Offset(1, 5), // changes position of shadow
            ),
          ],
        ),
        child: Column(
          children: [
            SizedBox(height: 20),
            Container(
              height: MediaQuery.of(context).size.height / 2.4,
              width: MediaQuery.of(context).size.width / 1.3,
              child: _previewImages(),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _onImageButtonPressed(BuildContext? context) async {
    try {
      final List<XFile> pickedFileList = await _picker.pickMultiImage();
      setState(() {
        _imageFileList = pickedFileList;
      });
    } catch (e) {
      setState(() {
        _pickImageError = e;
      });
    }
  }

  Widget _previewImages() {
    final Text? retrieveError = _getRetrieveErrorWidget();
    if (retrieveError != null) {
      return retrieveError;
    }
    // TODO: Fix image preview
    if (_imageFileList != null) {
      return Semantics(
        label: 'image_picker_example_picked_images',
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          key: UniqueKey(),
          itemBuilder: (BuildContext context, int index) {
            return Semantics(
              label: 'image_picker_example_picked_image',
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.file(
                    File(
                      _imageFileList![index].path,
                    ),
                    fit: BoxFit.fill,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                ],
              ),
            );
          },
          itemCount: _imageFileList!.length,
        ),
      );
    } else if (_pickImageError != null) {
      return Text(
        'Pick image error: $_pickImageError',
        textAlign: TextAlign.center,
      );
    } else {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Haz click para agregar las imágenes del libro",
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 15,
              fontStyle: FontStyle.italic,
              color: _secondaryColor,
            ),
          ),
          FittedBox(
            child: Image.asset(
              'assets/images/special/green_reading_bunny.png',
            ),
            fit: BoxFit.fitHeight,
          ),
        ],
      );
    }
  }

  Text? _getRetrieveErrorWidget() {
    if (_retrieveDataError != null) {
      final Text result = Text(_retrieveDataError!);
      _retrieveDataError = null;
      return result;
    }
    return null;
  }

  ElevatedButton _buttonSeller(
      BuildContext context, Map<String, dynamic> _args) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: _secondaryColor,
        foregroundColor: _primaryColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(32.0),
        ),
        padding: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
      ),
      onPressed: () {
        // TODO: add book to firebase and go to home
        print("Guardar libro");
      },
      child: _text("Guardar libro", _defaultColor, 15.0, FontWeight.normal,
          TextAlign.center),
    );
  }
}

typedef OnPickImageCallback = void Function(
    double? maxWidth, double? maxHeight, int? quality);
