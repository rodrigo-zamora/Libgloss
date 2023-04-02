import 'package:flutter/material.dart';
import 'package:libgloss/config/app_color.dart';
import 'package:libgloss/config/routes.dart';
import 'package:libgloss/repositories/auth/user_auth_repository.dart';
import 'package:libgloss/widgets/shared/search_appbar.dart';

class ConfigurationPage extends StatelessWidget {
  ConfigurationPage({super.key});

  final Color _primaryColor = AppColor.getPrimary(Routes.options);
  final Color _secondaryColor = AppColor.getSecondary(Routes.options);
  final Color _tertiaryColor = AppColor.getQuaternary(Routes.options);
  final Color _iconColors = AppColor.gray;

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
    // TODO: Get options from the user
    return CircularProgressIndicator();
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
                        // TODO: Update the user's options in the database
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
