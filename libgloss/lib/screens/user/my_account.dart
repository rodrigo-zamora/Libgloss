import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

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
          title: 'Mi cuenta',
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
            if (data != null) return _buildMyAccount(data);
          }
        }
        return Center(
            child: CircularProgressIndicator(
          color: _secondaryColor,
        ));
      },
    );
  }

  Widget _buildMyAccount(Map<String, dynamic> data) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.only(top: 20, bottom: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    fit: BoxFit.fill,
                    image: NetworkImage(data['profilePicture']),
                  ),
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
                data['username'],
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
                data['email'],
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
