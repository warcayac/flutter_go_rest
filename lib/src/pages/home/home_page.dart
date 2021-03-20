import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_rest/services/go_rest_service.dart';


class HomePage extends StatelessWidget {
  /* ---------------------------------------------------------------------------- */
  HomePage({Key? key}) : super(key: key) {
    Get.put(GoRestService());
  }
  /* ---------------------------------------------------------------------------- */
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(),
      appBar: buildAppBar(),
      body: Column(
        children: [
          buildTextInputSearch(),
          buildProductsToolBar(),
          Obx(() => buildResultList()),
        ],
      ),
    );
  }
  /* ---------------------------------------------------------------------------- */
  Widget buildResultList() {
    GoRestService goRest = Get.find();

    return Expanded(
      child: goRest.isLoading.value!
        ? Center(child: CircularProgressIndicator())
        : ListView.builder(
          itemCount: goRest.numOfProducts,
          itemBuilder: (context, index) => Column(
            children: [
              Row(
                children: [
                  Container(
                    width: 150,
                    height: 100,
                    margin: EdgeInsets.fromLTRB(16, 8, 8, 8),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.network(
                        goRest.productImg(index),
                        width: 150,
                        height: 100,
                        fit: BoxFit.contain,
                        color: Colors.red,
                        colorBlendMode: BlendMode.color,
                      ),
                    ),
                  ),
                  Flexible(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          goRest.productName(index).toUpperCase() + '\n',
                            style: TextStyle(
                            fontWeight: FontWeight.bold
                          ),
                        ),
                        Text(
                          goRest.productDesc(index), 
                            style: TextStyle(
                            fontSize: 12,
                            color: Colors.black38,
                          ),
                          maxLines: 4,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Container(color: Colors.black87, height: 2),
            ],
          ),
        ),
    );
  }
  /* ---------------------------------------------------------------------------- */
  Padding buildProductsToolBar() {
    GoRestService goRest = Get.find();

    return Padding(
      padding: EdgeInsets.all(16),
      child: Row(
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text('Products', style: TextStyle(
                  fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black87
                )),
                Row(
                  children: [
                    buildIconButton(icon: Icons.list_rounded, item: 'List'),
                    buildIconButton(icon: Icons.grid_view, item: 'Grid', 
                      onPressed: () {
                        if (!goRest.isLoading.value!) goRest.fetchProducts();
                      },
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
  /* ---------------------------------------------------------------------------- */
  Padding buildTextInputSearch() {
    return Padding(
      padding: EdgeInsets.all(16),
      child: Row(
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextFormField(
                  decoration: InputDecoration(
                    hintText: 'Search for markets or products',
                    prefixIcon: Icon(Icons.search_rounded),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                  ),
                  onTap: () => print('Search Box Tapped'),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
  /* ---------------------------------------------------------------------------- */
  AppBar buildAppBar() {
    return AppBar(
      title: Text('Category', style: TextStyle(color: Colors.black87)),
      centerTitle: true,
      elevation: 0,
      backgroundColor: Colors.grey[100],
      leading: buildIconButton(icon: Icons.menu_book_rounded, item: 'Drawer Menu'),
      actions: [
        buildStack(icon: Icons.shopping_cart, label: 'Cart'),
        buildStack(icon: Icons.notifications_rounded, label: 'Notifications'),
      ],
    );
  }
  /* ---------------------------------------------------------------------------- */
  Stack buildStack({required IconData icon, required String label}) {
    return Stack(
      children: [
        Center(child: buildIconButton(icon: icon, item: label)),
        Positioned(
          height: 20,
          right: 4,
          child: Container(
            height: 22,
            width: 22,
            padding: EdgeInsets.all(4),
            decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.deepPurple),
            child: Center(
              child: Text('0', style: TextStyle(
                fontSize: 12, fontWeight: FontWeight.bold, color: Colors.white
              )),
            ),
          ),
        ),
      ],
    );
  }
  /* ---------------------------------------------------------------------------- */
  IconButton buildIconButton({required IconData icon, required String item, double? size, VoidCallback? onPressed}) {
    return IconButton(
      icon: Icon(icon, size: size, color: Colors.black87),
      onPressed: () {
        print('$item Clicked');
        if (onPressed != null) onPressed();
      },
    );
  }
}
