import 'dart:io';
import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:libgloss/config/app_color.dart';
import 'package:libgloss/config/routes.dart';
import 'package:libgloss/models/ModelProvider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:libgloss/widgets/shared/search_appbar.dart';

import '../../blocs/auth/bloc/auth_bloc.dart';

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

  Users? user = new Users();

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
    if (user != null) {
      return FutureBuilder<AuthUser>(
        future: Amplify.Auth.getCurrentUser(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text("Algo salió mal");
          }
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasData) {
              user = BlocProvider.of<AuthBloc>(context).currentUser;
              Users? data = user;
              return _buildMyAccount(context, data);
            }
          }
          return Center(
              child: CircularProgressIndicator(
            color: _secondaryColor,
          ));
        },
      );
    } else {
      return _buildMyAccount(context, user);
    }
  }

  Widget _buildMyAccount(BuildContext context, dynamic data) {
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
            data.username == null
                ? _nameController
                : _nameController = TextEditingController(text: data.username),
            TextInputType.text,
            data.username),
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
            data.phoneNumber == null
                ? _phoneController
                : _phoneController =
                    TextEditingController(text: data.phoneNumber),
            TextInputType.number,
            data.phoneNumber),
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
            data.zipCode == null
                ? _zipController
                : _zipController = TextEditingController(text: data.zipCode),
            TextInputType.number,
            data.zipCode),
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
                        _phoneController.text.length <= 15) {
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
                        _zipController.text.length <= 5) {
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
                    await _updateProfile(data);
                    setState(() {
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

  Future<void> _updateProfile(Users data) async {
    final query = Users.EMAIL.eq(data.email);
    final req = ModelQueries.list<Users>(Users.classType, where: query);
    final res = await Amplify.API.query(request: req).response;
    if (pickedImage != null) {
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(
          SnackBar(
            content: Text('Subiendo imagen...'),
          ),
        );
      final URL = await _uploadImage(pickedImage!);

      final resultRemove = await Amplify.Storage.list();

      var checkURL;
      for (var item in resultRemove.items) {
        checkURL = await Amplify.Storage.getUrl(key: item.key);
        if (checkURL == data.profilePicture) {
          await Amplify.Storage.remove(key: item.key);
          break;
        }
      }

      if (res.data == null) {
        print("No user found");
      } else {
        final userWithData =
            res.data!.items.first!.copyWith(profilePicture: URL);

        final request = ModelMutations.update(userWithData);
        final response = await Amplify.API.mutate(request: request).response;
        print('Response: $response');
      }
    }
    // TODO: Update user data in Amplify database

    if (res.data == null) {
      throw new Exception('User not Found');
    } else {
      final updatedUser = res.data!.items.first!.copyWith(
        username: _nameController.text,
        phoneNumber: _phoneController.text,
        zipCode: _zipController.text,
      );
      final requestDelete = ModelMutations.delete(res.data!.items.first!);
      final responseDelete =
          await Amplify.API.mutate(request: requestDelete).response;
      print('Response: $responseDelete');
      final request = ModelMutations.create(updatedUser);
      final response = await Amplify.API.mutate(request: request).response;

      print('Response: $response');
    }

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
  }

  Container _profilePicture(Users data) {
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
                    imageUrl: data.profilePicture!,
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
                      user!.copyWith(profilePicture: pickedImage!.path);
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
    try {
      final fileName = "profile_pictures/${element.name}${DateTime.now()}.png";
      final resultUpload = await Amplify.Storage.uploadFile(
          local: File(element.path), key: fileName);
      final result = await Amplify.Storage.getUrl(key: resultUpload.key);
      return result.url;
    } catch (e) {
      throw e;
    }
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
