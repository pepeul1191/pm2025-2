import 'package:biblioapp/pages/books/books_page.dart';
import 'package:biblioapp/pages/comentaries/comentaries_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'search_controller.dart' as SearchControllerAlias;

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // TabBar debajo del AppBar
        Container(
          child: TabBar(
            controller: _tabController,
            indicatorColor: Theme.of(context).colorScheme.primary,
            indicatorWeight: 3,
            labelColor: Theme.of(context).colorScheme.primary,
            unselectedLabelColor: Colors.grey,
            tabs: [
              Tab(text: 'Libros'),
              Tab(text: 'Mis Comentarios'),
            ],
          ),
        ),
        // Contenido de los tabs
        Expanded(
          child: TabBarView(
            controller: _tabController,
            children: [BooksPage(), ComentariesPage()],
          ),
        ),
      ],
    );
  }
}
