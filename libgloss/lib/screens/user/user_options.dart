import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:libgloss/blocs/auth/bloc/auth_bloc.dart';
import 'package:libgloss/config/routes.dart';
import 'package:libgloss/repositories/auth/user_auth_repository.dart';
import 'package:shimmer/shimmer.dart';
import '../../config/colors.dart';
import '../../widgets/shared/search_appbar.dart';

class UserOptions extends StatefulWidget {
  UserOptions({super.key});

  @override
  State<UserOptions> createState() => _UserOptionsState();
}

class _UserOptionsState extends State<UserOptions> {
  final Color _primaryColor = ColorSelector.getPrimary(LibglossRoutes.OPTIONS);
  final Color _secondaryColor =
      ColorSelector.getSecondary(LibglossRoutes.OPTIONS);
  final Color _tertiaryColor =
      ColorSelector.getQuaternary(LibglossRoutes.OPTIONS);
  final Color _iconColors = ColorSelector.getGrey();

  @override
  Widget build(BuildContext context) {
    CollectionReference user = FirebaseFirestore.instance.collection('users');
    return FutureBuilder<DocumentSnapshot>(
      future: user.doc(UserAuthRepository().getuid()).get(),
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

  Widget _loadingUserOptions() {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(80),
        child: SearchAppBar(
          primaryColor: _primaryColor,
          secondaryColor: _secondaryColor,
          showMenuButton: false,
          showCameraButton: false,
          showSearchField: false,
          showBackButton: false,
          title: 'Mi perfil',
        ),
      ),
      body: Center(
        child: CircularProgressIndicator(
          color: _secondaryColor,
        ),
      ),
    );
  }

