import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:jie_preview_image/jie_preview_image.dart';
import 'package:shimmer/shimmer.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../config/colors.dart';
import '../../config/routes.dart';
import '../../repositories/auth/user_auth_repository.dart';
import '../../widgets/shared/search_appbar.dart';
import '../../widgets/shared/side_menu.dart';

class UsedBookDetails extends StatefulWidget {
  UsedBookDetails({
    Key? key,
  }) : super(key: key);

  @override
  State<UsedBookDetails> createState() => _UsedBookDetailsState();
}

class _UsedBookDetailsState extends State<UsedBookDetails> {
  final Color _primaryColor =
      ColorSelector.getPrimary(LibglossRoutes.HOME_USED);
  final Color _secondaryColor =
      ColorSelector.getSecondary(LibglossRoutes.HOME_USED);
  final Color _blueColor = ColorSelector.getTertiary(LibglossRoutes.HOME);
  final Color _greenColor = ColorSelector.getTertiary(LibglossRoutes.HOME_USED);
  final Color _defaultColor = ColorSelector.getBlack();

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
          route: LibglossRoutes.HOME_USED,
        ),
      ),
      drawer: SideMenu(
        sideMenuColor: _primaryColor,
        route: LibglossRoutes.HOME_USED,
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
                _text("vendido por:  ", _defaultColor, 14.0, FontWeight.normal,
                    TextAlign.center),
                _text("${_args["seller"]}", _greenColor, 14.0,
                    FontWeight.normal, TextAlign.center),
              ],
            ),
            SizedBox(height: 8),
            _text("${_args["isbn"]}", _defaultColor, 15.0, FontWeight.normal,
                TextAlign.center),
            SizedBox(height: 20.0),
            _image(_args["images"]),
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
          _showSeller(context, _args),
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
                      _text("\$${_args["price"]}", _greenColor, 15.0,
                          FontWeight.normal, TextAlign.center),
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
                      _text("${_args["phoneNumber"]}", _greenColor, 15.0,
                          FontWeight.normal, TextAlign.center),
                    ],
                  ),
                ),
              ],
            ),
          ),
          _googleMap(_args),
        ],
      ),
    );
  }

  Widget _googleMap(_args) {
    Completer<GoogleMapController> _controller = Completer();
    double _circleLat = _args["latitude"];
    double _circleLng = _args["longitude"];
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

  Container _image(List<dynamic>? image) {
    final List<String> _images = image!.cast<String>();
    return Container(
      width: MediaQuery.of(context).size.width / 1.5,
      height: MediaQuery.of(context).size.width / 1.5,
      child: ListView.builder(
        itemCount: image.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              previewImage(
                context,
                urls: _images,
                currentUrl: _images[index],
              );
            },
            child: Container(
              child: Row(
                children: [
                  Image.network(
                    image[index],
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) return child;
                      return Container(
                        width: MediaQuery.of(context).size.width / 1.5,
                        child: Center(
                          child: CircularProgressIndicator(
                            value: loadingProgress.expectedTotalBytes != null
                                ? loadingProgress.cumulativeBytesLoaded /
                                    loadingProgress.expectedTotalBytes!
                                : null,
                            color: _secondaryColor,
                          ),
                        ),
                      );
                    },
                  ),
                  index != image.length - 1
                      ? SizedBox(width: 10)
                      : SizedBox(width: 0),
                ],
              ),
            ),
          );
        },
      ),
    );
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
        /* Navigator.pushNamed(context, LibglossRoutes.USED_BOOK_SELLER,
            arguments: {
              "vendedor": _args["vendedor"],
              "localizacion": _args["localizacion"],
              "contacto": _args["contacto"],
            }); */
        //TODO: call seller from phone
        _makePhoneCall(_args["phoneNumber"]);
      },
      child: _text("Contactar Vendedor", _defaultColor, 15.0, FontWeight.normal,
          TextAlign.center),
    );
  }

  Future<void> _makePhoneCall(String phoneNumber) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    await launchUrl(launchUri);
  }

  Widget _showSeller(BuildContext context, Map<String, dynamic> _args) {
    Future<QuerySnapshot<Map<String, dynamic>>> result = FirebaseFirestore.instance.collection('users').where('username', isEqualTo: _args["seller"]).get();  
    var isLoggedIn = UserAuthRepository().isAuthenticated();
    print("IS LOOOGED $isLoggedIn");
    if (isLoggedIn){
      return FutureBuilder<DocumentSnapshot>(
        future: result.then((value) => value.docs.first.reference.get()),
        builder:
            (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text("Something went wrong");
          }
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasData) {
              Map<String, dynamic>? data =
                  snapshot.data!.data() as Map<String, dynamic>?;
              if (data != null) return _buildUserOptions(data);
            }
          }
          return _loadingUserOptions();
        },
      );
    }
    else {
      return Container();
    }
  }

  Widget _loadingUserOptions() {
    return Center(
      child: CircularProgressIndicator(
        color: _secondaryColor,
      ),
    );
  }

  Widget _buildUserOptions(Map<String, dynamic>? data) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 15),
          Text(
            data?['username'],
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: _defaultColor,
            ),
          ),
          SizedBox(height: 15),
          _profilePicture(data),
          SizedBox(height: 15),
        ],
      ),
    );
  }

  SizedBox _profilePicture(Map<String, dynamic>? data) {
    return SizedBox(
      height: 150,
      width: 150,
      child: Stack(
        fit: StackFit.expand,
        clipBehavior: Clip.none,
        children: [
          CachedNetworkImage(
            placeholder: (context, url) {
              return ClipOval(
                child: Shimmer.fromColors(
                  baseColor: Colors.grey[300]!,
                  highlightColor: Colors.grey[100]!,
                  child: Container(
                    width: 100,
                    color: Colors.grey[300],
                  ),
                ),
              );
            },
            fit: BoxFit.contain,
            imageUrl: data!['profilePicture'],
            imageBuilder: (context, imageProvider) {
              return CircleAvatar(
                backgroundImage: imageProvider,
              );
            },
          ),
        ],
      )
    );
  }
}
