import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:libgloss/blocs/auth/bloc/auth_bloc.dart';
import 'package:libgloss/config/app_color.dart';
import 'package:libgloss/config/routes.dart';
import 'package:libgloss/repositories/auth/user_auth_repository.dart';
import 'package:libgloss/widgets/shared/search_appbar.dart';

import '../../models/ModelProvider.dart';
import '../../models/Users.dart';

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
    final query = Settings.ID
        .eq(BlocProvider.of<AuthBloc>(context).currentUser!.settingsID);
    final req = ModelQueries.list<Settings>(Settings.classType, where: query);

    return FutureBuilder(
      future: Amplify.API.query(request: req).response,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text("Algo salió mal");
        }
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasData) {
            Users user = BlocProvider.of<AuthBloc>(context).currentUser!;
            Map<String, dynamic> data = user.toJson();
            return _buildNotifications(data);
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
                    value: (data["settingsID"] != Null),
                    onChanged: (value) {
                      setState(() async {
                        data['settingsID'] = value ? "Algo" : null;
                        final query = Settings.ID.eq(
                            BlocProvider.of<AuthBloc>(context)
                                .currentUser!
                                .settingsID);
                        final req = ModelQueries.list<Settings>(
                            Settings.classType,
                            where: query);
                        final response =
                            await Amplify.API.query(request: req).response;

                        final updatedSetting = response.data!.items.first!
                            .copyWith(notifications: value);
                        final request = ModelMutations.update(updatedSetting);
                        await Amplify.API.mutate(request: request).response;
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
