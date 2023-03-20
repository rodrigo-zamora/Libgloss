import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:libgloss/blocs/stores/amazon/bloc/amazon_store_bloc.dart';
import 'package:libgloss/blocs/stores/el_sotano/bloc/el_sotano_store_bloc.dart';
import 'package:libgloss/blocs/stores/gandhi/bloc/gandhi_store_bloc.dart';
import 'package:libgloss/blocs/stores/gonvill/bloc/gonvill_store_bloc.dart';
import 'package:libgloss/config/app_color.dart';
import 'package:libgloss/config/routes.dart';
import 'package:libgloss/widgets/shared/online_image.dart';
import 'package:libgloss/widgets/shared/search_appbar.dart';
import 'package:libgloss/widgets/shared/side_menu.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class NewBookDetails extends StatefulWidget {
  const NewBookDetails({
    super.key,
  });

  @override
  State<NewBookDetails> createState() => _NewBookDetailsState();
}

class _NewBookDetailsState extends State<NewBookDetails> {
  final Color _primaryColor = AppColor.getPrimary(Routes.home);
  final Color _secondaryColor = AppColor.getSecondary(Routes.home);
  final Color _quaternaryColor = AppColor.getQuaternary(Routes.home);
  final Color _blueColor = AppColor.getTertiary(Routes.home);
  final Color _redColor = AppColor.red;
  final Color _defaultColor = AppColor.black;
  final Color _greyColor = AppColor.gray;

  final TextEditingController _priceController = TextEditingController();
  int _monthsTracking = 0;
  String _storeTracking = '';

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments;
    args as Map<String, dynamic>;

    BlocProvider.of<AmazonStoreBloc>(context).add(
      AmazonPriceEvent(
        bookId: args["isbn"] as String,
      ),
    );

    BlocProvider.of<ElSotanoStoreBloc>(context).add(
      ElSotanoPriceEvent(
        bookId: args["isbn"] as String,
      ),
    );

    BlocProvider.of<GandhiStoreBloc>(context).add(
      GandhiPriceEvent(
        bookId: args["isbn"] as String,
      ),
    );

