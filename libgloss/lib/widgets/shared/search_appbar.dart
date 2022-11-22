import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:libgloss/config/routes.dart';

import '../../blocs/search/bloc/search_bloc.dart';

class SearchAppBar extends StatelessWidget {
  SearchAppBar({
    Key? key,
    required Color primaryColor,
    required Color secondaryColor,
    required bool showMenuButton,
    required bool showCameraButton,
    required bool showSearchField,
    bool showBackButton = true,
    String? title,
    String? route,
  })  : _primaryColor = primaryColor,
        _secondaryColor = secondaryColor,
        _showMenuButton = showMenuButton,
        _showCameraButton = showCameraButton,
        _showSearchField = showSearchField,
        _textFieldController = TextEditingController(),
        _title = title,
        _backButton = showBackButton,
        _route = route,
        super(key: key);

  final TextEditingController _textFieldController;
  final Color _primaryColor;
  final Color _secondaryColor;
  final bool _showMenuButton;
  final bool _showCameraButton;
  final bool _showSearchField;
  final bool _backButton;
  final String? _title;
  final String? _route;

  // Advanced search
  final _filterTitleController = TextEditingController(text: '');
  final _filterAuthorController = TextEditingController(text: '');
  final _filterPublisherController = TextEditingController(text: '');
  bool _filterTitle = false;
  bool _filterAuthor = false;
  bool _filterPublisher = false;
  bool _filterCategory = false;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: _primaryColor,
      toolbarHeight: 80,
      automaticallyImplyLeading: false,
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: _primaryColor,
        statusBarIconBrightness: Brightness.dark,
      ),
      flexibleSpace: SafeArea(
        child: _buildSearchBar(context),
      ),
    );
  }

  Widget _buildSearchBar(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            if (_showMenuButton)
              Container(
                width: MediaQuery.of(context).size.width * 0.12,
                child: IconButton(
                  icon: Icon(Icons.menu),
                  onPressed: () {
                    Scaffold.of(context).openDrawer();
                  },
                ),
              ),
            if (!_showMenuButton)
              Container(
                height: 48,
                child: _popIcon(context),
              ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.83,
                  height: 30,
                  child: _buildSearchField(context),
                ),
              ],
            )
          ],
        ),
        Row(
          children: [
            Column(
              children: [
                Container(
                  height: 32,
                  width: MediaQuery.of(context).size.width,
                  alignment: Alignment.topLeft,
                  color: _secondaryColor,
                  child: Container(
                    margin: EdgeInsets.only(left: 12),
                    child: Image.asset(
                      'assets/images/icon/onlybunny.png',
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildSearchField(context) {
    if (!_showSearchField)
      return Container(
        alignment: Alignment.center,
        child: Padding(
          padding: const EdgeInsets.only(left: 48.0),
          child: Text(
            _title!,
            style: TextStyle(
              color: Colors.black,
              fontSize: 18,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      );
    else
      return TextField(
        textAlign: TextAlign.left,
        textAlignVertical: TextAlignVertical(y: 1),
        controller: _textFieldController,
        onSubmitted: (value) {
          // TODO: Add filters to search
          Map<String, dynamic> filters = {};

          if (kDebugMode) {
            print(
                "\u001b[32m[SearchAppBar] Received route: ${_route}\u001b[0m");
            print(
                "\u001b[32m[SearchAppBar] Search query is ${_textFieldController.text}");
            print("\u001b[32m[SearchAppBar] Filters are ${filters.toString()}");
            print(
                "\u001b[32m[SearchAppBar] Current page is ${ModalRoute.of(context)?.settings.name}");
          }
          if (_route == LibglossRoutes.HOME_NEW) {
            Navigator.pushNamed(
              context,
              LibglossRoutes.SEARCH_NEW,
              arguments: filters,
            );
          }

          print(_route == LibglossRoutes.HOME);
          if (LibglossRoutes.CURRENT_ROUTE == LibglossRoutes.HOME_USED) {
            Navigator.pushNamed(
              context,
              LibglossRoutes.SEARCH_USED,
              arguments: filters,
            );
          }

          BlocProvider.of<SearchBloc>(context).add(
            SearchBoookEvent(
              query: value,
              filters: filters,
            ),
          );
        },
        decoration: InputDecoration(
          hintText: "Buscar en Libgloss",
          suffixIcon: _showCameraButton
              ? Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    GestureDetector(
                      child: Icon(
                        Icons.camera_alt,
                        color: Color.fromARGB(255, 53, 53, 53),
                      ),
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          LibglossRoutes.SCANNER,
                        );
                      },
                    ),
                    SizedBox(
                      width: 16,
                    ),
                    _showMenuButton == false
                        ? Container()
                        : GestureDetector(
                            child: FaIcon(
                              FontAwesomeIcons.magnifyingGlassPlus,
                              color: Color.fromARGB(255, 53, 53, 53),
                              size: 20,
                            ),
                            onTap: () {
                              _showFilterDialog(context);
                            },
                          ),
                    SizedBox(
                      width: 16,
                    ),
                  ],
                )
              : null,
          hintStyle: TextStyle(
            fontSize: 15,
          ),
          fillColor: Colors.white,
          filled: true,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide(
              width: 0,
              style: BorderStyle.none,
            ),
          ),
        ),
      );
  }

  Widget? _popIcon(BuildContext context) {
    if (_backButton) {
      return IconButton(
        icon: Icon(Icons.arrow_back),
        onPressed: () {
          Navigator.pop(context);
          switch (LibglossRoutes.CURRENT_ROUTE) {
            case LibglossRoutes.SEARCH_NEW:
              LibglossRoutes.CURRENT_ROUTE = LibglossRoutes.HOME;
              break;
            case LibglossRoutes.SEARCH_USED:
              LibglossRoutes.CURRENT_ROUTE = LibglossRoutes.HOME_USED;
              break;
          }
        },
      );
    }
    return null;
  }

  void _showFilterDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: ((context) {
        return StatefulBuilder(builder: ((context, setState) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(25.0))),
            contentPadding: EdgeInsets.all(22.0),
            title: Text('Búsqueda avanzada',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Checkbox(
                          value: _filterTitle,
                          activeColor: _secondaryColor,
                          onChanged: ((value) {
                            if (_filterTitle) {
                              setState(() {
                                _filterTitleController.clear();
                                _filterTitle = false;
                              });
                            } else {
                              showDialog(
                                context: context,
                                builder: ((context) {
                                  return AlertDialog(
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(25.0))),
                                    contentPadding: EdgeInsets.all(22.0),
                                    title: Text('Título',
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold)),
                                    content: TextField(
                                      controller: _filterTitleController,
                                      decoration: InputDecoration(
                                        hintText: 'Título',
                                      ),
                                    ),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: Text('Cancelar'),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          if (_filterTitleController
                                              .text.isNotEmpty) {
                                            setState(() {
                                              Navigator.of(context).pop();
                                              _filterTitle = value!;
                                            });
                                          } else {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(SnackBar(
                                              content: Text(
                                                  'El campo no puede estar vacío'),
                                            ));
                                            setState(() {
                                              _filterTitle = false;
                                            });
                                          }
                                        },
                                        child: Text('Aceptar'),
                                      ),
                                    ],
                                  );
                                }),
                              );
                            }
                          }),
                        ),
                        Text(
                          'Título',
                          textAlign: TextAlign.start,
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 16.0),
                          child: _filterTitleText(context, setState),
                        ),
                      ],
                    ),
                  ],
                ),
                Row(
                  children: [
                    Checkbox(
                      value: _filterCategory,
                      activeColor: _secondaryColor,
                      onChanged: ((value) {
                        setState(() {
                          _filterCategory = value!;
                        });
                      }),
                    ),
                    Text(
                      'Categoría',
                      textAlign: TextAlign.start,
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Checkbox(
                          value: _filterAuthor,
                          activeColor: _secondaryColor,
                          onChanged: ((value) {
                            if (_filterAuthor) {
                              setState(() {
                                _filterAuthorController.clear();
                                _filterAuthor = false;
                              });
                            } else {
                              showDialog(
                                context: context,
                                builder: ((context) {
                                  return AlertDialog(
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(25.0))),
                                    contentPadding: EdgeInsets.all(22.0),
                                    title: Text('Autor',
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold)),
                                    content: TextField(
                                      controller: _filterAuthorController,
                                      decoration: InputDecoration(
                                        hintText: 'Autor',
                                      ),
                                    ),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: Text('Cancelar'),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          if (_filterAuthorController
                                              .text.isNotEmpty) {
                                            setState(() {
                                              Navigator.of(context).pop();
                                              _filterAuthor = value!;
                                            });
                                          } else {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(SnackBar(
                                              content: Text(
                                                  'El campo no puede estar vacío'),
                                            ));
                                            setState(() {
                                              _filterAuthor = false;
                                            });
                                          }
                                        },
                                        child: Text('Aceptar'),
                                      ),
                                    ],
                                  );
                                }),
                              );
                            }
                          }),
                        ),
                        Text(
                          'Autor',
                          textAlign: TextAlign.start,
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 16.0),
                          child: _filterAuthorText(context, setState),
                        ),
                      ],
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Checkbox(
                          value: _filterPublisher,
                          activeColor: _secondaryColor,
                          onChanged: ((value) {
                            if (_filterPublisher) {
                              setState(() {
                                _filterPublisherController.clear();
                                _filterPublisher = false;
                              });
                            } else {
                              showDialog(
                                context: context,
                                builder: ((context) {
                                  return AlertDialog(
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(25.0))),
                                    contentPadding: EdgeInsets.all(22.0),
                                    title: Text('Editorial',
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold)),
                                    content: TextField(
                                      controller: _filterPublisherController,
                                      decoration: InputDecoration(
                                        hintText: 'Editorial',
                                      ),
                                    ),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: Text('Cancelar'),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          if (_filterPublisherController
                                              .text.isNotEmpty) {
                                            setState(() {
                                              Navigator.of(context).pop();
                                              _filterPublisher = value!;
                                            });
                                          } else {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(SnackBar(
                                              content: Text(
                                                  'El campo no puede estar vacío'),
                                            ));
                                            setState(() {
                                              _filterPublisher = false;
                                            });
                                          }
                                        },
                                        child: Text('Aceptar'),
                                      ),
                                    ],
                                  );
                                }),
                              );
                            }
                          }),
                        ),
                        Text(
                          'Editorial',
                          textAlign: TextAlign.start,
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 16.0),
                          child: _filterPublisherText(context, setState),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('Cancelar'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  Navigator.pushNamed(context, LibglossRoutes.SEARCH_NEW);
                  BlocProvider.of<SearchBloc>(context).add(
                    SearchBoookEvent(
                      query: _filterTitleController.text,
                      filters: {
                        'author': _filterAuthorController.text,
                        'publisher': _filterPublisherController.text,
                      },
                    ),
                  );
                },
                child: Text('Buscar'),
              ),
            ],
          );
        }));
      }),
    );
  }

  Widget _filterPublisherText(BuildContext context, StateSetter setState) {
    if (_filterPublisher) {
      return GestureDetector(
        onTap: () {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(25.0))),
                contentPadding: EdgeInsets.all(22.0),
                title: Text('Editorial',
                    style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                content: TextField(
                  controller: _filterPublisherController,
                  decoration: InputDecoration(
                    hintText: 'Editorial',
                  ),
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text('Cancelar'),
                  ),
                  TextButton(
                    onPressed: () {
                      if (_filterPublisherController.text.isNotEmpty) {
                        setState(() {
                          Navigator.of(context).pop();
                        });
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text('El campo no puede estar vacío'),
                        ));
                      }
                    },
                    child: Text('Aceptar'),
                  ),
                ],
              );
            },
          );
        },
        child: Text(
          _filterPublisherController.text,
          style: TextStyle(
            color: _secondaryColor,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
      );
    } else {
      return Container();
    }
  }

  Widget _filterAuthorText(BuildContext context, StateSetter setState) {
    if (_filterAuthor) {
      return GestureDetector(
        onTap: () {
          showDialog(
            context: context,
            builder: ((context) {
              return AlertDialog(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(25.0))),
                contentPadding: EdgeInsets.all(22.0),
                title: Text('Autor',
                    style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                content: TextField(
                  controller: _filterAuthorController,
                  decoration: InputDecoration(
                    hintText: 'Autor',
                  ),
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text('Cancelar'),
                  ),
                  TextButton(
                    onPressed: () {
                      if (_filterAuthorController.text.isNotEmpty) {
                        setState(() {
                          Navigator.of(context).pop();
                        });
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text('El campo no puede estar vacío'),
                        ));
                      }
                    },
                    child: Text('Aceptar'),
                  ),
                ],
              );
            }),
          );
        },
        child: Text(
          _filterAuthorController.text,
          style: TextStyle(
            color: _secondaryColor,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
      );
    }
    return Container();
  }

  Widget _filterTitleText(BuildContext context, setState) {
    if (_filterTitle) {
      return GestureDetector(
        onTap: () {
          showDialog(
            context: context,
            builder: ((context) {
              return AlertDialog(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(25.0))),
                contentPadding: EdgeInsets.all(22.0),
                title: Text('Título',
                    style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                content: TextField(
                  controller: _filterTitleController,
                  decoration: InputDecoration(
                    hintText: 'Título',
                  ),
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      setState(() {
                        _filterTitle = false;
                      });
                    },
                    child: Text('Cancelar'),
                  ),
                  TextButton(
                    onPressed: () {
                      if (_filterTitleController.text.isNotEmpty) {
                        Navigator.of(context).pop();
                        setState(() {
                          _filterTitle = true;
                          _filterTitleText(context, setState);
                        });
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text('El campo no puede estar vacío'),
                        ));
                      }
                    },
                    child: Text('Aceptar'),
                  ),
                ],
              );
            }),
          );
        },
        child: Text(
          _filterTitleController.text,
          style: TextStyle(
            color: _secondaryColor,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
      );
    } else {
      return Container();
    }
  }
}