  Widget _buildUserOptions(Map<String, dynamic>? data) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(80),
        child: SearchAppBar(
          primaryColor: _primaryColor,
          secondaryColor: _secondaryColor,
          showMenuButton: false,
          showCameraButton: false,
          showSearchField: false,
          showBackButton: false,
          title: 'Mi perfil',
        ),
      ),
      body: //Container(
          //width: MediaQuery.of(context).size.width,
          SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minHeight: MediaQuery.of(context).size.height,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 20),
              Text(
                data?['username'],
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: _iconColors,
                ),
              ),
              Text(
                data!['email'],
                style: TextStyle(
                  fontSize: 14,
                  fontStyle: FontStyle.italic,
                  color: _iconColors,
                ),
              ),
              SizedBox(height: 20),
              _profilePicture(data),
              _sellerButton(data['isSeller']),
              //_followers(true),
              SizedBox(height: 10),
              _lowButton(Icons.person_outlined, "Mi cuenta", () {
                Navigator.pushNamed(context, LibglossRoutes.ACCOUNT);
              }, Icons.arrow_forward_ios),
              _bookHistory(data['isSeller']),
              _lowButton(Icons.help_outline, "Configuración", () {
                Navigator.pushNamed(context, LibglossRoutes.NOTIFICATIONS);
              }, Icons.arrow_forward_ios),
              _lowButton(Icons.logout_outlined, "Salir", () {
                BlocProvider.of<AuthBloc>(context).add(
                  SignOutEvent(
                    buildcontext: context,
                  ),
                );
              }, null),
            ],
          ),
        ),
      ),
    );
  }

  Widget _bookHistory(bool isSeller) {
    if (isSeller) {
      return _lowButton(Icons.book_outlined, "Mis libros", () {
        Navigator.pushNamed(context, LibglossRoutes.MY_BOOKS);
      }, Icons.arrow_forward_ios);
    } else {
      return Container();
    }
  }

  SizedBox _profilePicture(Map<String, dynamic>? data) {
    return SizedBox(
        height: 110,
        width: 110,
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
            Positioned(
              bottom: 0,
              right: -10,
              child: SizedBox(
                height: 40,
                width: 40,
                child: FloatingActionButton(
                  heroTag: "btn1",
                  backgroundColor: _primaryColor,
                  splashColor: _secondaryColor,
                  onPressed: () {
                    print("Change profile picture");
                    _show();
                  },
                  child: Icon(
                    //Icons.photo_camera_outlined,
                    Icons.edit_outlined,
                    color: _iconColors,
                    size: 22,
                  ),
                ),
              ),
            )
          ],
        ));
  }

  Padding _lowButton(
      IconData icon, String text, Function() onPressed, IconData? icon2) {
    if (icon2 != null) {
      return Padding(
        padding: EdgeInsets.symmetric(vertical: 8, horizontal: 20),
        child: TextButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(_tertiaryColor),
            shape: MaterialStateProperty.all(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
            ),
            padding: MaterialStateProperty.all(
              EdgeInsets.all(10),
            ),
            overlayColor:
                MaterialStateColor.resolveWith((states) => _primaryColor),
          ),
          onPressed: onPressed,
          child: Row(
            children: [
              Icon(
                icon,
                color: _secondaryColor,
                size: 22,
              ),
              SizedBox(width: 20),
              Expanded(
                child: Text(
                  text,
                  style: TextStyle(
                    color: _iconColors,
                  ),
                ),
              ),
              Icon(
                icon2,
                color: _secondaryColor,
                size: 20,
              ),
            ],
          ),
        ),
      );
    } else
      return Padding(
        padding: EdgeInsets.symmetric(vertical: 8, horizontal: 20),
        child: TextButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(_tertiaryColor),
            shape: MaterialStateProperty.all(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
            ),
            padding: MaterialStateProperty.all(
              EdgeInsets.all(10),
            ),
            overlayColor:
                MaterialStateColor.resolveWith((states) => _primaryColor),
          ),
          onPressed: onPressed,
          child: Row(
            children: [
              Icon(
                icon,
                color: _secondaryColor,
                size: 22,
              ),
              SizedBox(width: 20),
              Expanded(
                child: Text(
                  text,
                  style: TextStyle(
                    color: _iconColors,
                  ),
                ),
              ),
            ],
          ),
        ),
      );
  }

  Padding _sellerButton(bool isSeller) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 90),
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(_primaryColor),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25),
            ),
          ),
          padding: MaterialStateProperty.all(
            EdgeInsets.all(10),
          ),
          overlayColor:
              MaterialStateColor.resolveWith((states) => _tertiaryColor),
        ),
        onPressed: () {
          if (!isSeller)
            _showSellerDialog(
                FirebaseFirestore.instance
                    .collection('users')
                    .where('id', isEqualTo: UserAuthRepository().getuid())
                    .get(),
                isSeller);
          else {
            FirebaseFirestore.instance
                .collection('users')
                .doc(UserAuthRepository().getuid())
                .update({'isSeller': !isSeller});
            Navigator.pushNamedAndRemoveUntil(
                context, LibglossRoutes.HOME, (route) => false);
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                SnackBar(
                  content: Text(
                    isSeller ? "Ya no eres vendedor" : "Ahora eres vendedor",
                  ),
                ),
              );
            LibglossRoutes.CURRENT_ROUTE = LibglossRoutes.HOME_NEW;
          }
        },
        child: Row(
          children: [
            Expanded(
              child: _text(isSeller),
            ),
          ],
        ),
      ),
    );
  }

  Text _text(bool isSeller) {
    if (!isSeller) {
      return Text(
        "Convertirse en Vendedor",
        style: TextStyle(
          color: _iconColors,
        ),
        textAlign: TextAlign.center,
      );
    } else {
      return Text(
        "Ya eres vendedor",
        style: TextStyle(
          color: _iconColors,
        ),
        textAlign: TextAlign.center,
      );
    }
  }

  Widget _followers(bool isSeller) {
    if (isSeller) {
      return IntrinsicHeight(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildButton(4.8, 'Ranking'),
            VerticalDivider(
              color: _secondaryColor,
              thickness: 0.5,
            ),
            _buildButton(90, 'Seguidores'),
            VerticalDivider(
              color: _secondaryColor,
              thickness: 0.5,
            ),
            _buildButton(30, 'Seguidos'),
          ],
        ),
      );
    } else {
      return IntrinsicHeight(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildButton(4.9, 'Ranking'),
            VerticalDivider(
              color: _secondaryColor,
              thickness: 0.5,
            ),
            SizedBox(
              width: 88,
              child: Text(
                "¡Convierteté en vendedor!",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 13,
                  color: _iconColors,
                ),
              ),
            ),
            VerticalDivider(
              color: _secondaryColor,
              thickness: 0.5,
            ),
            _buildButton(45, 'Seguidos'),
          ],
        ),
      );
    }
  }

  Widget _buildButton(double number, String text) {
    var numberDisplay;
    if (number % 1 == 0)
      numberDisplay = number.toInt().toString();
    else
      numberDisplay = number.toString();
    return MaterialButton(
      padding: EdgeInsets.all(5),
      onPressed: () {},
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      child: Column(
        children: [
          Text(
            numberDisplay,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: _iconColors,
            ),
          ),
          Text(
            text,
            style: TextStyle(
              fontSize: 13,
              color: _iconColors,
            ),
          ),
        ],
      ),
    );
  }

  Widget _show() {
    return AlertDialog(
      title: Text('AlertDialog Title'),
      content: Text('AlertDialog description'),
      actions: <Widget>[
        TextButton(
          onPressed: () => Navigator.pop(context, 'Cancel'),
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () => Navigator.pop(context, 'OK'),
          child: const Text('OK'),
        ),
      ],
    );
  }

  _showSellerDialog(Future<QuerySnapshot> future, bool isSeller) async {
    List<DocumentSnapshot> user = (await future).docs;
    TextEditingController _phoneController = TextEditingController();
    TextEditingController _zpController = TextEditingController();
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("¿Quieres ser vendedor?"),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(25.0))),
          contentPadding: EdgeInsets.all(22.0),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text("Si quieres ser vendedor, debes tener teléfono y dirección"),
              SizedBox(height: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Debes ingresar tu teléfono",
                    style: TextStyle(
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                  TextField(
                    controller: user[0]['phoneNumber'] == null
                        ? _phoneController
                        : _phoneController =
                            TextEditingController(text: user[0]['phoneNumber']),
                    keyboardType: TextInputType.number,
                    maxLength: 10,
                    decoration: InputDecoration(
                      hintText: "Teléfono",
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              //if (user[0]['zipCode'] == null)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Debes ingresar tu código postal",
                    style: TextStyle(
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                  TextField(
                    controller: user[0]['zipCode'] == null
                        ? _zpController
                        : _zpController =
                            TextEditingController(text: user[0]['zipCode']),
                    keyboardType: TextInputType.number,
                    maxLength: 5,
                    decoration: InputDecoration(
                      hintText: "Código Postal",
                    ),
                  ),
                ],
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("Cancelar"),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                if (user[0]['phoneNumber'] == null) {
                  if (_phoneController.text.length == 10) {
                    FirebaseFirestore.instance
                        .collection('users')
                        .doc(user[0].id)
                        .update({
                      'phoneNumber': _phoneController.text,
                    });
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text("El teléfono debe tener 10 dígitos"),
                      ),
                    );
                  }
                }
                if (user[0]['zipCode'] == null) {
                  if (_zpController.text.length == 5) {
                    FirebaseFirestore.instance
                        .collection('users')
                        .doc(user[0].id)
                        .update({
                      'zipCode': _zpController.text,
                    });
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text("El código postal debe tener 5 dígitos"),
                      ),
                    );
                  }
                }
                if (_zpController.text.length == 5 &&
                    _phoneController.text.length == 10) {
                  FirebaseFirestore.instance
                      .collection('users')
                      //.doc(UserAuthRepository().getuid())
                      .doc(user[0].id)
                      .update({'isSeller': !isSeller});
                  Navigator.pushNamedAndRemoveUntil(
                      context, LibglossRoutes.HOME, (route) => false);
                  ScaffoldMessenger.of(context)
                    ..hideCurrentSnackBar()
                    ..showSnackBar(
                      SnackBar(
                        content: Text(
                          isSeller
                              ? "Ya no eres vendedor"
                              : "Ahora eres vendedor",
                        ),
                      ),
                    );
                  LibglossRoutes.CURRENT_ROUTE = LibglossRoutes.HOME_NEW;
                }
              },
              child: Text("Aceptar"),
            ),
          ],
        );
      },
    );
  }
}
