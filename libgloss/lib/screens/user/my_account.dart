import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../config/colors.dart';
import '../../config/routes.dart';
import '../../repositories/auth/user_auth_repository.dart';
import '../../widgets/shared/search_appbar.dart';

class Account extends StatelessWidget {
  Account({super.key});

  final Color _primaryColor = ColorSelector.getPrimary(LibglossRoutes.OPTIONS);
  final Color _secondaryColor =
      ColorSelector.getSecondary(LibglossRoutes.OPTIONS);
  final Color _tertiaryColor =
      ColorSelector.getQuaternary(LibglossRoutes.OPTIONS);
  final Color _iconColors = ColorSelector.getGrey();

  late TextEditingController _nameController = TextEditingController();
  late TextEditingController _phoneController = TextEditingController();
  late TextEditingController _zipController = TextEditingController();

  bool _nameEditing = false;
  bool _phoneEditing = false;
  bool _zipEditing = false;

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
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    return FutureBuilder<DocumentSnapshot>(
      future: users.doc(UserAuthRepository().getuid()).get(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text("Algo salió mal");
        }
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasData) {
            Map<String, dynamic> data =
                snapshot.data!.data() as Map<String, dynamic>;
            if (data != null) return _buildMyAccount(context, data);
          }
        }
        return Center(
            child: CircularProgressIndicator(
          color: _secondaryColor,
        ));
      },
    );
  }

  Widget _buildMyAccount(BuildContext context, Map<String, dynamic> data) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          padding: EdgeInsets.only(top: 30),
          child: Text(
            "Editar mi foto de perfil",
            style: TextStyle(
              color: _secondaryColor,
              fontSize: 19,
              fontWeight: FontWeight.bold,
              fontStyle: FontStyle.italic
            )
          ),
        ),
        _profilePicture(data),
        /* Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.only(bottom: 10),
              width: MediaQuery.of(context).size.width * 0.8,
              child: TextField (
                controller: _nameController,
                enabled: _nameEditing,
                decoration: InputDecoration(
                  border: UnderlineInputBorder(
                    borderSide: BorderSide(color: _secondaryColor),
                  ),
                  hintText: data['username'], 
                ),
              ),
            ),
            IconButton (
              icon: Icon(Icons.edit),
              color: _secondaryColor,
              onPressed: () {
                print("HI");
                setState(() {
                  _nameEditing = !_nameEditing;
                });
              },
            ),
          ],
        ), */
        /* StatefulBuilder(
          builder: (context, setState) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: EdgeInsets.only(bottom: 10),
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: TextField (
                    controller: _nameController,
                    enabled: _nameEditing,
                    decoration: InputDecoration(
                      border: UnderlineInputBorder(
                        borderSide: BorderSide(color: _secondaryColor),
                      ),
                      hintText: data['username'], 
                    ),
                  ),
                ),
                IconButton (
                  icon: Icon(Icons.edit),
                  color: _secondaryColor,
                  onPressed: () {
                    print("HI");
                    setState(() {
                      _nameEditing = !_nameEditing;
                    });
                  },
                ),
              ],
            );
          },
        ), */
        Container(
          padding: EdgeInsets.only(bottom: 5, top: 20),
          child: Text(
            "Editar mi nombre",
            style: TextStyle(
              color: _secondaryColor,
              fontSize: 17,
              fontStyle: FontStyle.italic
            )
          ),
        ),
        _edit(context, data['username'] == null ? 
          _nameController : _nameController = TextEditingController(text: data['username']), 
          data['username'], _nameEditing),
        Container(
          padding: EdgeInsets.only(bottom: 5, top: 20),
          child: Text(
            "Editar mi teléfono",
            style: TextStyle(
              color: _secondaryColor,
              fontSize: 17,
              fontStyle: FontStyle.italic
            )
          ),
        ),
        _edit(context, data['phoneNumber'] == null ? 
          _phoneController : _phoneController = TextEditingController(text: data['phoneNumber']), 
          data['phoneNumber'], _phoneEditing),
        Container(
          padding: EdgeInsets.only(bottom: 5, top: 20),
          child: Text(
            "Editar mi código postal",
            style: TextStyle(
              color: _secondaryColor,
              fontSize: 17,
              fontStyle: FontStyle.italic
            )
          ),
        ),
        _edit(context, data['zipCode'] == null ? 
          _zipController : _zipController = TextEditingController(text: data['zipCode']), 
          data['zipCode'], _zipEditing),
        /* Container(
          padding: EdgeInsets.only(top: 20, bottom: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                data['phoneNumber'],
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        Container(
          padding: EdgeInsets.only(top: 20, bottom: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                data['zipCode'],
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ), */
        Container(
          padding: EdgeInsets.only(top: 35),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: _secondaryColor,
              foregroundColor: _primaryColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            onPressed: () {
              print("Save");
            },
            child: Container(
              padding: EdgeInsets.only(top: 13, bottom: 13, left: 10, right: 10),
              child: Text(
                "Guardar cambios",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ],
    );
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
      )
    );
  }

  Widget _edit(
    BuildContext context, 
    TextEditingController controller, 
    String data,
    bool edit
    ){
    return StatefulBuilder(
      builder: (context, setState) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.only(bottom: 10),
              width: MediaQuery.of(context).size.width * 0.7,
              child: TextField (
                controller: controller,
                enabled: edit,
                textAlign: TextAlign.center,
                decoration: InputDecoration(
                  border: UnderlineInputBorder(
                    borderSide: BorderSide(color: _secondaryColor),
                  ),
                  hintText: data, 
                ),
              ),
            ),
            Container(
              //color: Colors.blue,
              width: MediaQuery.of(context).size.width * 0.075,
              child: IconButton (
                icon: Icon(Icons.edit),
                color: _secondaryColor,
                onPressed: () {
                  print("edit ${controller.text}");
                  setState(() {
                    edit = !edit;
                  });
                },
              ),
            ),
          ],
        );
      },
    );
  }
}
