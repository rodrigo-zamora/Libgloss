import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:libgloss/repositories/auth/user_auth_repository.dart';

import '../../config/colors.dart';
import '../../config/routes.dart';
import '../../widgets/shared/search_appbar.dart';

class ConfigurationPage extends StatelessWidget {
  ConfigurationPage({super.key});

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
          title: 'Configuración',
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
            if (data != null) return _buildNotifications(data);
          }
        }
        return Center(
            child: CircularProgressIndicator(
          color: _secondaryColor,
        ));
      },
    );
  }

  Widget _buildNotifications(Map<String, dynamic> data) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Text(
            'Recibir notificaciones acerca de libros que hayas guardado en tu lista de seguimiento',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w400,
            ),
          ),
          Row(
            children: [
              Text(
                'Recibir notificaciones',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Spacer(),
              StatefulBuilder(
                builder: (context, setState) {
                  return Switch(
                    value: data['notifications'],
                    onChanged: (value) {
                      setState(() {
                        data['notifications'] = value;
                        FirebaseFirestore.instance
                            .collection('users')
                            .doc(UserAuthRepository().getuid())
                            .update({'notifications': value});
                      });
                    },
                    activeTrackColor: _tertiaryColor,
                    activeColor: _secondaryColor,
                  );
                },
              ),
            ],
          ),
          Divider(
            color: _iconColors,
          ),
        ],
      ),
    );
  }
}
