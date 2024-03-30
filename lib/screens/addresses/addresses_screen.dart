import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../../data/local/local_database.dart';
import '../../view_models/addresses_view_model.dart';
import '../maps/update_address_screen.dart';

class AddressesScreen extends StatefulWidget {
  const AddressesScreen({super.key});

  @override
  State<AddressesScreen> createState() => _AddressesScreenState();
}

class _AddressesScreenState extends State<AddressesScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Addresses"),
      ),
      body: Column(
        children: [
          Expanded(
            child: Consumer<AddressesViewModel>(
              builder: (context, viewModel, child) {
                return ListView(children: [
                  ...List.generate(viewModel.myAddresses.length, (index) {
                    var myAddress = viewModel.myAddresses[index];
                    return Column(
                      children: [
                        ListTile(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) {
                                    return UpdateAddressScreen(
                                      placeModel: myAddress,
                                    );
                                  },
                                ),
                              );
                            },
                            trailing: IconButton(
                                onPressed: () {
                                  LocalDatabase.deleteItem(1);
                                  context
                                      .read<AddressesViewModel>()
                                      .deleteAddress(myAddress);
                                },
                                icon: const Icon(Icons.cancel_outlined)),
                            leading: SizedBox(
                              width: 40,
                              height: 45,
                              child: SvgPicture.asset(
                                  myAddress.placeCategory.name == "home"
                                      ? "assets/icons/home.svg"
                                      : myAddress.placeCategory.name == "work"
                                          ? "assets/icons/work.svg"
                                          : "assets/icons/other.svg"),
                            ),
                            subtitle: Text(myAddress.orientAddress),
                            title: Text(myAddress.placeName)),
                        Container(
                          width: double.infinity,
                          height: 1,
                          color: Colors.grey,
                        )
                      ],
                    );
                  })
                ]);
              },
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 15),
            padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 13),
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                    spreadRadius: 2,
                    blurRadius: 10,
                    offset: const Offset(0, 7),
                    color: Colors.black.withOpacity(.24))
              ],
              borderRadius: BorderRadius.circular(16),
              color: Colors.orangeAccent,
            ),
            child: InkWell(
              onTap: () {},
              child: const Text(
                "Add Address",
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.white),
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          )
        ],
      ),
    );
  }
}
