import 'package:flutter/material.dart';

class Filter extends StatelessWidget {
  final _primaryColor;
  final _secondaryColor;
  final _tertiaryColor;

  Filter({
    Key? key,
    required Color primary,
    required Color secondary,
    required Color tertiary,
  })  : _primaryColor = primary,
        _secondaryColor = secondary,
        _tertiaryColor = tertiary,
        super(key: key);

  final _filterTitleController = TextEditingController(text: '');
  final _filterAuthorController = TextEditingController(text: '');
  final _filterPublisherController = TextEditingController(text: '');
  bool _filterTitle = false;
  bool _filterAuthor = false;
  bool _filterPublisher = false;
  bool _filterCategory = false;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(_primaryColor),
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        padding: MaterialStateProperty.all(
          EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        ),
        overlayColor:
            MaterialStateColor.resolveWith((states) => _secondaryColor),
      ),
      onPressed: () {
        _showFilterDialog(context);
      },
      child: Row(
        children: [
          Expanded(
            child: Text(
              "Filtros",
              style: TextStyle(
                color: _tertiaryColor,
              ),
            ),
          ),
          Icon(
            Icons.expand_more,
            color: _tertiaryColor,
            size: 20,
          ),
        ],
      ),
    );
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
                  // TODO: Implementar búsqueda avanzada
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
