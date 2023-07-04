import 'package:flutter/material.dart';
import 'package:goya/src/config/custom_colors.dart';
import 'package:goya/src/config/app_data.dart' as appData;
import 'package:goya/src/pages/home/components/item_tile.dart';
import 'components/category_tile.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({super.key});

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  String selectedCategory = 'Frutas';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // App bar
      appBar: AppBar(
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(Icons.menu),
              onPressed: () {},
              tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
            );
          },
        ),
        elevation: 0,
        backgroundColor: CustomColors.customSwatchColor,
        centerTitle: true,
        title:
            Text.rich(TextSpan(style: const TextStyle(fontSize: 30), children: [
          const TextSpan(
              text: 'Quitanda',
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          TextSpan(
              text: 'Goya',
              style: TextStyle(color: CustomColors.customConstrastColors))
        ])),
        actions: [
          Container(
            alignment: Alignment.center,
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: GestureDetector(
                onTap: () => {},
                child: Badge(
                  backgroundColor: CustomColors.customConstrastColors,
                  alignment: Alignment.topRight,
                  label: const Text(
                    '0',
                    style: TextStyle(color: Colors.white, fontSize: 11),
                  ),
                  child: IconButton(
                      onPressed: () {}, icon: const Icon(Icons.shopping_cart)),
                ),
              ),
            ),
          )
        ],
      ),

      // Campo pesquisa
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: TextFormField(
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                isDense: true,
                hintText: 'Pesquisar',
                hintStyle: TextStyle(color: Colors.grey.shade400, fontSize: 14),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(60),
                    borderSide:
                        const BorderSide(width: 0, style: BorderStyle.none)),
              ),
            ),
          ),

          // Categorias
          Container(
            padding: const EdgeInsets.only(left: 25),
            height: 40,
            child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemBuilder: (_, index) {
                  return CategoryTile(
                    onPressed: () {
                      setState(() {
                        selectedCategory = appData.categories[index];
                      });
                    },
                    category: appData.categories[index],
                    isSelected: appData.categories[index] == selectedCategory,
                  );
                },
                separatorBuilder: (_, index) => const SizedBox(width: 10),
                itemCount: appData.categories.length),
          ),

          // Grid
          Expanded(
            child: GridView.builder(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                physics: const BouncingScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                    childAspectRatio: 9 / 11.5),
                itemCount: appData.items.length,
                itemBuilder: (_, index) {
                  return ItemTile(
                    item: appData.items[index],
                  );
                }),
          ),
        ],
      ),
    );
  }
}
