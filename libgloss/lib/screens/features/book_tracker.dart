import 'package:flutter/material.dart';
import 'package:libgloss/config/routes.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../widgets/shared/bottom_navigation.dart';
import '../../widgets/shared/search_appbar.dart';
import '../../widgets/shared/side_menu.dart';

import 'tracking_item.dart';
import 'wish_item.dart';

class BookTracker extends StatelessWidget {
  final Color _primaryColor = Color.fromRGBO(244, 210, 255, 1);
  final Color _secondaryColor = Color.fromRGBO(215, 132, 243, 1);
  final Color _blueColor = Color.fromRGBO(16, 112, 130, 1);

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
    return Scaffold(
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
      body: Column(
        children: [
          SizedBox(
            child: _trackingWidget(),
          ),
          SizedBox(height: 20,),
          SizedBox(
            child: _wishListWidget(),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigation(
          selectedItem: LibglossRoutes.BOOK_TRACKER,
          iconColor: _secondaryColor),
    );
  }

  Widget _trackingWidget() {
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
              return TrackingItem(item: _listSeguimientos[index % _listSeguimientos.length]);
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

  Widget _wishListWidget() {
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