    BlocProvider.of<GonvillStoreBloc>(context).add(
      GonvillPriceEvent(
        bookId: args["isbn"] as String,
      ),
    );

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(80),
        child: SearchAppBar(
          primaryColor: _primaryColor,
          secondaryColor: _secondaryColor,
          showMenuButton: false,
          showCameraButton: false,
          showSearchField: true,
          route: Routes.home,
        ),
      ),
      drawer: SideMenu(
        sideMenuColor: _primaryColor,
        route: Routes.home,
      ),
      body: _main(context, args),
    );
  }

  SingleChildScrollView _main(BuildContext context, Map<String, dynamic> args) {
    return SingleChildScrollView(
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.only(
          left: 30.0,
          right: 30.0,
          top: 15.0,
          bottom: 15.0,
        ),
        child: Column(
          //crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _text(
              "${args["title"]}",
              _defaultColor,
              20.0,
              FontWeight.bold,
              TextAlign.center,
            ),
            const SizedBox(height: 5),
            _text(
              "${args["authors"].join(', ')}",
              _blueColor,
              15.0,
              FontWeight.normal,
              TextAlign.center,
            ),
            const SizedBox(height: 5),
            _text(
              "${args["isbn"]}",
              _defaultColor,
              15.0,
              FontWeight.normal,
              TextAlign.center,
            ),
            const SizedBox(height: 20.0),
            _image(
              args["thumbnail"] != null
                  ? args["thumbnail"] as String
                  : "https://vip12.hachette.co.uk/wp-content/uploads/2018/07/missingbook.png",
            ),
            const SizedBox(height: 20.0),
            Container(
              child: _getPrices(),
            ),
            const SizedBox(height: 20.0),
            GestureDetector(
              onTap: () {
                _wishList(context, args);
              },
              child: Container(
                padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                alignment: Alignment.topLeft,
                child: _text(
                  "Agregar a Lista de Deseos",
                  _blueColor,
                  15.0,
                  FontWeight.bold,
                  TextAlign.left,
                ),
              ),
            ),
            const SizedBox(height: 15.0),
            GestureDetector(
              onTap: () {
                _tracking(context, args);
              },
              child: Container(
                padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                alignment: Alignment.topLeft,
                child: _text(
                  "Hacer Seguimiento de Libro",
                  _blueColor,
                  15.0,
                  FontWeight.bold,
                  TextAlign.left,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _text(
    String text,
    Color color,
    double size,
    FontWeight weight,
    TextAlign align,
  ) {
    final isPrice = double.tryParse(text);
    if (isPrice == null || isPrice > 99999) {
      return Text(
        text,
        textAlign: align,
        style: TextStyle(
          fontSize: size,
          fontWeight: weight,
          color: color,
        ),
      );
    } else {
      final double price = double.parse(text);
      final int priceInt = price.toInt();
      final int priceDec = ((price - priceInt) * 100).toInt();
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "\$$priceInt",
            textAlign: align,
            style: TextStyle(
              fontSize: size,
              fontWeight: weight,
              color: color,
            ),
          ),
          Text(
            ".",
            textAlign: align,
            style: TextStyle(
              fontSize: size,
              fontWeight: weight,
              color: color,
            ),
          ),
          Text(
            priceDec < 10 ? "0$priceDec" : "$priceDec",
            textAlign: align,
            style: TextStyle(
              fontSize: size - 5,
              fontWeight: weight,
              color: color,
            ),
          ),
        ],
      );
    }
  }

  SizedBox _image(String image) {
    return SizedBox(
      height: MediaQuery.of(context).size.height / 2.5,
      child: OnlineImage(
        imageUrl: image,
        height: 100,
      ),
    );
  }

  Future<void> _launchURL(String url) async {
    final arguments = {
      "url": url,
    };
    Navigator.pushNamed(context, Routes.webViewScreen, arguments: arguments);
  }

  Widget _getPrices() {
    return GridView.count(
      shrinkWrap: true,
      crossAxisCount: 2,
      childAspectRatio: 1.5,
      children: [
        BlocBuilder<AmazonStoreBloc, AmazonStoreState>(
          builder: (context, state) {
            if (state is AmazonStoreLoading) {
              return _loading();
            } else if (state is AmazonStoreLoaded) {
              final result = state.props[0] as Map<String, dynamic>;
              final price = result["amazon"] != null
                  ? result["amazon"]["price"].toString()
                  : "No disponible";
              final String url = result["amazon"] != null
                  ? result["amazon"]["url"] as String
                  : "";
              return _priceCard(price, "Amazon", url);
            } else {
              return _priceCard("No disponible", "Amazon", "");
            }
          },
        ),
        BlocBuilder<ElSotanoStoreBloc, ElSotanoStoreState>(
          builder: (context, state) {
            if (state is ElSotanoStoreLoading) {
              return _loading();
            } else if (state is ElSotanoStoreLoaded) {
              final result = state.props[0] as Map<String, dynamic>;
              final price = result["el_sotano"] != null
                  ? result["el_sotano"]["price"].toString()
                  : "No disponible";
              final String url = result["el_sotano"] != null
                  ? result["el_sotano"]["url"] as String
                  : "";
              return _priceCard(price, "El Sotano", url);
            } else {
              return _priceCard("No disponible", "El Sotano", "");
            }
          },
        ),
        BlocBuilder<GandhiStoreBloc, GandhiStoreState>(
          builder: (context, state) {
            if (state is GandhiStoreLoading) {
              return _loading();
            } else if (state is GandhiStoreLoaded) {
              final result = state.props[0] as Map<String, dynamic>;
              final price = result["gandhi"] != null
                  ? result["gandhi"]["price"].toString()
                  : "No disponible";
              final String url = result["gandhi"] != null
                  ? result["gandhi"]["url"] as String
                  : "";
              return _priceCard(price, "Gandhi", url);
            } else {
              return _priceCard("No disponible", "Gandhi", "");
            }
          },
        ),
        BlocBuilder<GonvillStoreBloc, GonvillStoreState>(
          builder: (context, state) {
            if (state is GonvillStoreLoading) {
              return _loading();
            } else if (state is GonvillStoreLoaded) {
              final result = state.props[0] as Map<String, dynamic>;
              final price = result["gonvill"] != null
                  ? result["gonvill"]["price"].toString()
                  : "No disponible";
              final String url = result["gonvill"] != null
                  ? result["gonvill"]["url"] as String
                  : "";
              return _priceCard(price, "Gonvill", url);
            } else {
              return _priceCard("No disponible", "Gonvill", "");
            }
          },
        ),
      ],
    );
  }

  Widget _priceCard(String price, String store, String url) {
    return GestureDetector(
      onTap: () {
        if (url != "") {
          _launchURL(url);
        }
      },
      child: Card(
        elevation: 4, // the size of the shadow
        shadowColor: _greyColor, // shadow color
        color: _quaternaryColor, // the color of the card
        shape: RoundedRectangleBorder(
          // the shape of the card
          borderRadius: const BorderRadius.all(
            Radius.circular(
              15,
            ),
          ), // the radius of the border, made to be circular
          side: BorderSide(color: _secondaryColor, width: 0.5),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                child: _text(
                  store,
                  price != "No disponible" ? _blueColor : _redColor,
                  15.0,
                  FontWeight.bold,
                  TextAlign.center,
                ),
              ),
              const SizedBox(height: 5),
              _text(
                price,
                _defaultColor,
                15.0,
                FontWeight.normal,
                TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _loading() {
    return Card(
      elevation: 4, // the size of the shadow
      shadowColor: _greyColor, // shadow color
      color: _quaternaryColor, // the color of the card
      shape: const RoundedRectangleBorder(
        // the shape of the card
        borderRadius: BorderRadius.all(
          Radius.circular(
            15,
          ),
        ), // the radius of the border, made to be circular
      ),
      child: LoadingAnimationWidget.fourRotatingDots(
        color: _secondaryColor,
        size: MediaQuery.of(context).size.height /
            MediaQuery.of(context).size.width *
            20,
      ),
    );
  }

  Future<dynamic> _tracking(BuildContext context, Map<String, dynamic> args) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Seguimiento del libro"),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(25.0)),
          ),
          contentPadding: const EdgeInsets.all(22.0),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text("Agrega los siguientes datos para poder "
                  "seguir el libro"),
              Form(
                child: Column(
                  children: [
                    TextFormField(
                      controller: _priceController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        labelText: "Precio",
                      ),
                    ),
                    DropdownButtonFormField(
                      items: const [
                        DropdownMenuItem(
                          value: "all",
                          child: Text("Todas las tiendas"),
                        ),
                        DropdownMenuItem(
                          value: "amazon",
                          child: Text("Amazon"),
                        ),
                        DropdownMenuItem(
                          value: "gandhi",
                          child: Text("Gandhi"),
                        ),
                        DropdownMenuItem(
                          value: "gonvill",
                          child: Text("Gonvill"),
                        ),
                        DropdownMenuItem(
                          value: "el_sotano",
                          child: Text("El Sótano"),
                        ),
                      ],
                      onChanged: (value) {
                        _storeTracking = value!;
                      },
                      decoration: const InputDecoration(
                        labelText: "Tienda",
                      ),
                    ),
                    DropdownButtonFormField(
                      items: const [
                        DropdownMenuItem(
                          value: 1,
                          child: Text("1 mes"),
                        ),
                        DropdownMenuItem(
                          value: 3,
                          child: Text("3 meses"),
                        ),
                        DropdownMenuItem(
                          value: 6,
                          child: Text("6 meses"),
                        ),
                        DropdownMenuItem(
                          value: 12,
                          child: Text("1 año"),
                        ),
                      ],
                      onChanged: (value) {
                        _monthsTracking = value!;
                      },
                      decoration: const InputDecoration(
                        labelText: "Tiempo",
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("Cancelar"),
            ),
            TextButton(
              onPressed: () async {
                Navigator.of(context).pop();

                // TODO: Add tracking using Amplify
              },
              child: const Text("Agregar"),
            )
          ],
        );
      },
    );
  }

  Future<dynamic> _wishList(BuildContext context, Map<String, dynamic> args) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Agregar a la lista de deseos"),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(25.0)),
          ),
          contentPadding: const EdgeInsets.all(22.0),
          content: const Text(
            "¿Estás seguro que deseas agregar este libro a tu lista de deseos?",
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("Cancelar"),
            ),
            TextButton(
              onPressed: () async {
                Navigator.of(context).pop();

                // TODO: Add to wish list using Amplify
              },
              child: const Text("Agregar"),
            ),
          ],
        );
      },
    );
  }
}
