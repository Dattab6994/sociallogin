import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sociallogin/controller/controller.dart';
import 'package:sociallogin/model/model.dart';

class ProductDetailsPage extends StatefulWidget {
  final BeerModel model;
  const ProductDetailsPage({super.key, required this.model});

  @override
  State<ProductDetailsPage> createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends State<ProductDetailsPage> {
  late final LoginController controller;
  @override
  void initState() {
    super.initState();
    controller = Get.put(LoginController());
    controller.fetchPosts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Product Details'),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: FutureBuilder(
            future: controller.fetchPosts(),
            builder: (context, snapshot) {
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: Card(
                    shape: const RoundedRectangleBorder(
                        side: BorderSide(color: Colors.grey)),
                    color: Colors.blue.shade50,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Column(
                            children: [
                              Container(
                                  height: 200,
                                  width: 100,
                                  child: Image.network(
                                      widget.model.imageUrl ?? '')),
                              const SizedBox(
                                height: 10.0,
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Name : ',
                                    style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.green.shade600),
                                  ),
                                  Expanded(
                                    child: Text(
                                      widget.model.name ?? '',
                                      style: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 10.0,
                              ),
                              Row(
                                children: [
                                  Text(
                                    'First Brewed : ',
                                    style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.green.shade600),
                                  ),
                                  Text(
                                    widget.model.firstBrewed ?? '',
                                    style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 10.0,
                              ),
                              Row(
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        'Volume : ',
                                        style: TextStyle(
                                            fontSize: 16,
                                            color: Colors.green.shade600),
                                      ),
                                      Text(
                                        '${widget.model.volume?.value.toString() ?? ''} ${widget.model.volume?.unit ?? ''}',
                                        style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ],
                                  ),
                                  const Spacer(),
                                  Row(
                                    children: [
                                      Text(
                                        'Boil Volume : ',
                                        style: TextStyle(
                                            fontSize: 16,
                                            color: Colors.green.shade600),
                                      ),
                                      Text(
                                        '${widget.model.boilVolume?.value.toString() ?? ''} ${widget.model.boilVolume?.unit ?? ''}',
                                        style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 10.0,
                              ),
                              Row(
                                children: [
                                  Text(
                                    'Tagline : ',
                                    style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.green.shade600),
                                  ),
                                  Text(
                                    widget.model.tagline ?? '',
                                    style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 10.0,
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Description : ',
                                    style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.green.shade600),
                                  ),
                                  Expanded(
                                    child: Text(
                                      widget.model.description ?? '',
                                      style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 10.0,
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Food Pairing : ',
                                    style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.green.shade600),
                                  ),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          widget.model.foodPairing![0],
                                          style: const TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500),
                                        ),
                                        Text(
                                          widget.model.foodPairing![1],
                                          style: const TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500),
                                        ),
                                        Text(
                                          widget.model.foodPairing![2],
                                          style: const TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 10.0,
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Brewers Tips : ',
                                    style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.green.shade600),
                                  ),
                                  Expanded(
                                    child: Text(
                                      widget.model.brewersTips ?? '',
                                      style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 10.0,
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Contributed By : ',
                                    style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.green.shade600),
                                  ),
                                  Text(
                                    widget.model.contributedBy ?? '',
                                    style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    )),
              );
            },
          ),
        ));
  }
}
