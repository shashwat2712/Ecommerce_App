import 'package:amazon_clone_node_js_flutter_app_new/common/widgets/loader.dart';
import 'package:amazon_clone_node_js_flutter_app_new/constants/global_variable.dart';
import 'package:amazon_clone_node_js_flutter_app_new/features/accounts/screens/account_screen.dart';
import 'package:amazon_clone_node_js_flutter_app_new/features/accounts/services/account_services.dart';
import 'package:amazon_clone_node_js_flutter_app_new/features/accounts/widgets/single_product.dart';
import 'package:flutter/material.dart';

import '../../../models/order.dart';
import '../../order_detail_screen/screens/order_details_screen.dart';

class Orders extends StatefulWidget {
  const Orders({super.key});

  @override
  State<Orders> createState() => _OrdersState();
}

class _OrdersState extends State<Orders> {
  List<Order>? orders;
  final AccountServices accountServices = AccountServices();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchOrders();
  }

  void fetchOrders() async {
    orders = await accountServices.fetchMyOrders(context: context);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return orders == null
        ? const Loader()
        : Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: const EdgeInsets.only(left: 15),
                    child: const Text(
                      'Your Orders',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(right: 15),
                    child: Text(
                      'See All',
                      style: TextStyle(
                        color: GlobalVariables.selectedNavBarColor,
                      ),
                    ),
                  ),
                  //display orders
                ],
              ),
              Container(
                height: 170,
                padding: const EdgeInsets.only(left: 10, top: 20, right: 0),
                child: ListView.builder(
                  itemCount: orders!.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: (){
                        Navigator.pushNamed(
                          context,
                          OrderDetailScreen.routeName,
                          arguments: orders![index],
                        );
                      },
                      child: SingleProduct(
                          image: orders![index].products[0].images[0]),
                    );
                  },
                ),
              )
            ],
          );
  }
}
