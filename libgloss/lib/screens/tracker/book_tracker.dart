import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:libgloss/config/app_color.dart';
import 'package:libgloss/config/routes.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:libgloss/blocs/tracking/bloc/tracking_bloc.dart';
import 'package:libgloss/widgets/shared/search_appbar.dart';
import 'package:libgloss/widgets/shared/side_menu.dart';

import 'tracking_item.dart';
import 'wish_item.dart';

class BookTracker extends StatefulWidget {
  BookTracker({super.key});

  @override
  State<BookTracker> createState() => _BookTrackerState();
}

class _BookTrackerState extends State<BookTracker> {
  final Color _primaryColor = AppColor.getPrimary(Routes.bookTracker);

  final Color _secondaryColor = AppColor.getSecondary(Routes.bookTracker);

  final controllerT = PageController(viewportFraction: 0.8, keepPage: true);

  final controllerW = PageController(viewportFraction: 0.8, keepPage: true);

  @override
  Widget build(BuildContext context) {
    // TODO: Get user lists from Amplify database

    String useruid = "";

    if (useruid == "") {
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
            title: 'Mis listas',
          ),
        ),
        drawer: SideMenu(
          sideMenuColor: _primaryColor,
        ),
        body: Center(
          child: Padding(
            padding: EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Tienes que iniciar sesión para poder guardar libros en tus listas",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
                Image.asset(
                  "assets/images/special/purple_reading_bunny.png",
                  height: 300,
                )
              ],
            ),
          ),
        ),
      );
    } else {
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
            title: 'Mis listas',
          ),
        ),
        drawer: SideMenu(
          sideMenuColor: _primaryColor,
        ),
        body: Center(
          child: CircularProgressIndicator(
            color: _secondaryColor,
          ),
        ),
      );
    }
  }

  Widget _buildLists(BuildContext context, Map<String, dynamic>? data) {
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
          title: 'Mis listas',
        ),
      ),
      drawer: SideMenu(
        sideMenuColor: _primaryColor,
      ),
      body: SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minHeight: MediaQuery.of(context).size.height,
          ),
          child: Column(
            children: [
              _update(),
              SizedBox(
                height: 10,
              ),
              Container(
                height: MediaQuery.of(context).size.height * 0.4,
                child: _trackingWidget(data),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                height: MediaQuery.of(context).size.height * 0.4,
                child: _wishListWidget(data),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _trackingWidget(Map<String, dynamic>? data) {
    print('\x1B[32m[BookTracker] _trackingWidget: ${data}');
    var physics = (data?["tracking"].length > 1)
        ? BouncingScrollPhysics()
        : NeverScrollableScrollPhysics();
    if (data?["tracking"].length == 0) {
      return Column(
        children: [
          SizedBox(
            height: 12,
          ),
          Text(
            'Seguimientos',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: 12,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Agrega libros a tu lista de seguimiento para que puedas recibir notificaciones sobre su precio y disponibilidad',
              textAlign: TextAlign.center,
            ),
          ),
        ],
      );
    } else {
      return Column(
        children: [
          SizedBox(
            height: 12,
          ),
          Text(
            'Seguimientos',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: 12,
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.3, // 240
            child: PageView.builder(
              controller: controllerT,
              physics: physics,
              itemBuilder: (_, index) {
                //return pages[index % pages.length];
                return TrackingItem(
                  item: data?["tracking"][index % data["tracking"].length],
                );
              },
            ),
          ),
          SizedBox(
            height: 10,
          ),
          SmoothPageIndicator(
            controller: controllerT,
            count: data?["tracking"].length,
            effect: WormEffect(
              dotHeight: 8,
              dotWidth: 16,
              type: WormType.thin,
              activeDotColor: _secondaryColor,
              // strokeWidth: 5,
            ),
          ),
        ],
      );
    }
  }

  Widget _wishListWidget(Map<String, dynamic>? data) {
    var physics = (data?["wish"].length > 1)
        ? BouncingScrollPhysics()
        : NeverScrollableScrollPhysics();
    if (data?["wish"].length == 0) {
      return Column(
        children: [
          SizedBox(
            height: 12,
          ),
          Text(
            'Lista de deseos',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: 12,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Agrega libros a tu lista de deseos para que puedas encontrarlos más fácilmente',
              textAlign: TextAlign.center,
            ),
          ),
        ],
      );
    } else {
      return Column(
        children: [
          SizedBox(
            height: 12,
          ),
          Text(
            'Lista de deseos',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: 12,
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.23, // 180
            child: PageView.builder(
              controller: controllerW,
              physics: physics,
              itemBuilder: (_, index) {
                //return pages[index % pages.length];
                return WishItem(
                  item: data?["wish"][index % data["wish"].length],
                );
              },
            ),
          ),
          SizedBox(
            height: 10,
          ),
          SmoothPageIndicator(
            controller: controllerW,
            count: data?["wish"].length,
            effect: WormEffect(
              dotHeight: 8,
              dotWidth: 16,
              type: WormType.thin,
              activeDotColor: _secondaryColor,
              // strokeWidth: 5,
            ),
          ),
        ],
      );
    }
  }

  BlocConsumer<TrackingBloc, TrackingState> _update() {
    return BlocConsumer(
      builder: (context, state) {
        return Container();
      },
      listener: (context, state) {
        if (state is TrackingUpdated) {
          setState(() {});
        }
      },
    );
  }
}
