import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:libgloss/config/routes.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../config/colors.dart';
import '../../repositories/auth/user_auth_repository.dart';
import '../../widgets/shared/search_appbar.dart';
import '../../widgets/shared/side_menu.dart';

import 'tracking_item.dart';
import 'wish_item.dart';

class BookTracker extends StatelessWidget {
  final Color _primaryColor =
      ColorSelector.getPrimary(LibglossRoutes.BOOK_TRACKER);
  final Color _secondaryColor =
      ColorSelector.getSecondary(LibglossRoutes.BOOK_TRACKER);
  final Color _blueColor = ColorSelector.getTertiary(LibglossRoutes.HOME);

  BookTracker({super.key});
  final controllerT = PageController(viewportFraction: 0.8, keepPage: true);
  final controllerW = PageController(viewportFraction: 0.8, keepPage: true);

  final List<Map<String, String>> _listSeguimientos = [
    {
      "title": "Pet Sematary",
      "author": "Stephen King",
      "image": "https://m.media-amazon.com/images/I/713xSwL4TyL.jpg",
      "precio": "150.00",
      "plataforma": "cualquier plataforma",
      "tiempo": "3 meses",
    },
    {
      "title": "Loveless",
      "author": "Alice Oseman",
      "image": "https://m.media-amazon.com/images/I/61PpXmjK2KL.jpg",
      "precio": "250.00",
      "plataforma": "cualquier plataforma",
      "tiempo": "6 meses",
    },
    {
      "title": "Bloom",
      "author": "Kevin Panetta",
      "image": "https://m.media-amazon.com/images/I/91Sia1ZLldL.jpg",
      "precio": "190.00",
      "plataforma": "cualquier plataforma",
      "tiempo": "4 meses",
    },
  ];

  late final List<Map<String, String>> _wishList = [
    {
      "title": "Gone Girl",
      "author": "Gillian Flynn",
      "image": "https://m.media-amazon.com/images/I/81g5ooiHAXL.jpg",
    },
    {
      "title": "The Girl from the Sea",
      "author": "Molly Knox Ostertag",
      "image": "https://m.media-amazon.com/images/I/71Dnpq3Tt-L.jpg",
    },
    {
      "title": "The Lord of the Rings",
      "author": "J.R.R. Tolkien",
      "image":
          "https://m.media-amazon.com/images/I/51kfFS5-fnL._SX332_BO1,204,203,200_.jpg",
    },
  ];

  @override
  Widget build(BuildContext context) {
    CollectionReference lists = FirebaseFirestore.instance.collection('lists');

    print(
        "\x1B[32m[BookTracker] User: ${UserAuthRepository.userInstance?.currentUser?.uid}");

    String useruid = UserAuthRepository.userInstance?.currentUser?.uid ?? "";

    if (useruid == "") {
      return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(80),
          child: SearchAppBar(
            primaryColor: _primaryColor,
            secondaryColor: _secondaryColor,
            showMenuButton: true,
            showCameraButton: false,
            showSearchField: true,
          ),
        ),
        drawer: SideMenu(
          sideMenuColor: _primaryColor,
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Text(
              "Tienes que iniciar sesión para poder guardar libros en tus listas",
              textAlign: TextAlign.center,
            ),
          ),
        ),
      );
    } else {
      return FutureBuilder<DocumentSnapshot>(
        // Get the documents where useruid is equal to the uid
        future: lists
            .where('useruid',
                isEqualTo: UserAuthRepository.userInstance?.currentUser?.uid)
            .get()
            .then((value) => value.docs[0].reference.get()),
        builder:
            (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text("Something went wrong");
          }

          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasData) {
              Map<String, dynamic>? data =
                  snapshot.data!.data() as Map<String, dynamic>?;
              print('\x1B[32mdata from firestore: ${data}');
              return _buildLists(context, data);
            }
          }

          return Center(
            child: CircularProgressIndicator(),
          );
        },
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
          showMenuButton: true,
          showCameraButton: false,
          showSearchField: true,
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
              SizedBox(
                child: _trackingWidget(data),
              ),
              SizedBox(
                height: 20,
              ),
              SizedBox(
                child: _wishListWidget(data),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _trackingWidget(Map<String, dynamic>? data) {
    if (data == null) {
      return Column(
        children: [
          Text(
            'No hay libros en seguimiento',
            style: TextStyle(
              color: _blueColor,
              fontSize: 20,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            'Agrega libros a tu lista de seguimiento para que puedas recibir notificaciones sobre su precio y disponibilidad',
            style: TextStyle(
              color: _blueColor,
              fontSize: 20,
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
            height: 240,
            child: PageView.builder(
              controller: controllerT,
              itemBuilder: (_, index) {
                //return pages[index % pages.length];
                return TrackingItem(
                    item: _listSeguimientos[index % _listSeguimientos.length]);
              },
            ),
          ),
          SizedBox(
            height: 10,
          ),
          SmoothPageIndicator(
            controller: controllerT,
            count: _listSeguimientos.length,
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
          height: 180,
          child: PageView.builder(
            controller: controllerW,
            itemBuilder: (_, index) {
              //return pages[index % pages.length];
              return WishItem(item: _wishList[index % _wishList.length]);
            },
          ),
        ),
        SizedBox(
          height: 10,
        ),
        SmoothPageIndicator(
          controller: controllerW,
          count: _wishList.length,
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
