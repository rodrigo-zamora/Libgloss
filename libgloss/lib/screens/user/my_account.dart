import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:libgloss/config/app_color.dart';
import 'package:libgloss/config/routes.dart';
import 'package:shimmer/shimmer.dart';
import 'package:libgloss/widgets/shared/search_appbar.dart';

class Account extends StatefulWidget {
  Account({super.key});

  @override
  State<Account> createState() => _AccountState();
}

class _AccountState extends State<Account> {
  final Color _primaryColor = AppColor.getPrimary(Routes.options);

  final Color _secondaryColor = AppColor.getSecondary(Routes.options);

  final Color _iconColors = AppColor.gray;

  late TextEditingController _nameController = TextEditingController();

  late TextEditingController _phoneController = TextEditingController();

  late TextEditingController _zipController = TextEditingController();

  XFile? pickedImage;
  bool hasImage = false;
  bool updating = false;

  Map<String, dynamic> user = {};

  @override
  Widget build(BuildContext context) {
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
          showBackButton: true,
          title: 'Editar mi cuenta',
        ),
      ),
      body: _main(context),
    );
  }

  Widget _main(BuildContext context) {
    // TODO: Get user data from Amplify database and show it in the screen

    return _buildMyAccount(context, {});
  }

  Widget _buildMyAccount(BuildContext context, Map<String, dynamic> data) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          padding: EdgeInsets.only(top: 30),
          child: Text("Foto de perfil",
              style: TextStyle(
                color: _secondaryColor,
                fontSize: 19,
                fontWeight: FontWeight.bold,
              )),
        ),
        _profilePicture(data),
        Container(
          padding: EdgeInsets.only(bottom: 5, top: 20),
          child: Text("Nombre de usuario",
              style: TextStyle(
                color: _secondaryColor,
                fontSize: 17,
              )),
        ),
        _edit(
            context,
            data['username'] == null
                ? _nameController
                : _nameController =
                    TextEditingController(text: data['username']),
            TextInputType.text,
            data['username']),
        Container(
          padding: EdgeInsets.only(bottom: 5, top: 20),
          child: Text("Número de teléfono",
              style: TextStyle(
                color: _secondaryColor,
                fontSize: 17,
              )),
        ),
        _edit(
            context,
            data['phoneNumber'] == null
                ? _phoneController
                : _phoneController =
                    TextEditingController(text: data['phoneNumber']),
            TextInputType.number,
            data['phoneNumber']),
        Container(
          padding: EdgeInsets.only(bottom: 5, top: 20),
          child: Text("Código postal",
              style: TextStyle(
                color: _secondaryColor,
                fontSize: 17,
              )),
        ),
        _edit(
            context,
            data['zipCode'] == null
                ? _zipController
                : _zipController = TextEditingController(text: data['zipCode']),
            TextInputType.number,
            data['zipCode']),
        updating == true
            ? Column(
                children: [
                  SizedBox(
                    height: 32,
                  ),
                  CircularProgressIndicator(
                    color: _secondaryColor,
                  ),
                ],
              )
            : Container(
                padding: EdgeInsets.only(top: 35),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _secondaryColor,
                    foregroundColor: _primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  onPressed: () async {
                    if (_phoneController.text == '' ||
                        _phoneController.text.length != 10) {
                      ScaffoldMessenger.of(context)
                        ..hideCurrentSnackBar()
                        ..showSnackBar(
                          SnackBar(
                            content: Text(
                                'El número de teléfono debe tener 10 dígitos'),
                          ),
                        );
                      return;
                    }

                    if (_zipController.text == '' &&
                        _zipController.text.length != 5) {
                      ScaffoldMessenger.of(context)
                        ..hideCurrentSnackBar()
                        ..showSnackBar(
                          SnackBar(
                            content:
                                Text('El código postal debe tener 5 dígitos'),
                          ),
                        );
                      return;
                    }

                    if (_nameController.text == '') {
                      ScaffoldMessenger.of(context)
                        ..hideCurrentSnackBar()
                        ..showSnackBar(
                          SnackBar(
                            content: Text(
                                'El nombre de usuario no puede estar vacío'),
                          ),
                        );
                      return;
                    }

                    setState(() {
                      _updateProfile(data);
                      updating = true;
                    });
                  },
                  child: Container(
                    padding: EdgeInsets.only(
                        top: 13, bottom: 13, left: 10, right: 10),
                    child: Text(
                      "Guardar cambios",
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ),
                ),
              ),
      ],
    );
  }

  void _updateProfile(Map<String, dynamic> data) async {
    if (pickedImage != null) {
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(
          SnackBar(
            content: Text('Subiendo imagen...'),
          ),
        );
      final URL = await _uploadImage(pickedImage!);

      // TODO: Delete old image from Amplify storage and update the URL in the database

    }

    try {
      // TODO: Update user data in Amplify database

      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(
          SnackBar(
            content: Text('Perfil actualizado'),
          ),
        );

      Routes.currentRoute = Routes.home;
      Navigator.pushAndRemoveUntil(
          context,
          PageRouteBuilder(pageBuilder: (BuildContext context,
              Animation animation, Animation secondaryAnimation) {
            return Routes.getRoute(Routes.home);
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
    } catch (e) {
      print(e);
    }
  }

  Container _profilePicture(Map<String, dynamic>? data) {
    return Container(
        height: 110,
        width: 110,
        margin: EdgeInsets.only(top: 20, bottom: 10),
        child: Stack(
          fit: StackFit.expand,
          clipBehavior: Clip.none,
          children: [
            hasImage == true
                ? CircleAvatar(
                    backgroundImage: FileImage(File(pickedImage!.path)),
                  )
                : CachedNetworkImage(
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
                  onPressed: () async {
                    final ImagePicker _picker = ImagePicker();
                    pickedImage = await _picker.pickImage(
                      source: ImageSource.gallery,
                    );
                    print(pickedImage!.path);
                    setState(() {
                      hasImage = true;
                      data!["profilePicture"] = pickedImage!.path;
                    });
                  },
                  child: Icon(
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

  Future<String> _uploadImage(XFile element) async {
    // TODO: Upload image to Amplify storage
    return "";
  }

  Widget _edit(BuildContext context, TextEditingController controller,
      TextInputType type, String data) {
    return StatefulBuilder(
      builder: (context, setState) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.only(bottom: 10),
              width: MediaQuery.of(context).size.width * 0.7,
              child: TextField(
                controller: controller,
                enabled: true,
                textAlign: TextAlign.center,
                keyboardType: type,
                decoration: InputDecoration(
                  border: UnderlineInputBorder(
                    borderSide: BorderSide(color: _secondaryColor),
                  ),
                  hintText: data,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
