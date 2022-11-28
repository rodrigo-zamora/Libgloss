import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:libgloss/repositories/auth/user_auth_repository.dart';

import '../../config/colors.dart';
import '../../config/routes.dart';
import '../../widgets/shared/search_appbar.dart';
import '../../widgets/shared/side_menu.dart';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

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

  double _lat = 0;
  double _lng = 0;
  bool uploaded = false;

  double _progress = 0;

  TextEditingController _controller = TextEditingController();

  List<XFile>? _imageFileList;

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
    if (uploaded == false) {
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
                  _text("Vendido por:  ", _defaultColor, 14.0,
                      FontWeight.normal, TextAlign.center),
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
    } else {
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
                  _text("Vendido por:  ", _defaultColor, 14.0,
                      FontWeight.normal, TextAlign.center),
                  _text("${_args["vendedor"]}", _greenColor, 14.0,
                      FontWeight.normal, TextAlign.center),
                ],
              ),
              SizedBox(height: 8),
              _text("${_args["isbn"]}", _defaultColor, 15.0, FontWeight.normal,
                  TextAlign.center),
              SizedBox(height: 64.0),
              Text(
                "Subiendo tu libro...",
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
              SizedBox(height: 24.0),
              Container(
                width: MediaQuery.of(context).size.width / 1.5,
                child: Image.asset(
                  'assets/images/loading/loading_bunny_green.gif',
                ),
              ),
              SizedBox(height: 24.0),
              Container(
                width: MediaQuery.of(context).size.width / 1.5,
                child: LinearProgressIndicator(
                  value: _progress / 100,
                  backgroundColor: Colors.grey[300],
                  valueColor: AlwaysStoppedAnimation<Color>(_secondaryColor),
                ),
              ),
            ],
          ),
        ),
      );
    }
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
                        controller:
                            TextEditingController(text: _args["contacto"]),
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
              if (snapshot.hasData &&
                  snapshot.connectionState == ConnectionState.done) {
                Completer<GoogleMapController> _controller = Completer();
                double _circleLat =
                    snapshot.data!["latitude"] + Random().nextDouble() / 50;
                double _circleLng =
                    snapshot.data!["longitude"] + Random().nextDouble() / 50;
                _lat = _circleLat;
                _lng = _circleLng;
                final CameraPosition _kGooglePlex = CameraPosition(
                  target: LatLng(_circleLat, _circleLng),
                  zoom: 11.5,
                );
                return Container(
                  height: MediaQuery.of(context).size.height / 3,
                  child: GoogleMap(
                    mapType: MapType.normal,
                    initialCameraPosition: _kGooglePlex,
                    circles: Set.from(
                      [
                        Circle(
                          circleId: CircleId("1"),
                          center: LatLng(
                            _circleLat,
                            _circleLng,
                          ),
                          radius: 4000,
                          fillColor: _secondaryColor.withOpacity(0.25),
                          strokeWidth: 2,
                          strokeColor: _secondaryColor,
                        ),
                      ],
                    ),
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
    String? GOOGLE_API_KEY;
    try {
      await dotenv.load(fileName: ".env");
      GOOGLE_API_KEY = await dotenv.env['GOOGLE_API_KEY'];
    } catch (e) {
      print(e);
    }
    if (GOOGLE_API_KEY == null) {
      GOOGLE_API_KEY = String.fromEnvironment("GOOGLE_API_KEY");
    }
    print("GOOGLE_API_KEY: $GOOGLE_API_KEY");
    try {
      var url = Uri.parse(
          "https://maps.googleapis.com/maps/api/geocode/json?components=postal_code:$zipCode&sensor=false&&key=$GOOGLE_API_KEY");
      var response = await http.get(url);
      var data = jsonDecode(response.body);
      _latitude = data["results"][0]["geometry"]["location"]["lat"];
      _longitude = data["results"][0]["geometry"]["location"]["lng"];
      return {
        "latitude": _latitude,
        "longitude": _longitude,
      };
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
              offset: Offset(1, 5),
            ),
          ],
        ),
        child: Column(
          children: [
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
    if (_imageFileList != null) {
      return ListView.builder(
        scrollDirection: Axis.horizontal,
        key: UniqueKey(),
        itemBuilder: (BuildContext context, int index) {
          return Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                height: MediaQuery.of(context).size.height / 2.4,
                width: MediaQuery.of(context).size.width / 1.3,
                decoration: BoxDecoration(
                  color: index % 2 == 0 ? _primaryColor : _secondaryColor,
                ),
                child: Container(
                  padding: EdgeInsets.all(10),
                  child: Image.file(
                    File(_imageFileList![index].path),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ],
          );
        },
        itemCount: _imageFileList!.length,
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
          Image.asset(
            'assets/images/special/green_reading_bunny.png',
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
      onPressed: () async {
        String _price = _controller.text;
        if (_imageFileList == null) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Text("Debes agregar al menos una imagen"),
              ),
            );
        } else if (_price.isEmpty) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Text(
                  "Debes ingresar un precio",
                ),
              ),
            );
        } else {
          uploaded = true;
          List<String> _imagesURL = [];
          String _phoneNumber = await FirebaseFirestore.instance
              .collection("users")
              .doc(UserAuthRepository().getuid())
              .get()
              .then((value) => value.data()!["phoneNumber"]);
          setState(() {});
          _progress += 10;

          double _totalProgressImages = 80;
          for (var i = 0; i < _imageFileList!.length; i++) {
            String _imageURL = await _uploadImage(_imageFileList![i]);
            _imagesURL.add(_imageURL);
            _progress += _totalProgressImages / _imageFileList!.length;
            setState(() {});
          }
          Map<String, dynamic> _book = {
            "title": _args["title"],
            "authors": _args["authors"],
            "seller": _args["vendedor"],
            "isbn": _args["isbn"],
            "thumbnail": _args["thumbnail"],
            "price": _price,
            "latitude": _lat,
            "longitude": _lng,
            "images": _imagesURL,
            "phoneNumber": _phoneNumber,
            "sellerUid": UserAuthRepository().getuid(),
          };
          _progress = 100;
          setState(() {});
          uploaded = await _addBook(_book);
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Text(
                  uploaded
                      ? "Libro agregado correctamente"
                      : "Hubo un error al agregar el libro",
                ),
              ),
            );
          if (uploaded) {
            Navigator.pushAndRemoveUntil(
                context,
                PageRouteBuilder(pageBuilder: (BuildContext context,
                    Animation animation, Animation secondaryAnimation) {
                  return LibglossRoutes.getRoute(LibglossRoutes.HOME);
                }, transitionsBuilder: (BuildContext context,
                    Animation<double> animation,
                    Animation<double> secondaryAnimation,
                    Widget child) {
                  return new SlideTransition(
                    position: new Tween<Offset>(
                      begin: const Offset(1.0, 0.0),
                      end: Offset.zero,
                    ).animate(animation),
                    child: child,
                  );
                }),
                (Route route) => false);
          }
        }
      },
      child: _text("Guardar libro", _defaultColor, 15.0, FontWeight.normal,
          TextAlign.center),
    );
  }

  Future<String> _uploadImage(XFile element) async {
    final _firebaseStorage = FirebaseStorage.instance;
    final String _path = "books/${element.name}${DateTime.now()}.png";
    final _storageReference = _firebaseStorage.ref().child('$_path');
    final _uploadTask = _storageReference.putFile(File(element.path));
    final _snapshot = await _uploadTask.whenComplete(() => null);
    final _downloadURL = await _snapshot.ref.getDownloadURL();
    return _downloadURL;
  }

  Future<bool> _addBook(Map<String, dynamic> book) async {
    try {
      await FirebaseFirestore.instance
          .collection('books')
          .add(book)
          .then((value) => print("Book Added"))
          .catchError((error) => print("Failed to add book: $error"));
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }
}

typedef OnPickImageCallback = void Function(
    double? maxWidth, double? maxHeight, int? quality);
