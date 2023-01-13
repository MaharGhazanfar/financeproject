import 'package:cached_network_image/cached_network_image.dart';
import 'package:financeproject/model/model_info.dart';
import 'package:financeproject/screen/add_customer_.dart';
import 'package:financeproject/screen/first_intro.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:screenshot/screenshot.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/model_employee_info.dart';
import '../util/DbHandler.dart';
import '../util/const_value.dart';
import '../util/pdf_create.dart';
import '../widget/custom_profile.dart';
import '../widget/custom_textfield.dart';

class SearchCustomer extends StatefulWidget {
  const SearchCustomer({Key? key}) : super(key: key);

  @override
  State<SearchCustomer> createState() => _SearchCustomerState();
}

class _SearchCustomerState extends State<SearchCustomer> {
  TextEditingController registerNoController = TextEditingController();
  TextEditingController referenceController = TextEditingController();

  ScreenshotController screenshotController = ScreenshotController();

  TextEditingController controllerAmount = TextEditingController();
  bool isLoading = false;
  double opacity = 1;
  Map<String, dynamic> singleInfoCustomer = {};
  final amountGlobalKey = GlobalKey<FormState>();
  final registerNoGlobalKey = GlobalKey<FormFieldState>();
  DateTime? date;
  List productDetails = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        title: const Text('Search Customer'),
        centerTitle: true,
        leading: IconButton(
          onPressed: () async {
            if (DbHandler.user != null) {
              FirebaseAuth.instance.signOut().asStream();
            } else {
              ModelEmployee.info = await SharedPreferences.getInstance();
              ModelEmployee.info!.remove(ConstValue.employeeData);
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => FirstIntro()),
              );
            }
          },
          icon: Icon(Icons.logout),
          splashColor: Colors.white,
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const AddCustomer(),
                  ));
            },
            icon: Icon(Icons.add),
            splashColor: Colors.white,
          ),
        ],
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                /// textField for search ............................

                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: TextFormField(
                    key: registerNoGlobalKey,
                    controller: registerNoController,
                    style: const TextStyle(
                        fontWeight: FontWeight.normal,
                        color: Colors.white,
                        fontSize: ConstValue.textSize),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Required';
                      } else {
                        return null;
                      }
                    },
                    decoration: InputDecoration(
                      constraints: BoxConstraints(maxHeight: 50),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.green)),
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.green)),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.green)),
                      suffix: InkWell(
                          onTap: () async {
                            if (registerNoGlobalKey.currentState!.validate()) {
                              setState(() {
                                FocusScope.of(context).unfocus();
                                isLoading = true;
                              });

                              var doc = await DbHandler.customerCollection()
                                  .doc(registerNoController.text)
                                  .get();
                              if (doc.exists) {
                                singleInfoCustomer =
                                    doc.data() as Map<String, dynamic>;
                                print(
                                    '${singleInfoCustomer}////////${doc.exists}//////firebase/');

                                String currentDate = singleInfoCustomer[
                                    ModelCustomerInfo.dateKey];

                                date = DateTime(
                                    int.parse(currentDate.substring(0, 4)),
                                    int.parse(currentDate.substring(5, 7)),
                                    int.parse(currentDate.substring(8, 10)));

                                productDetails = singleInfoCustomer[
                                    ModelCustomerInfo.productNameKey];

                                setState(() {
                                  isLoading = false;
                                });
                              } else {
                                setState(() {
                                  isLoading = false;
                                  singleInfoCustomer.clear();
                                });
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(const SnackBar(
                                  content: Text(
                                    'No Customer Found For This Registration Number',
                                  ),
                                  backgroundColor: Colors.red,
                                ));
                              }
                            }
                          },
                          child: const Icon(
                            Icons.search,
                            color: Colors.green,
                          )),
                      label: const Text(
                        'Register No',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),

                isLoading
                    ? Padding(
                        padding: const EdgeInsets.all(30.0),
                        child: CircularProgressIndicator(),
                      )
                    : singleInfoCustomer.isNotEmpty
                        ? MediaQuery.of(context).size.width < 600
                            ? Padding(
                                padding: const EdgeInsets.only(top: 16.0),
                                child: Container(
                                  width: MediaQuery.of(context).size.width,
                                  decoration: BoxDecoration(
                                      border: Border.all(color: Colors.green),
                                      borderRadius: BorderRadius.circular(5)),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: (Column(
                                      children: [
                                        ///   customer    image.......................................
                                        Container(
                                            height: 150,
                                            width: 150,
                                            child: CachedNetworkImage(
                                              imageUrl: singleInfoCustomer[
                                                  ModelCustomerInfo
                                                      .imagePathKey],
                                              imageBuilder:
                                                  (context, imageProvider) =>
                                                      Container(
                                                decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color: Colors.green),
                                                  image: DecorationImage(
                                                      image: imageProvider,
                                                      fit: BoxFit.cover,
                                                      colorFilter:
                                                          ColorFilter.mode(
                                                              Colors
                                                                  .transparent,
                                                              BlendMode
                                                                  .colorDodge)),
                                                ),
                                              ),
                                              placeholder: (context, url) =>
                                                  CircularProgressIndicator(),
                                              errorWidget:
                                                  (context, url, error) =>
                                                      Icon(Icons.error),
                                            )),

                                        ///   Register Number.......................................
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(top: 6.0),
                                          child: Row(
                                            children: [
                                              const Text(
                                                'Register No :',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.white,
                                                    fontSize: 15),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 5.0),
                                                child: Text(
                                                  singleInfoCustomer[
                                                          ModelCustomerInfo
                                                              .regNoKey]
                                                      .toString(),
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 15),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),

                                        ///   customer   Name.......................................
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(top: 6.0),
                                          child: Row(
                                            children: [
                                              const Text(
                                                'Customer Name :',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.white,
                                                    fontSize: 15),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 5.0),
                                                child: Text(
                                                  singleInfoCustomer[
                                                          ModelCustomerInfo
                                                              .customerNameKey]
                                                      .toString(),
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 15),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),

                                        ///   customer   Phone Number.......................................
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(top: 6.0),
                                          child: Row(
                                            children: [
                                              const Text(
                                                'Phone No :',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.white,
                                                    fontSize: 15),
                                              ),
                                              Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 5.0),
                                                  child: Text(
                                                    singleInfoCustomer[
                                                            ModelCustomerInfo
                                                                .customerPhoneKey]
                                                        .toString(),
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 15),
                                                  ))
                                            ],
                                          ),
                                        ),

                                        ///   customer   CNIC.......................................
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(top: 6.0),
                                          child: Row(
                                            children: [
                                              const Text(
                                                'CNIC No :',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.white,
                                                    fontSize: 15),
                                              ),
                                              Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 5.0),
                                                  child: Text(
                                                    singleInfoCustomer[
                                                            ModelCustomerInfo
                                                                .customerCNICKey]
                                                        .toString(),
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 15),
                                                  ))
                                            ],
                                          ),
                                        ),

                                        ///   customer   Address.......................................
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(top: 6.0),
                                          child: Row(
                                            children: [
                                              const Flexible(
                                                child: Text(
                                                  'Customer Address :',
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.white,
                                                      fontSize: 15),
                                                ),
                                              ),
                                              Flexible(
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 5.0),
                                                  child: Text(
                                                    singleInfoCustomer[
                                                            ModelCustomerInfo
                                                                .addressKey]
                                                        .toString(),
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 15),
                                                    maxLines: 2,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),

                                        Padding(
                                          padding: const EdgeInsets.all(6.0),
                                          child: ListView.builder(
                                            shrinkWrap: true,
                                            physics:
                                                const NeverScrollableScrollPhysics(),
                                            itemCount: productDetails.length,
                                            itemBuilder: (BuildContext context,
                                                    int index) =>
                                                Container(
                                              decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color: Colors.white)),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Column(
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              top: 6.0),
                                                      child: Row(
                                                        children: [
                                                          const Text(
                                                            'Product Name :',
                                                            style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                color: Colors
                                                                    .white,
                                                                fontSize: 15),
                                                          ),
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .only(
                                                                    left: 5.0),
                                                            child: Text(
                                                              productDetails[
                                                                          index]
                                                                      [
                                                                      'productName']
                                                                  .toString(),
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .white,
                                                                  fontSize: 15),
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              top: 6.0),
                                                      child: Row(
                                                        children: [
                                                          const Text(
                                                            'Product Price :',
                                                            style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                color: Colors
                                                                    .white,
                                                                fontSize: 15),
                                                          ),
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .only(
                                                                    left: 5.0),
                                                            child: Text(
                                                              productDetails[
                                                                          index]
                                                                      [
                                                                      'productPrice']
                                                                  .toString(),
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .white,
                                                                  fontSize: 15),
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),

                                        ///   Date .......................................
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(top: 6.0),
                                          child: Row(
                                            children: [
                                              const Text(
                                                'Date :',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.white,
                                                    fontSize: 15),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 5.0),
                                                child: Text(
                                                  singleInfoCustomer[
                                                          ModelCustomerInfo
                                                              .dateKey]
                                                      .toString()
                                                      .substring(0, 10),
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 15),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),

                                        /// Expiry Date.............................................
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(top: 6.0),
                                          child: Row(
                                            children: [
                                              const Text(
                                                'Expiry Date :',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.white,
                                                    fontSize: 15),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 5.0),
                                                child: Text(
                                                  singleInfoCustomer[
                                                          ModelCustomerInfo
                                                              .expDateKey]
                                                      .toString()
                                                      .substring(0, 10),
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 15),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),

                                        ///     total price ///////////
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(top: 6.0),
                                          child: Row(
                                            children: [
                                              const Text(
                                                'Total Price :',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.white,
                                                    fontSize: 15),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 5.0),
                                                child: Text(
                                                  singleInfoCustomer[
                                                          ModelCustomerInfo
                                                              .totalPriceKey]
                                                      .toString(),
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 15),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),

                                        /// interest /////////////////////////
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(top: 6.0),
                                          child: Row(
                                            children: [
                                              const Text(
                                                'Interest :',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.white,
                                                    fontSize: 15),
                                              ),
                                              Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 5.0),
                                                  child: Text(
                                                    '${singleInfoCustomer[ModelCustomerInfo.interestKey].toString()} %',
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 15),
                                                  )),
                                            ],
                                          ),
                                        ),

                                        /// grand price ....///////
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(top: 6.0),
                                          child: Row(
                                            children: [
                                              const Text(
                                                'Grand Price :',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.white,
                                                    fontSize: 15),
                                              ),
                                              Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 5.0),
                                                  child: Text(
                                                    singleInfoCustomer[
                                                            ModelCustomerInfo
                                                                .grandPriceKey]
                                                        .toString(),
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 15),
                                                  )),
                                            ],
                                          ),
                                        ),

                                        /// advance price////////////////////////////
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(top: 6.0),
                                          child: Row(
                                            children: [
                                              const Text(
                                                'Advance Price :',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.white,
                                                    fontSize: 15),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 5.0),
                                                child: Text(
                                                  singleInfoCustomer[
                                                          ModelCustomerInfo
                                                              .advancePriceKey]
                                                      .toString(),
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 15),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),

                                        /// remaining price /////////////
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(top: 6.0),
                                          child: Row(
                                            children: [
                                              const Text(
                                                'Remaining Price :',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.white,
                                                    fontSize: 15),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 5.0),
                                                child: Text(
                                                  singleInfoCustomer[
                                                          ModelCustomerInfo
                                                              .remainingPriceKey]
                                                      .toString(),
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 15),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(top: 6.0),
                                          child: Row(
                                            children: [
                                              const Text(
                                                'Monthly Installment:',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.white,
                                                    fontSize: 15),
                                              ),
                                              Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 5.0),
                                                  child: Text(
                                                    singleInfoCustomer[
                                                            ModelCustomerInfo
                                                                .monthlyInstallmentKey]
                                                        .toString(),
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 15),
                                                  )),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(top: 6.0),
                                          child: Row(
                                            children: [
                                              const Text(
                                                'Engine No :',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.white,
                                                    fontSize: 15),
                                              ),
                                              Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 5.0),
                                                  child: Text(
                                                    singleInfoCustomer[
                                                            ModelCustomerInfo
                                                                .engineNoKey]
                                                        .toString(),
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 15),
                                                  )),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(top: 6.0),
                                          child: Row(
                                            children: [
                                              const Text(
                                                'Fram NO :',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.white,
                                                    fontSize: 15),
                                              ),
                                              Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 5.0),
                                                  child: Text(
                                                    singleInfoCustomer[
                                                            ModelCustomerInfo
                                                                .framNoKey]
                                                        .toString(),
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 15),
                                                  )),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(top: 6.0),
                                          child: Row(
                                            children: [
                                              const Text(
                                                'Guranter Name :',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.white,
                                                    fontSize: 15),
                                              ),
                                              Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 5.0),
                                                  child: Text(
                                                    singleInfoCustomer[
                                                            ModelCustomerInfo
                                                                .guranterNameKey]
                                                        .toString(),
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 15),
                                                  )),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(top: 6.0),
                                          child: Row(
                                            children: [
                                              const Text(
                                                'Guranter Phone NO :',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.white,
                                                    fontSize: 15),
                                              ),
                                              Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 5.0),
                                                  child: Text(
                                                    singleInfoCustomer[
                                                            ModelCustomerInfo
                                                                .guranterPhoneNoKey]
                                                        .toString(),
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 15),
                                                  )),
                                            ],
                                          ),
                                        ),

                                        Padding(
                                          padding: const EdgeInsets.only(
                                              top: 16.0, bottom: 16),
                                          child: SingleChildScrollView(
                                            scrollDirection: Axis.horizontal,
                                            child: Screenshot(
                                              controller: screenshotController,
                                              child: SizedBox(
                                                width: 600,
                                                child: Table(
                                                  defaultColumnWidth:
                                                      const FixedColumnWidth(
                                                          120),
                                                  border: TableBorder.all(
                                                      color: Colors.white,
                                                      style: BorderStyle.solid,
                                                      width: 2),
                                                  children: List.generate(
                                                    singleInfoCustomer[
                                                            ModelCustomerInfo
                                                                .maxInstallmentKey] +
                                                        1,
                                                    (tableIndex) => TableRow(
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8.0),
                                                          child: SizedBox(
                                                            height: 30,
                                                            child: Center(
                                                                child: tableIndex ==
                                                                        0
                                                                    ? const Text(
                                                                        'Date',
                                                                        style: TextStyle(
                                                                            fontSize:
                                                                                15,
                                                                            fontWeight:
                                                                                FontWeight.bold,
                                                                            color: Colors.white),
                                                                      )
                                                                    : Text(
                                                                        DateTime(
                                                                                date!.year,
                                                                                date!.month + (tableIndex - 1),
                                                                                tableIndex < 2 ? date!.day : 05)
                                                                            .toString()
                                                                            .substring(0, 10),
                                                                      )),
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8.0),
                                                          child: SizedBox(
                                                            height: 30,
                                                            child: Center(
                                                                child: tableIndex ==
                                                                        0
                                                                    ? const Text(
                                                                        'Payable',
                                                                        style: TextStyle(
                                                                            fontSize:
                                                                                15,
                                                                            fontWeight:
                                                                                FontWeight.bold,
                                                                            color: Colors.white),
                                                                      )
                                                                    : Text(singleInfoCustomer[
                                                                            ModelCustomerInfo
                                                                                .payableInstallmentKey][tableIndex -
                                                                            1]
                                                                        .toString())),
                                                          ),
                                                        ),
                                                        Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(8.0),
                                                            child: SizedBox(
                                                              height: 30,
                                                              child: Center(
                                                                  child: tableIndex ==
                                                                          0
                                                                      ? const Text(
                                                                          'Status',
                                                                          style: TextStyle(
                                                                              fontSize: 15,
                                                                              fontWeight: FontWeight.bold,
                                                                              color: Colors.white),
                                                                        )
                                                                      : singleInfoCustomer[ModelCustomerInfo.paidStatusKey][tableIndex - 1] ==
                                                                              'unpaid'
                                                                          ? TextButton(
                                                                              onPressed: () async {
                                                                                referenceController.clear();
                                                                                DbHandler.user != null ? referenceController.text = 'admin' : '';
                                                                                print('${referenceController.text}//////////////');
                                                                                showDialog(
                                                                                    context: context,
                                                                                    builder: (context) {
                                                                                      return Center(
                                                                                        child: Material(
                                                                                          child: SizedBox(
                                                                                            height: 150,
                                                                                            width: 300,
                                                                                            child: Padding(
                                                                                              padding: const EdgeInsets.all(8.0),
                                                                                              child: Column(
                                                                                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                                                                children: [
                                                                                                  CustomWidget.customTextFormField(
                                                                                                    controller: referenceController,
                                                                                                    titleName: 'Reference No',
                                                                                                    styleColor: Colors.black,
                                                                                                    validate: (String? value) {
                                                                                                      if (value!.isEmpty) {
                                                                                                        return 'required';
                                                                                                      } else {
                                                                                                        return null;
                                                                                                      }
                                                                                                    },
                                                                                                  ),
                                                                                                  Row(
                                                                                                    mainAxisAlignment: MainAxisAlignment.end,
                                                                                                    children: [
                                                                                                      TextButton(
                                                                                                          onPressed: () async {
                                                                                                            if (singleInfoCustomer[ModelCustomerInfo.empRefKey].toString() == referenceController.text.toString() && referenceController.text.toString().isNotEmpty || referenceController.text.toString() == 'admin') {
                                                                                                              setState(() {
                                                                                                                Navigator.pop(context);
                                                                                                              });

                                                                                                              showDialog(
                                                                                                                  context: context,
                                                                                                                  builder: (context) {
                                                                                                                    return AlertDialog(
                                                                                                                      title: const Text(
                                                                                                                        'Payment',
                                                                                                                        style: TextStyle(color: Colors.black),
                                                                                                                      ),
                                                                                                                      content: const Text(
                                                                                                                        'Would you like pay whole installment',
                                                                                                                        style: TextStyle(color: Colors.black),
                                                                                                                      ),
                                                                                                                      actions: [
                                                                                                                        TextButton(
                                                                                                                            onPressed: () {
                                                                                                                              Navigator.pop(context);
                                                                                                                            },
                                                                                                                            child: const Text(
                                                                                                                              'Cancel',
                                                                                                                              style: TextStyle(color: Colors.black),
                                                                                                                            )),
                                                                                                                        TextButton(
                                                                                                                            onPressed: () async {
                                                                                                                              Navigator.pop(context);
                                                                                                                              controllerAmount.clear();
                                                                                                                              _showModalBottomSheet(installment: '', index: tableIndex - 1, amount: singleInfoCustomer[ModelCustomerInfo.remainingInstallmentKey][tableIndex - 1], date: '', paidStatusList: [], paidOutstandingList: [], time: '', mainContext: context);
                                                                                                                            },
                                                                                                                            child: const Text(
                                                                                                                              'No',
                                                                                                                              style: TextStyle(color: Colors.black),
                                                                                                                            )),
                                                                                                                        TextButton(
                                                                                                                            onPressed: () async {
                                                                                                                              singleInfoCustomer[ModelCustomerInfo.remainingPriceKey] = singleInfoCustomer[ModelCustomerInfo.remainingPriceKey] - singleInfoCustomer[ModelCustomerInfo.remainingInstallmentKey][tableIndex - 1];
                                                                                                                              singleInfoCustomer[ModelCustomerInfo.paidStatusKey][tableIndex - 1] = 'paid';

                                                                                                                              singleInfoCustomer[ModelCustomerInfo.remainingInstallmentKey][tableIndex - 1] = 0.0;

                                                                                                                              DbHandler.customerCollection().doc(singleInfoCustomer[ModelCustomerInfo.regNoKey]).update(singleInfoCustomer);

                                                                                                                              setState(() {
                                                                                                                                Navigator.pop(context);
                                                                                                                              });
                                                                                                                            },
                                                                                                                            child: const Text(
                                                                                                                              'yes',
                                                                                                                              style: TextStyle(color: Colors.black),
                                                                                                                            ))
                                                                                                                      ],
                                                                                                                    );
                                                                                                                  });
                                                                                                            } else {
                                                                                                              showDialog(
                                                                                                                  context: context,
                                                                                                                  builder: (context) {
                                                                                                                    return AlertDialog(
                                                                                                                      content: const Text(
                                                                                                                        'This reference Number is not allowed',
                                                                                                                        style: TextStyle(color: Colors.black),
                                                                                                                      ),
                                                                                                                      actions: [
                                                                                                                        TextButton(
                                                                                                                            onPressed: () {
                                                                                                                              Navigator.pop(context);
                                                                                                                            },
                                                                                                                            child: const Text(
                                                                                                                              'ok',
                                                                                                                              style: TextStyle(color: Colors.black),
                                                                                                                            ))
                                                                                                                      ],
                                                                                                                    );
                                                                                                                  });
                                                                                                            }
                                                                                                          },
                                                                                                          child: const Text(
                                                                                                            'OK',
                                                                                                            style: TextStyle(color: Colors.black),
                                                                                                          )),
                                                                                                      TextButton(
                                                                                                          onPressed: () {
                                                                                                            Navigator.pop(context);
                                                                                                          },
                                                                                                          child: const Text(
                                                                                                            'CANCEL',
                                                                                                            style: TextStyle(color: Colors.black),
                                                                                                          )),
                                                                                                    ],
                                                                                                  )
                                                                                                ],
                                                                                              ),
                                                                                            ),
                                                                                          ),
                                                                                        ),
                                                                                      );
                                                                                    });
                                                                              },
                                                                              child: Text(
                                                                                singleInfoCustomer[ModelCustomerInfo.paidStatusKey][tableIndex - 1].toString(),
                                                                              ),
                                                                            )
                                                                          : Text(
                                                                              singleInfoCustomer[ModelCustomerInfo.paidStatusKey][tableIndex - 1].toString())),
                                                            )),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8.0),
                                                          child: SizedBox(
                                                            height: 30,
                                                            child: Center(
                                                                child: tableIndex ==
                                                                        0
                                                                    ? const Text(
                                                                        'Remaining',
                                                                        style: TextStyle(
                                                                            fontSize:
                                                                                15,
                                                                            fontWeight:
                                                                                FontWeight.bold,
                                                                            color: Colors.white),
                                                                      )
                                                                    : Text(singleInfoCustomer[
                                                                            ModelCustomerInfo
                                                                                .remainingInstallmentKey][tableIndex -
                                                                            1]
                                                                        .toString())),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),

                                        Align(
                                          alignment: Alignment.centerRight,
                                          child: SizedBox(
                                            height: ConstValue.buttonHeight,
                                            width: ConstValue.buttonWidth,
                                            child: ElevatedButton(
                                              onPressed: () async {
                                                final imageByteData =
                                                    await rootBundle.load(
                                                        'assets/motha.jpg');
                                                final imageUint8List =
                                                    imageByteData
                                                        .buffer
                                                        .asUint8List(
                                                            imageByteData
                                                                .offsetInBytes,
                                                            imageByteData
                                                                .lengthInBytes);

                                                final imageByteData1 =
                                                    await rootBundle.load(
                                                        'assets/motha1.png');

                                                final imageUint8List1 =
                                                    imageByteData1.buffer
                                                        .asUint8List(
                                                            imageByteData1
                                                                .offsetInBytes,
                                                            imageByteData1
                                                                .lengthInBytes);

                                                await createPDFANDExportPrint(
                                                    singleInfoCustomer,
                                                    imageUint8List,
                                                    imageUint8List1,
                                                    date!);
                                              },
                                              child: const Text('PRINT'),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 50,
                                        ),
                                      ],
                                    )),
                                  ),
                                ),
                              )
                            : Padding(
                                padding: const EdgeInsets.only(top: 16.0),
                                child: Container(
                                  width: MediaQuery.of(context).size.width,
                                  decoration: BoxDecoration(
                                      border: Border.all(),
                                      borderRadius: BorderRadius.circular(5)),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: (Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            ///   customer    image.......................................
                                            Flexible(
                                              flex: 4,
                                              child: Container(
                                                  height: 150,
                                                  width: 150,
                                                  decoration: BoxDecoration(
                                                    border: Border.all(),
                                                  ),
                                                  child: CachedNetworkImage(
                                                    imageUrl:
                                                        singleInfoCustomer[
                                                            ModelCustomerInfo
                                                                .imagePathKey],
                                                    progressIndicatorBuilder:
                                                        (context, url,
                                                                progress) =>
                                                            CircularProgressIndicator(),
                                                    fit: BoxFit.fill,
                                                  )),
                                            ),

                                            Flexible(
                                              flex: 6,
                                              child: Column(
                                                children: [
                                                  ///   Register Number.......................................
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            top: 3.0),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        const Text(
                                                          'Register No :',
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontSize:
                                                                  ConstValue
                                                                      .textSize),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  left: 5.0),
                                                          child: Text(
                                                            singleInfoCustomer[
                                                                    ModelCustomerInfo
                                                                        .regNoKey]
                                                                .toString(),
                                                            style: const TextStyle(
                                                                fontSize:
                                                                    ConstValue
                                                                        .textSize,
                                                                color: Colors
                                                                    .white),
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  ),

                                                  ///   customer   Name.......................................
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            top: 3.0),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        const Text(
                                                            'Customer Name :',
                                                            style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontSize: ConstValue
                                                                    .textSize)),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  left: 5.0),
                                                          child: Text(
                                                            singleInfoCustomer[
                                                                    ModelCustomerInfo
                                                                        .customerNameKey]
                                                                .toString(),
                                                            style: const TextStyle(
                                                                fontSize:
                                                                    ConstValue
                                                                        .textSize,
                                                                color: Colors
                                                                    .white),
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  ),

                                                  ///   customer   Phone Number.......................................
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            top: 3.0),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        const Text('Phone No :',
                                                            style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontSize: ConstValue
                                                                    .textSize)),
                                                        Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .only(
                                                                    left: 5.0),
                                                            child: Text(
                                                              singleInfoCustomer[
                                                                      ModelCustomerInfo
                                                                          .customerPhoneKey]
                                                                  .toString(),
                                                              style: const TextStyle(
                                                                  fontSize:
                                                                      ConstValue
                                                                          .textSize,
                                                                  color: Colors
                                                                      .white),
                                                            ))
                                                      ],
                                                    ),
                                                  ),

                                                  ///   customer   CNIC.......................................
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            top: 3.0),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        const Text('CNIC No :',
                                                            style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontSize: ConstValue
                                                                    .textSize)),
                                                        Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .only(
                                                                    left: 5.0),
                                                            child: Text(
                                                              singleInfoCustomer[
                                                                      ModelCustomerInfo
                                                                          .customerCNICKey]
                                                                  .toString(),
                                                              style: const TextStyle(
                                                                  fontSize:
                                                                      ConstValue
                                                                          .textSize,
                                                                  color: Colors
                                                                      .white),
                                                            ))
                                                      ],
                                                    ),
                                                  ),

                                                  ///   customer   Address.......................................
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            top: 3.0),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        const Flexible(
                                                          child: Text(
                                                              'Customer Address :',
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  fontSize:
                                                                      ConstValue
                                                                          .textSize)),
                                                        ),
                                                        Flexible(
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .only(
                                                                    left: 5.0),
                                                            child: Text(
                                                              singleInfoCustomer[
                                                                      ModelCustomerInfo
                                                                          .addressKey]
                                                                  .toString(),
                                                              style: const TextStyle(
                                                                  fontSize:
                                                                      ConstValue
                                                                          .textSize,
                                                                  color: Colors
                                                                      .white),
                                                              maxLines: 2,
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                            ),
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(6.0),
                                          child: GridView.builder(
                                            gridDelegate:
                                                const SliverGridDelegateWithFixedCrossAxisCount(
                                                    crossAxisCount: 2,
                                                    crossAxisSpacing: 16,
                                                    mainAxisExtent: 50),
                                            shrinkWrap: true,
                                            physics:
                                                const NeverScrollableScrollPhysics(),
                                            itemCount: productDetails.length,
                                            itemBuilder: (BuildContext context,
                                                    int index) =>
                                                Container(
                                              decoration: BoxDecoration(
                                                  border: Border.all()),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              top: 6.0),
                                                      child: Row(
                                                        children: [
                                                          const Text(
                                                              'Product Name :',
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  fontSize:
                                                                      15)),
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .only(
                                                                    left: 5.0),
                                                            child: Text(productDetails[
                                                                        index][
                                                                    'productName']
                                                                .toString()),
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              top: 6.0),
                                                      child: Row(
                                                        children: [
                                                          const Text(
                                                              'Product Purice :',
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  fontSize:
                                                                      15)),
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .only(
                                                                    left: 5.0),
                                                            child: Text(productDetails[
                                                                        index][
                                                                    'productPrice']
                                                                .toString()),
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 8.0, right: 8),
                                          child: Row(
                                            children: [
                                              Flexible(
                                                  flex: 4,
                                                  child: Column(
                                                    children: [
                                                      ///   Date .......................................
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(top: 6.0),
                                                        child: Row(
                                                          children: [
                                                            const Text(
                                                              'Date :',
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  fontSize: 15),
                                                            ),
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .only(
                                                                      left:
                                                                          5.0),
                                                              child: Text(singleInfoCustomer[
                                                                      ModelCustomerInfo
                                                                          .dateKey]
                                                                  .toString()
                                                                  .substring(
                                                                      0, 10)),
                                                            )
                                                          ],
                                                        ),
                                                      ),

                                                      /// interest /////////////////////////
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(top: 6.0),
                                                        child: Row(
                                                          children: [
                                                            const Text(
                                                                'Interest :',
                                                                style: TextStyle(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    fontSize:
                                                                        15)),
                                                            Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .only(
                                                                        left:
                                                                            5.0),
                                                                child: Text(
                                                                    '${singleInfoCustomer[ModelCustomerInfo.interestKey].toString()} %')),
                                                          ],
                                                        ),
                                                      ),

                                                      /// remaining price /////////////
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(top: 6.0),
                                                        child: Row(
                                                          children: [
                                                            const Text(
                                                                'Remaining Price :',
                                                                style: TextStyle(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    fontSize:
                                                                        15)),
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .only(
                                                                      left:
                                                                          5.0),
                                                              child: Text(singleInfoCustomer[
                                                                      ModelCustomerInfo
                                                                          .remainingPriceKey]
                                                                  .toString()),
                                                            )
                                                          ],
                                                        ),
                                                      ),

                                                      /// Frame NUmber......................
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(top: 6.0),
                                                        child: Row(
                                                          children: [
                                                            const Text(
                                                                'Frame NO :',
                                                                style: TextStyle(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    fontSize:
                                                                        15)),
                                                            Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .only(
                                                                        left:
                                                                            5.0),
                                                                child: Text(singleInfoCustomer[
                                                                        ModelCustomerInfo
                                                                            .framNoKey]
                                                                    .toString())),
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  )),
                                              Flexible(
                                                  flex: 4,
                                                  child: Column(
                                                    children: [
                                                      /// Expiry Date.............................................
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(top: 6.0),
                                                        child: Row(
                                                          children: [
                                                            const Text(
                                                                'Expiry Date :',
                                                                style: TextStyle(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    fontSize:
                                                                        15)),
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .only(
                                                                      left:
                                                                          5.0),
                                                              child: Text(singleInfoCustomer[
                                                                      ModelCustomerInfo
                                                                          .expDateKey]
                                                                  .toString()
                                                                  .substring(
                                                                      0, 10)),
                                                            )
                                                          ],
                                                        ),
                                                      ),

                                                      /// grand price ....///////
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(top: 6.0),
                                                        child: Row(
                                                          children: [
                                                            const Text(
                                                                'Grand Price :',
                                                                style: TextStyle(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    fontSize:
                                                                        15)),
                                                            Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .only(
                                                                        left:
                                                                            5.0),
                                                                child: Text(singleInfoCustomer[
                                                                        ModelCustomerInfo
                                                                            .grandPriceKey]
                                                                    .toString())),
                                                          ],
                                                        ),
                                                      ),

                                                      /// monthly Installment.........................
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(top: 6.0),
                                                        child: Row(
                                                          children: [
                                                            const Text(
                                                                'Monthly Installment:',
                                                                style: TextStyle(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    fontSize:
                                                                        15)),
                                                            Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .only(
                                                                        left:
                                                                            5.0),
                                                                child: Text(singleInfoCustomer[
                                                                        ModelCustomerInfo
                                                                            .monthlyInstallmentKey]
                                                                    .toString())),
                                                          ],
                                                        ),
                                                      ),

                                                      /// Guarantor Name
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(top: 6.0),
                                                        child: Row(
                                                          children: [
                                                            const Text(
                                                                'Guarantor Name :',
                                                                style: TextStyle(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    fontSize:
                                                                        15)),
                                                            Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .only(
                                                                        left:
                                                                            5.0),
                                                                child: Text(singleInfoCustomer[
                                                                        ModelCustomerInfo
                                                                            .guranterNameKey]
                                                                    .toString())),
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  )),
                                              Flexible(
                                                  flex: 4,
                                                  child: Column(
                                                    children: [
                                                      ///     total price ///////////
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(top: 6.0),
                                                        child: Row(
                                                          children: [
                                                            const Text(
                                                              'Total Price :',
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  fontSize: 15),
                                                            ),
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .only(
                                                                      left:
                                                                          5.0),
                                                              child: Text(singleInfoCustomer[
                                                                      ModelCustomerInfo
                                                                          .totalPriceKey]
                                                                  .toString()),
                                                            )
                                                          ],
                                                        ),
                                                      ),

                                                      /// advance price////////////////////////////
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(top: 6.0),
                                                        child: Row(
                                                          children: [
                                                            const Text(
                                                              'Advance Price :',
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  fontSize: 15),
                                                            ),
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .only(
                                                                      left:
                                                                          5.0),
                                                              child: Text(singleInfoCustomer[
                                                                      ModelCustomerInfo
                                                                          .advancePriceKey]
                                                                  .toString()),
                                                            )
                                                          ],
                                                        ),
                                                      ),

                                                      /// Engine Number..........................
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(top: 6.0),
                                                        child: Row(
                                                          children: [
                                                            const Text(
                                                                'Engine No :',
                                                                style: TextStyle(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    fontSize:
                                                                        15)),
                                                            Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .only(
                                                                        left:
                                                                            5.0),
                                                                child: Text(singleInfoCustomer[
                                                                        ModelCustomerInfo
                                                                            .engineNoKey]
                                                                    .toString())),
                                                          ],
                                                        ),
                                                      ),

                                                      /// Guarantor phone number................................
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(top: 6.0),
                                                        child: Row(
                                                          children: [
                                                            const Text(
                                                                'Guarantor Phone NO :',
                                                                style: TextStyle(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    fontSize:
                                                                        15)),
                                                            Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .only(
                                                                        left:
                                                                            5.0),
                                                                child: Text(singleInfoCustomer[
                                                                        ModelCustomerInfo
                                                                            .guranterPhoneNoKey]
                                                                    .toString())),
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  )),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              top: 16.0, bottom: 16),
                                          child: SingleChildScrollView(
                                            scrollDirection: Axis.horizontal,
                                            child: Screenshot(
                                              controller: screenshotController,
                                              child: SizedBox(
                                                width: MediaQuery.of(context)
                                                            .size
                                                            .width >
                                                        600
                                                    ? MediaQuery.of(context)
                                                            .size
                                                            .width *
                                                        .9
                                                    : 600,
                                                child: Table(
                                                  defaultColumnWidth:
                                                      const FixedColumnWidth(
                                                          120),
                                                  border: TableBorder.all(
                                                      color: Colors.white,
                                                      style: BorderStyle.solid,
                                                      width: 2),
                                                  children: List.generate(
                                                    singleInfoCustomer[
                                                            ModelCustomerInfo
                                                                .maxInstallmentKey] +
                                                        1,
                                                    (tableIndex) => TableRow(
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8.0),
                                                          child: SizedBox(
                                                            height: 30,
                                                            child: Center(
                                                                child: tableIndex ==
                                                                        0
                                                                    ? const Text(
                                                                        'Date',
                                                                        style: TextStyle(
                                                                            fontSize:
                                                                                15,
                                                                            fontWeight:
                                                                                FontWeight.bold,
                                                                            color: Colors.white),
                                                                      )
                                                                    : Text(
                                                                        DateTime(
                                                                                date!.year,
                                                                                date!.month + (tableIndex - 1),
                                                                                tableIndex < 2 ? date!.day : 05)
                                                                            .toString()
                                                                            .substring(0, 10),
                                                                      )),
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8.0),
                                                          child: SizedBox(
                                                            height: 30,
                                                            child: Center(
                                                                child: tableIndex ==
                                                                        0
                                                                    ? const Text(
                                                                        'Payable',
                                                                        style: TextStyle(
                                                                            fontSize:
                                                                                15,
                                                                            fontWeight:
                                                                                FontWeight.bold,
                                                                            color: Colors.white),
                                                                      )
                                                                    : Text(singleInfoCustomer[
                                                                            ModelCustomerInfo
                                                                                .payableInstallmentKey][tableIndex -
                                                                            1]
                                                                        .toString())),
                                                          ),
                                                        ),
                                                        Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(8.0),
                                                            child: SizedBox(
                                                              height: 30,
                                                              child: Center(
                                                                  child: tableIndex ==
                                                                          0
                                                                      ? const Text(
                                                                          'Status',
                                                                          style: TextStyle(
                                                                              fontSize: 15,
                                                                              fontWeight: FontWeight.bold,
                                                                              color: Colors.white),
                                                                        )
                                                                      : singleInfoCustomer[ModelCustomerInfo.paidStatusKey][tableIndex - 1] ==
                                                                              'unpaid'
                                                                          ? TextButton(
                                                                              onPressed: () async {
                                                                                referenceController.clear();
                                                                                DbHandler.user != null ? referenceController.text = 'admin' : referenceController.text;
                                                                                print('${referenceController.text}//////////////');
                                                                                showDialog(
                                                                                    context: context,
                                                                                    builder: (context) {
                                                                                      return Center(
                                                                                        child: Material(
                                                                                          child: SizedBox(
                                                                                            height: 150,
                                                                                            width: 300,
                                                                                            child: Padding(
                                                                                              padding: const EdgeInsets.all(8.0),
                                                                                              child: Column(
                                                                                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                                                                children: [
                                                                                                  TextFormField(
                                                                                                    controller: referenceController,
                                                                                                    decoration: const InputDecoration(
                                                                                                      border: OutlineInputBorder(),
                                                                                                      focusedBorder: OutlineInputBorder(),
                                                                                                      label: Text(
                                                                                                        'Reference No',
                                                                                                        style: TextStyle(color: Colors.white),
                                                                                                      ),
                                                                                                    ),
                                                                                                  ),
                                                                                                  Row(
                                                                                                    mainAxisAlignment: MainAxisAlignment.end,
                                                                                                    children: [
                                                                                                      TextButton(
                                                                                                          onPressed: () async {
                                                                                                            if (singleInfoCustomer[ModelCustomerInfo.empRefKey].toString() == referenceController.text.toString() || referenceController.text.toString() == 'admin') {
                                                                                                              setState(() {
                                                                                                                Navigator.pop(context);
                                                                                                              });

                                                                                                              showDialog(
                                                                                                                  context: context,
                                                                                                                  builder: (context) {
                                                                                                                    return AlertDialog(
                                                                                                                      title: const Text('Payment'),
                                                                                                                      content: const Text('Would you like pay whole installment'),
                                                                                                                      actions: [
                                                                                                                        TextButton(
                                                                                                                            onPressed: () {
                                                                                                                              Navigator.pop(context);
                                                                                                                            },
                                                                                                                            child: const Text('Cancel')),
                                                                                                                        TextButton(
                                                                                                                            onPressed: () async {
                                                                                                                              Navigator.pop(context);
                                                                                                                              controllerAmount.clear();
                                                                                                                              _showModalBottomSheet(installment: '', index: tableIndex - 1, amount: singleInfoCustomer[ModelCustomerInfo.remainingInstallmentKey][tableIndex - 1], date: '', paidStatusList: [], paidOutstandingList: [], time: '', mainContext: context);
                                                                                                                            },
                                                                                                                            child: const Text('No')),
                                                                                                                        TextButton(
                                                                                                                            onPressed: () async {
                                                                                                                              singleInfoCustomer[ModelCustomerInfo.remainingPriceKey] = singleInfoCustomer[ModelCustomerInfo.remainingPriceKey] - singleInfoCustomer[ModelCustomerInfo.remainingInstallmentKey][tableIndex - 1];
                                                                                                                              singleInfoCustomer[ModelCustomerInfo.paidStatusKey][tableIndex - 1] = 'paid';

                                                                                                                              singleInfoCustomer[ModelCustomerInfo.remainingInstallmentKey][tableIndex - 1] = 0.0;

                                                                                                                              setState(() {
                                                                                                                                Navigator.pop(context);
                                                                                                                              });
                                                                                                                            },
                                                                                                                            child: const Text('yes'))
                                                                                                                      ],
                                                                                                                    );
                                                                                                                  });
                                                                                                            } else {
                                                                                                              showDialog(
                                                                                                                  context: context,
                                                                                                                  builder: (context) {
                                                                                                                    return AlertDialog(
                                                                                                                      content: const Text('This reference No is no allowed'),
                                                                                                                      actions: [
                                                                                                                        TextButton(
                                                                                                                            onPressed: () {
                                                                                                                              Navigator.pop(context);
                                                                                                                            },
                                                                                                                            child: const Text('ok'))
                                                                                                                      ],
                                                                                                                    );
                                                                                                                  });
                                                                                                            }
                                                                                                          },
                                                                                                          child: const Text('OK')),
                                                                                                      TextButton(
                                                                                                          onPressed: () {
                                                                                                            Navigator.pop(context);
                                                                                                          },
                                                                                                          child: const Text('CANCEL')),
                                                                                                    ],
                                                                                                  )
                                                                                                ],
                                                                                              ),
                                                                                            ),
                                                                                          ),
                                                                                        ),
                                                                                      );
                                                                                    });
                                                                              },
                                                                              child: Text(
                                                                                singleInfoCustomer[ModelCustomerInfo.paidStatusKey][tableIndex - 1].toString(),
                                                                              ),
                                                                            )
                                                                          : Text(
                                                                              singleInfoCustomer[ModelCustomerInfo.paidStatusKey][tableIndex - 1].toString())),
                                                            )),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8.0),
                                                          child: SizedBox(
                                                            height: 30,
                                                            child: Center(
                                                                child: tableIndex ==
                                                                        0
                                                                    ? const Text(
                                                                        'Remaining',
                                                                        style: TextStyle(
                                                                            fontSize:
                                                                                15,
                                                                            fontWeight:
                                                                                FontWeight.bold,
                                                                            color: Colors.white),
                                                                      )
                                                                    : Text(singleInfoCustomer[
                                                                            ModelCustomerInfo
                                                                                .remainingInstallmentKey][tableIndex -
                                                                            1]
                                                                        .toString())),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Align(
                                          alignment: Alignment.centerRight,
                                          child: SizedBox(
                                            height: ConstValue.buttonHeight,
                                            width: ConstValue.buttonWidth,
                                            child: ElevatedButton(
                                              onPressed: () async {
                                                final imageByteData =
                                                    await rootBundle.load(
                                                        'assets/motha.jpg');
                                                final imageUint8List =
                                                    imageByteData
                                                        .buffer
                                                        .asUint8List(
                                                            imageByteData
                                                                .offsetInBytes,
                                                            imageByteData
                                                                .lengthInBytes);

                                                final imageByteData1 =
                                                    await rootBundle.load(
                                                        'assets/motha1.png');

                                                final imageUint8List1 =
                                                    imageByteData1.buffer
                                                        .asUint8List(
                                                            imageByteData1
                                                                .offsetInBytes,
                                                            imageByteData1
                                                                .lengthInBytes);

                                                await createPDFANDExportPrint(
                                                    singleInfoCustomer,
                                                    imageUint8List,
                                                    imageUint8List1,
                                                    date!);
                                              },
                                              child: const Text('PRINT'),
                                            ),
                                          ),
                                        )
                                      ],
                                    )),
                                  ),
                                ),
                              )
                        : const SizedBox(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _showModalBottomSheet(
      {required String installment,
      required double amount,
      required String date,
      required int index,
      required List paidStatusList,
      required List paidOutstandingList,
      required String time,
      required BuildContext mainContext}) {
    showModalBottomSheet(
      enableDrag: true,
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      isDismissible: false,
      builder: (bottomSheetContext) {
        return Padding(
          padding: MediaQuery.of(bottomSheetContext).viewInsets,
          child: Container(
            height: MediaQuery.of(bottomSheetContext).size.height * .4,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.grey.shade200,
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20), topRight: Radius.circular(20)),
            ),
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Form(
                key: amountGlobalKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    CustomProfileWidget.customProfileText(
                        text: amount.toString(),
                        title: 'Total Installment',
                        context: bottomSheetContext),
                    CustomWidget.customTextField(
                        controller: controllerAmount,
                        textInputType: TextInputType.number,
                        icon: Icons.discount,
                        titleName: 'Enter Amount',
                        validate: (String? value) {
                          if (value!.isNotEmpty) {
                            if (amount >=
                                double.parse(
                                    controllerAmount.text.toString())) {
                              return null;
                            } else {
                              return 'Amount must less than installment amount';
                            }
                          } else {
                            return 'required';
                          }
                        }),
                    ElevatedButton(
                        onPressed: () async {
                          if (amountGlobalKey.currentState!.validate()) {
                            singleInfoCustomer[ModelCustomerInfo
                                .remainingPriceKey] = singleInfoCustomer[
                                    ModelCustomerInfo.remainingPriceKey] -
                                double.parse(controllerAmount.text.toString());
                            singleInfoCustomer[
                                    ModelCustomerInfo.remainingInstallmentKey]
                                [index] = singleInfoCustomer[ModelCustomerInfo
                                    .remainingInstallmentKey][index] -
                                double.parse(controllerAmount.text.toString());

                            if (singleInfoCustomer[ModelCustomerInfo
                                    .remainingInstallmentKey][index] ==
                                0) {
                              singleInfoCustomer[ModelCustomerInfo
                                  .paidStatusKey][index] = 'paid';
                            }
                            DbHandler.customerCollection()
                                .doc(singleInfoCustomer[
                                    ModelCustomerInfo.regNoKey])
                                .update(singleInfoCustomer);

                            setState(() {
                              Navigator.pop(context);
                            });
                          }
                        },
                        child: const Text('Submit')),
                    SizedBox(
                      height: 50,
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
