import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/auth/bloc/auth_bloc.dart';
import '../../config/colors.dart';
import '../../config/routes.dart';
import '../parts/have_account.dart';
import '../parts/or_line.dart';
import '../parts/social_log.dart';
import '../../widgets/shared/search_appbar.dart';

import '../parts/bunny_silhouette.dart';
import '../parts/button_log.dart';
import '../parts/log_text.dart';

class LogInForm extends StatefulWidget {
  LogInForm({super.key});

  @override
  State<LogInForm> createState() => _LogInFormState();
}

class _LogInFormState extends State<LogInForm> {
  bool _current = true;

  @override
  Widget build(BuildContext context) {
    Color _primaryColor = _current
        ? ColorSelector.getPrimary(LibglossRoutes.OPTIONS)
        : ColorSelector.getPrimary(LibglossRoutes.BOOK_TRACKER);
    Color _secondaryColor = _current
        ? ColorSelector.getSecondary(LibglossRoutes.OPTIONS)
        : ColorSelector.getSecondary(LibglossRoutes.BOOK_TRACKER);
    Color _tertiaryColor = _current
        ? ColorSelector.getTertiary(LibglossRoutes.OPTIONS)
        : ColorSelector.getTertiary(LibglossRoutes.BOOK_TRACKER);
    Color _quaternaryColor = _current
        ? ColorSelector.getQuaternary(LibglossRoutes.OPTIONS)
        : ColorSelector.getQuaternary(LibglossRoutes.BOOK_TRACKER);
    AssetImage _logo = _current
        ? ColorSelector.getBackground(LibglossRoutes.OPTIONS)
        : ColorSelector.getBackground(LibglossRoutes.BOOK_TRACKER);

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
          title: _current ? 'Iniciar sesión' : 'Registrarse',
        ),
      ),
      body: _current
          ? _login(
              _primaryColor,
              _secondaryColor,
              _tertiaryColor,
              _quaternaryColor,
              _logo,
            )
          : _register(
              _primaryColor,
              _secondaryColor,
              _tertiaryColor,
              _quaternaryColor,
              _logo,
            ),
    );
  }

  Widget _login(Color _primaryColor, Color _secondaryColor,
      Color _tertiaryColor, Color _quaternaryColor, AssetImage _logo) {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.05,
          ),
          BunnySilhouette(context: context, logo: _logo),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.04,
          ),
          LogText(
              context: context,
              tertiaryColor: _quaternaryColor,
              secondaryColor: _secondaryColor,
              icon: Icons.person_outlined,
              text: "E-mail",
              onChanged: (value) {},
              tailIcon: null,
              obscure: false),
          LogText(
              context: context,
              tertiaryColor: _quaternaryColor,
              secondaryColor: _secondaryColor,
              icon: Icons.lock_outline,
              text: "Contraseña",
              onChanged: (value) {},
              tailIcon: Icons.visibility,
              obscure: true),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.01,
          ),
          HaveAccount(
              tertiaryColor: null,
              secondaryColor: _secondaryColor,
              text1: "",
              text2: "¿Olvidaste tu contraseña?",
              route: () {
                print("Forgot password");
              }),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.01,
          ),
          ButtonLog(
              context: context,
              background: _secondaryColor,
              splash: _primaryColor,
              text_color: Colors.white,
              text: "Acceder",
              onPressed: () {
                Navigator.pushNamed(context, LibglossRoutes.CURRENT_ROUTE);
              }),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.01,
          ),
          HaveAccount(
              tertiaryColor: _tertiaryColor,
              secondaryColor: _secondaryColor,
              text1: "¿No tienes cuenta?  ",
              text2: "Regístrate",
              route: () {
                setState(() {
                  _current = !_current;
                });
              }),
          OrLine(tertiaryColor: _tertiaryColor, context: context),
          SocialLog(
              logo: _tertiaryColor,
              splash: _primaryColor,
              action: () {
                BlocProvider.of<AuthBloc>(context).add(
                  GoogleAuthEvent(
                    buildcontext: context,
                  ),
                );
              }),
        ],
      ),
    );
  }

  Widget _register(Color _primaryColor, Color _secondaryColor,
      Color _tertiaryColor, Color _quaternaryColor, AssetImage _logo) {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.05,
          ),
          BunnySilhouette(context: context, logo: _logo),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.04,
          ),
          LogText(
              context: context,
              tertiaryColor: _quaternaryColor,
              secondaryColor: _secondaryColor,
              icon: Icons.person_outlined,
              text: "E-mail",
              onChanged: (value) {},
              tailIcon: null,
              obscure: false),
          LogText(
              context: context,
              tertiaryColor: _quaternaryColor,
              secondaryColor: _secondaryColor,
              icon: Icons.lock_outline,
              text: "Contraseña",
              onChanged: (value) {},
              tailIcon: Icons.visibility,
              obscure: true),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.041,
          ),
          ButtonLog(
              context: context,
              background: _secondaryColor,
              splash: _primaryColor,
              text_color: Colors.white,
              text: "Acceder",
              onPressed: () {
                Navigator.pushNamed(context, LibglossRoutes.CURRENT_ROUTE);
              }),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.01,
          ),
          HaveAccount(
              tertiaryColor: _tertiaryColor,
              secondaryColor: _secondaryColor,
              text1: "¿Ya tienes cuenta?  ",
              text2: "Inicia sesión",
              route: () {
                setState(() {
                  _current = !_current;
                });
              }),
          OrLine(tertiaryColor: _tertiaryColor, context: context),
          SocialLog(
              logo: _tertiaryColor,
              splash: _primaryColor,
              action: () {
                BlocProvider.of<AuthBloc>(context).add(
                  GoogleAuthEvent(
                    buildcontext: context,
                  ),
                );
              }),
        ],
      ),
    );
  }
}
