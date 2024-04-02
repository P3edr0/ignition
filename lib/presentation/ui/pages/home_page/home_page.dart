import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:ignition/domain/entities/user_entity.dart';
import 'package:ignition/presentation/ui/components/project_dialogs_widget.dart';
import 'package:ignition/presentation/ui/controller/home_controller.dart';
import 'package:ignition/presentation/ui/pages/home_page/home_components/insert_user_dialog.dart';
import 'package:ignition/presentation/ui/pages/home_page/home_components/load_component.dart';
import 'package:ignition/presentation/ui/pages/home_page/home_components/update_igde_dialog.dart';
import 'package:ignition/presentation/ui/pages/home_page/home_components/update_user_dialog.dart';
import 'package:ignition/utils/constants.dart';

enum ListType { igde, clients }

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.token});
  final String token;
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final HomeController _homeController = HomeController();
  String title = 'Lista de Clientes';
  List<String> tagList = [];
  bool load = false;
  bool showTagsFilter = true;
  int selectedIndex = -1;
  @override
  void initState() {
    setState(() {
      load = true;
    });

    startLists();
    super.initState();
  }

  Future startLists() async {
    _homeController.userList = (await _homeController.fetchUsers(widget.token));
    _homeController.igdeList = (await _homeController.fetchIgdes(widget.token));

    _homeController.currentList = [];
    _homeController.currentList.addAll(_homeController.userList);
    Future.delayed(const Duration(seconds: 2)).whenComplete(() => setState(() {
          startTags();
          load = false;
        }));
  }

  void tagFilter(String selectedTag, int index) {
    if (selectedIndex == index) {
      _homeController.currentList = [];
      _homeController.currentList.addAll(_homeController.userList);
      selectedIndex = -1;
      setState(() {});
      return;
    }
    var tempList = <UserEntity>[];

    for (var element in _homeController.userList) {
      element = element as UserEntity;
      if (element.tags!.toLowerCase().contains(selectedTag.toLowerCase())) {
        tempList.add(element);
      }
    }
    _homeController.currentList = [];
    _homeController.currentList.addAll(tempList);
    selectedIndex = index;
    setState(() {});
  }

  void startTags() {
    tagList = [];
    for (var element in _homeController.userList) {
      element = element as UserEntity;

      tagList
          .addAll(element.tags!.replaceAll(' ', '').toUpperCase().split(','));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ProjectColors.orange,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
              height: MediaQuery.sizeOf(context).height,
              decoration: const BoxDecoration(
                  color: ProjectColors.orange,
                  gradient: LinearGradient(
                      colors: [ProjectColors.orange, Colors.red])),
              child: load
                  ? loadComponent()
                  : Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        const SizedBox(
                          height: 30,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              title,
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              width: _homeController.currentListType ==
                                      ListType.clients
                                  ? 10
                                  : 0,
                            ),
                            _homeController.currentListType == ListType.clients
                                ? InkWell(
                                    child: const Icon(
                                      Icons.add_circle,
                                      color: Colors.white,
                                    ),
                                    onTap: () async {
                                      await insertUserDialog(
                                          context, widget.token);
                                    })
                                : const SizedBox(),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            InkWell(
                              child: Icon(
                                Icons.arrow_right,
                                color: _homeController.currentListType ==
                                        ListType.clients
                                    ? Colors.white
                                    : Colors.transparent,
                              ),
                            ),
                            InkWell(
                                child: Icon(
                                  Icons.people,
                                  color: _homeController.currentListType ==
                                          ListType.clients
                                      ? Colors.white
                                      : Colors.grey,
                                  size: 28,
                                ),
                                onTap: () {
                                  setState(() {
                                    title = 'Lista de Clientes';
                                    _homeController.currentListType =
                                        ListType.clients;
                                    _homeController.currentList = [];
                                    _homeController.currentList
                                        .addAll(_homeController.userList);
                                  });
                                }),
                            const SizedBox(
                              width: 10,
                            ),
                            InkWell(
                              child: Icon(
                                Icons.arrow_right,
                                color: _homeController.currentListType ==
                                        ListType.igde
                                    ? Colors.white
                                    : Colors.transparent,
                              ),
                            ),
                            InkWell(
                                child: Icon(
                                  Icons.factory,
                                  color: _homeController.currentListType ==
                                          ListType.igde
                                      ? Colors.white
                                      : Colors.grey,
                                ),
                                onTap: () {
                                  _homeController.currentList = [];

                                  setState(() {
                                    title = 'Lista de IGDS';
                                    _homeController.currentListType =
                                        ListType.igde;
                                    _homeController.currentList
                                        .addAll(_homeController.igdeList);
                                  });
                                }),
                            const SizedBox(
                              width: 22,
                            ),
                            InkWell(
                                child: Icon(Icons.tag,
                                    color: showTagsFilter &&
                                            _homeController.currentListType ==
                                                ListType.clients
                                        ? Colors.white
                                        : Colors.grey),
                                onTap: () {
                                  if (_homeController.currentListType ==
                                      ListType.clients) {
                                    showTagsFilter = !showTagsFilter;
                                    setState(() {});
                                  }
                                }),
                            const SizedBox(
                              width: 22,
                            ),
                            InkWell(
                                child: const Icon(Icons.refresh,
                                    color: Colors.white),
                                onTap: () async {
                                  setState(() {
                                    load = true;
                                  });
                                  await startLists().whenComplete(
                                    () {
                                      _homeController.currentListType =
                                          ListType.clients;
                                      Future.delayed(const Duration(seconds: 2))
                                          .whenComplete(() => setState(() {
                                                load = false;
                                              }));
                                    },
                                  );
                                })
                          ],
                        ),
                        const SizedBox(height: 10),
                        if (_homeController.currentListType ==
                                ListType.clients &&
                            showTagsFilter)
                          SizedBox(
                            height: 30,
                            child: tagList.isEmpty
                                ? Container(
                                    alignment: Alignment.center,
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 5),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 5),
                                    decoration: const BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(30))),
                                    height: 20,
                                    child: const Text(
                                      'A lista de Tags está vazia',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: ProjectColors.orange,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w400),
                                    ),
                                  )
                                : ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: tagList.length,
                                    itemBuilder: (context, index) {
                                      return InkWell(
                                        onTap: () =>
                                            tagFilter(tagList[index], index),
                                        child: Container(
                                          alignment: Alignment.center,
                                          margin: const EdgeInsets.symmetric(
                                              horizontal: 5),
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 5),
                                          decoration: BoxDecoration(
                                              border: selectedIndex == index
                                                  ? Border.all(
                                                      color: Colors.green,
                                                      width: 2)
                                                  : null,
                                              color: Colors.white,
                                              borderRadius:
                                                  const BorderRadius.all(
                                                      Radius.circular(30))),
                                          height: 20,
                                          child: Text(
                                            tagList[index],
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                color: selectedIndex == index
                                                    ? Colors.green
                                                    : ProjectColors.orange,
                                                fontSize: 12,
                                                fontWeight: FontWeight.w400),
                                          ),
                                        ),
                                      );
                                    }),
                          ),
                        const SizedBox(height: 10),
                        SizedBox(
                          height: _homeController.currentList.length * 100,
                          child: ListView.builder(
                            itemCount: _homeController.currentList.length,
                            itemBuilder: (context, index) => Container(
                              margin: const EdgeInsets.only(
                                  left: 20, right: 20, bottom: 5),
                              height: 60,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.grey.withOpacity(0.7),
                                        offset: const Offset(2, 2),
                                        blurRadius: 03),
                                    BoxShadow(
                                        color: Colors.grey.withOpacity(0.7),
                                        offset: const Offset(-2, -2),
                                        blurRadius: 03)
                                  ],
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(10))),
                              child: Column(
                                children: [
                                  Text(
                                    _homeController.currentList[index].name!,
                                    style: const TextStyle(
                                        color: ProjectColors.orange,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Container(
                                    height: 1,
                                    color: ProjectColors.orange,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      InkWell(
                                          child: const Icon(Icons.edit),
                                          onTap: () async {
                                            if (_homeController
                                                    .currentListType ==
                                                ListType.clients) {
                                              UserEntity user = _homeController
                                                      .currentList[index]
                                                  as UserEntity;
                                              await updateUserDialog(
                                                  context,
                                                  user.id!,
                                                  user.name!,
                                                  user.email!,
                                                  user.tags!,
                                                  widget.token);
                                            } else {
                                              updateIgdeDialog(
                                                  context,
                                                  _homeController
                                                      .currentList[index].name!,
                                                  _homeController
                                                      .currentList[index]
                                                      .email!,
                                                  _homeController
                                                      .currentList[index].id!,
                                                  widget.token);
                                            }
                                          }),
                                      const SizedBox(
                                        width: 30,
                                      ),
                                      InkWell(
                                          child: Icon(
                                              _homeController.currentListType ==
                                                      ListType.igde
                                                  ? Icons.factory
                                                  : Icons.people),
                                          onTap: () {
                                            setState(() {
                                              log(_homeController
                                                  .currentListType.name);
                                            });
                                          }),
                                      const SizedBox(
                                        width: 30,
                                      ),
                                      InkWell(
                                          child: const Icon(
                                            Icons.delete_forever,
                                          ),
                                          onTap: () async {
                                            Function() function;
                                            if (_homeController
                                                    .currentListType ==
                                                ListType.clients) {
                                              function = () async =>
                                                  await _homeController
                                                      .deleteUsers(
                                                          _homeController
                                                              .currentList[
                                                                  index]
                                                              .id!,
                                                          index,
                                                          widget.token,
                                                          context);
                                            } else {
                                              function = () async =>
                                                  await _homeController
                                                      .deleteIgdes(
                                                          _homeController
                                                              .currentList[
                                                                  index]
                                                              .id!,
                                                          index,
                                                          widget.token,
                                                          context);
                                            }
                                            await ProjectDialogsWidget().alertDialog(
                                                context,
                                                'Deletar ${_homeController.currentList[index].name}?',
                                                'Deseja prosseguir com a remoção?',
                                                'Prosseguir',
                                                function);
                                          }),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    )),
        ),
      ),
    );
  }
}
