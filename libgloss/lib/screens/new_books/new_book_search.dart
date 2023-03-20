import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:libgloss/blocs/search/bloc/search_bloc.dart';
import 'package:libgloss/blocs/stores/amazon/bloc/amazon_store_bloc.dart';
import 'package:libgloss/blocs/stores/el_sotano/bloc/el_sotano_store_bloc.dart';
import 'package:libgloss/blocs/stores/gandhi/bloc/gandhi_store_bloc.dart';
import 'package:libgloss/blocs/stores/gonvill/bloc/gonvill_store_bloc.dart';
import 'package:libgloss/config/app_color.dart';
import 'package:libgloss/config/routes.dart';
import 'package:libgloss/widgets/animations/loading_animation.dart';
import 'package:libgloss/widgets/shared/online_image.dart';
import 'package:libgloss/widgets/shared/search_appbar.dart';
import 'package:libgloss/widgets/shared/side_menu.dart';

class NewBookSearch extends StatefulWidget {
  const NewBookSearch({super.key});

  @override
  _NewBookSearchState createState() => _NewBookSearchState();
}

class _NewBookSearchState extends State<NewBookSearch> {
  final Color _primaryColor = AppColor.getPrimary(Routes.home);
  final Color _secondaryColor = AppColor.getSecondary(Routes.home);
  final Color _blueColor = AppColor.getTertiary(Routes.home);

  String _initialFilter = 'Más relevantes';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(80),
        child: SearchAppBar(
          primaryColor: _primaryColor,
          secondaryColor: _secondaryColor,
          showMenuButton: false,
          showCameraButton: true,
          showSearchField: true,
          route: Routes.home,
        ),
      ),
      drawer: SideMenu(
        sideMenuColor: _primaryColor,
        route: Routes.home,
      ),
      body: _searchBook(context),
    );
  }

  BlocConsumer<SearchBloc, SearchState> _searchBook(BuildContext context) {
    return BlocConsumer<SearchBloc, SearchState>(
      listener: (context, state) {
        if (state is SearchError) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Text(state.message),
              ),
            );
        }
      },
      builder: (context, state) {
        switch (state.runtimeType) {
          case SearchInitial:
            return Container();
          case SearchLoading:
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  LoadingAnimation(animationColor: _secondaryColor),
                  Image.asset(
                    'assets/images/loading/loading_bunny_blue.gif',
                  ),
                ],
              ),
            );
          case SearchLoaded:
            return _search(context, state.props[0] as List<dynamic>);
          default:
            return Container();
        }
      },
    );
  }

  Column _search(BuildContext context, List<dynamic> books) {
    return Column(
      children: [
        Expanded(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    'Ordenar por:',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: _blueColor,
                    ),
                  ),
                  const SizedBox(width: 10),
                  DropdownButton<String>(
                    value: _initialFilter,
                    icon: const Icon(Icons.arrow_drop_down),
                    elevation: 16,
                    borderRadius: BorderRadius.circular(10),
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.w300,
                    ),
                    underline: Container(
                      height: 2,
                      color: _blueColor,
                    ),
                    onChanged: (String? newValue) {
                      setState(() {
                        _initialFilter = newValue!;
                      });
                    },
                    items: [
                      'Más relevantes',
                      'Mejor calificación',
                      'Peor calificación',
                    ].map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                  const SizedBox(width: 10),
                ],
              ),
              Divider(color: _blueColor, thickness: 1, height: 1),
              _found(context, books),
            ],
          ),
        ),
      ],
    );
  }

  Expanded _found(BuildContext context, List<dynamic> books) {
    List<dynamic> _books = [...books];

    switch (_initialFilter) {
      case "Mejor calificación":
        _books.sort((a, b) => (b['rating'] ?? 0).compareTo(a['rating'] ?? 0));
        break;
      case "Peor calificación":
        print("\u001b[32m[Filter] Sorting by worst rating");
        _books.sort(
          (a, b) => (a["rating"] == null)
              ? 1
              : (b["rating"] == null)
                  ? -1
                  : a["rating"]!.compareTo(b["rating"]!),
        );
        break;
    }

    return Expanded(
      child: SizedBox(
        child: GridView.builder(
          padding: const EdgeInsets.all(20),
          physics: const ScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 18,
            childAspectRatio: MediaQuery.of(context).size.width /
                (MediaQuery.of(context).size.height / 1.5),
          ),
          itemCount: _books.length,
          itemBuilder: (BuildContext context, int index) {
            return Container(
              //color: Colors.teal[100],
              child: Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      BlocProvider.of<AmazonStoreBloc>(context).add(
                        AmazonPriceEvent(
                          bookId: _books[index]["isbn"],
                        ),
                      );
                      BlocProvider.of<ElSotanoStoreBloc>(context).add(
                        ElSotanoPriceEvent(
                          bookId: _books[index]["isbn"],
                        ),
                      );
                      BlocProvider.of<GandhiStoreBloc>(context).add(
                        GandhiPriceEvent(
                          bookId: _books[index]["isbn"],
                        ),
                      );
                      BlocProvider.of<GonvillStoreBloc>(context).add(
                        GonvillPriceEvent(
                          bookId: _books[index]["isbn"],
                        ),
                      );
                      Navigator.pushNamed(
                        context,
                        Routes.newBookDetails,
                        arguments: _books[index],
                      );
                    },
                    child: Container(
                      height: (MediaQuery.of(context).size.height / 6),
                      child: OnlineImage(
                        imageUrl: _books[index]["thumbnail"] != null
                            ? _books[index]["thumbnail"]
                            : "https://vip12.hachette.co.uk/wp-content/uploads/2018/07/missingbook.png",
                        height: MediaQuery.of(context).size.height / 3.5,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Text(
                    "${_books[index]["title"]}",
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    style: const TextStyle(
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    "${_books[index]["authors"].join(', ')}",
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: _blueColor,
                      fontSize: 12,
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (_books[index]["rating"] != null)
                        // Display rating, use half stars if decimal
                        RatingBarIndicator(
                          rating: _books[index]["rating"]!.toDouble(),
                          itemBuilder: (context, index) {
                            return const Icon(
                              Icons.star,
                              color: Color.fromARGB(255, 213, 131, 22),
                            );
                          },
                          itemSize: 24.0,
                        ),
                      if (_books[index]["rating"] == null)
                        const Text(
                          "Sin calificación",
                          style: TextStyle(
                            color: Colors.black87,
                            fontSize: 12,
                          ),
                        ),
                    ],
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
