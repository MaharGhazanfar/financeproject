import 'package:financeproject/model/model_info.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

Future<void> createPDFANDExportPrint(
    Map info, var unit8, var unit82, DateTime date) async {
  final pdf = pw.Document();

  List listOfProduct = info[ModelCustomerInfo.productNameKey];

  final image = pw.MemoryImage(unit8);
  final image2 = pw.MemoryImage(unit82);
  pdf.addPage(pw.MultiPage(
      pageFormat: PdfPageFormat.a4,
      build: (pw.Context context) {
        return [
          pw.Center(
            child: pw.Column(
              children: [
                // pw.Padding(padding: const pw.EdgeInsets.only(top: 12)),
                pw.SizedBox(
                  height: 100,
                  child: pw.Image(
                    image,
                  ),
                ),

                pw.Padding(padding: const pw.EdgeInsets.only(top: 5)),

                pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: [
                    pw.Row(
                        mainAxisAlignment: pw.MainAxisAlignment.start,
                        children: [
                          pw.Text('Register Number : ',
                              style: pw.TextStyle(
                                  fontSize: 15,
                                  fontWeight: pw.FontWeight.bold)),
                          pw.Padding(
                              padding: const pw.EdgeInsets.only(left: 4)),
                          pw.Container(
                            width: 250,
                            child: pw.Text(
                              info[ModelCustomerInfo.regNoKey].toString(),
                            ),
                            decoration: const pw.BoxDecoration(
                                border: pw.Border(bottom: pw.BorderSide())),
                          ),
                        ]),
                  ],
                ),
                pw.Padding(padding: const pw.EdgeInsets.only(top: 5)),
                pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: [
                    pw.Row(children: [
                      pw.Text('Date  : ',
                          style: pw.TextStyle(
                              fontSize: 15, fontWeight: pw.FontWeight.bold)),
                      pw.Padding(padding: const pw.EdgeInsets.only(left: 4)),
                      pw.Container(
                        child: pw.Text(info[ModelCustomerInfo.dateKey]
                            .toString()
                            .substring(0, 10)),
                        decoration: const pw.BoxDecoration(
                            border: pw.Border(bottom: pw.BorderSide())),
                      ),
                    ]),
                    pw.Padding(padding: const pw.EdgeInsets.only(left: 5)),
                    pw.Row(children: [
                      pw.Text('Expiry Date : ',
                          style: pw.TextStyle(
                              fontSize: 15, fontWeight: pw.FontWeight.bold)),
                      pw.Padding(padding: const pw.EdgeInsets.only(left: 4)),
                      pw.Container(
                        child: pw.Text(
                          info[ModelCustomerInfo.expDateKey]
                              .toString()
                              .substring(0, 10),
                        ),
                        decoration: const pw.BoxDecoration(
                            border: pw.Border(bottom: pw.BorderSide())),
                      ),
                    ]),
                  ],
                ),
                pw.Padding(padding: const pw.EdgeInsets.only(top: 5)),
                pw.Row(children: [
                  pw.Text('Customer Name : ',
                      style: pw.TextStyle(
                          fontSize: 15, fontWeight: pw.FontWeight.bold)),
                  pw.Padding(padding: const pw.EdgeInsets.only(left: 4)),
                  pw.Container(
                    child: pw.Text(
                        info[ModelCustomerInfo.customerNameKey].toString()),
                    decoration: const pw.BoxDecoration(
                        border: pw.Border(bottom: pw.BorderSide())),
                  ),
                ]),
                pw.Padding(padding: const pw.EdgeInsets.only(top: 5)),
                pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                    children: [
                      pw.Row(children: [
                        pw.Text('Customer Phone No : ',
                            style: pw.TextStyle(
                                fontSize: 15, fontWeight: pw.FontWeight.bold)),
                        pw.Padding(padding: const pw.EdgeInsets.only(left: 4)),
                        pw.Container(
                          child: pw.Text(
                            info[ModelCustomerInfo.customerPhoneKey].toString(),
                          ),
                          decoration: const pw.BoxDecoration(
                              border: pw.Border(bottom: pw.BorderSide())),
                        ),
                      ]),
                      pw.Row(children: [
                        pw.Text('Customer CNIC :',
                            style: pw.TextStyle(
                                fontSize: 15, fontWeight: pw.FontWeight.bold)),
                        pw.Padding(padding: const pw.EdgeInsets.only(left: 4)),
                        pw.Container(
                          child: pw.Text(
                            info[ModelCustomerInfo.customerCNICKey].toString(),
                          ),
                          decoration: const pw.BoxDecoration(
                              border: pw.Border(bottom: pw.BorderSide())),
                        ),
                      ]),
                    ]),
                pw.Padding(padding: const pw.EdgeInsets.only(top: 5)),
                pw.Row(children: [
                  pw.Text('Customer Address : ',
                      style: pw.TextStyle(
                          fontSize: 15, fontWeight: pw.FontWeight.bold)),
                  pw.Padding(padding: const pw.EdgeInsets.only(left: 4)),
                  pw.Container(
                    child:
                        pw.Text(info[ModelCustomerInfo.addressKey].toString()),
                    decoration: const pw.BoxDecoration(
                        border: pw.Border(bottom: pw.BorderSide())),
                  ),
                ]),
                pw.Padding(padding: const pw.EdgeInsets.only(top: 5)),
                pw.Padding(
                  padding: const pw.EdgeInsets.all(6.0),
                  child: pw.ListView.builder(
                    itemCount: listOfProduct.length,
                    itemBuilder: (context, int index) => pw.Container(
                      decoration: pw.BoxDecoration(border: pw.Border.all()),
                      child: pw.Padding(
                        padding: const pw.EdgeInsets.all(8.0),
                        child: pw.Row(
                          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                          children: [
                            pw.Padding(
                              padding: const pw.EdgeInsets.only(top: 6.0),
                              child: pw.Row(children: [
                                pw.Text('Product Name : ',
                                    style: pw.TextStyle(
                                        fontSize: 15,
                                        fontWeight: pw.FontWeight.bold)),
                                pw.Padding(
                                    padding: const pw.EdgeInsets.only(left: 4)),
                                pw.Container(
                                  child: pw.Text(
                                      listOfProduct[index]['productName']),
                                  decoration: const pw.BoxDecoration(
                                      border:
                                          pw.Border(bottom: pw.BorderSide())),
                                ),
                              ]),
                            ),
                            pw.Padding(
                              padding: const pw.EdgeInsets.only(top: 6.0),
                              child: pw.Row(children: [
                                pw.Text('Price : ',
                                    style: pw.TextStyle(
                                        fontSize: 15,
                                        fontWeight: pw.FontWeight.bold)),
                                pw.Padding(
                                    padding: const pw.EdgeInsets.only(left: 4)),
                                pw.Container(
                                  child: pw.Text(
                                      listOfProduct[index]['productPrice']),
                                  decoration: const pw.BoxDecoration(
                                      border:
                                          pw.Border(bottom: pw.BorderSide())),
                                ),
                              ]),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                pw.Padding(padding: const pw.EdgeInsets.only(top: 5)),
                pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: [
                    pw.Row(children: [
                      pw.Text('Total Price  : ',
                          style: pw.TextStyle(
                              fontSize: 15, fontWeight: pw.FontWeight.bold)),
                      pw.Padding(padding: const pw.EdgeInsets.only(left: 4)),
                      pw.Container(
                        width: 100,
                        child: pw.Text(
                            info[ModelCustomerInfo.totalPriceKey].toString()),
                        decoration: const pw.BoxDecoration(
                            border: pw.Border(bottom: pw.BorderSide())),
                      ),
                    ]),
                    pw.Row(children: [
                      pw.Text('Interest : ',
                          style: pw.TextStyle(
                              fontSize: 15, fontWeight: pw.FontWeight.bold)),
                      pw.Padding(padding: const pw.EdgeInsets.only(left: 4)),
                      pw.Container(
                        width: 100,
                        child: pw.Text(
                          '${info[ModelCustomerInfo.interestKey].toString()} %',
                        ),
                        decoration: const pw.BoxDecoration(
                            border: pw.Border(bottom: pw.BorderSide())),
                      ),
                    ]),
                  ],
                ),
                pw.Padding(padding: const pw.EdgeInsets.only(top: 5)),
                pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: [
                    pw.Row(children: [
                      pw.Text('Grand Price  : ',
                          style: pw.TextStyle(
                              fontSize: 15, fontWeight: pw.FontWeight.bold)),
                      pw.Padding(padding: const pw.EdgeInsets.only(left: 4)),
                      pw.Container(
                        width: 100,
                        child: pw.Text(
                            info[ModelCustomerInfo.grandPriceKey].toString()),
                        decoration: const pw.BoxDecoration(
                            border: pw.Border(bottom: pw.BorderSide())),
                      ),
                    ]),
                    pw.Row(children: [
                      pw.Text('Advance Price : ',
                          style: pw.TextStyle(
                              fontSize: 15, fontWeight: pw.FontWeight.bold)),
                      pw.Padding(padding: const pw.EdgeInsets.only(left: 4)),
                      pw.Container(
                        width: 100,
                        child: pw.Text(
                          info[ModelCustomerInfo.advancePriceKey].toString(),
                        ),
                        decoration: const pw.BoxDecoration(
                            border: pw.Border(bottom: pw.BorderSide())),
                      ),
                    ]),
                  ],
                ),
                pw.Padding(padding: const pw.EdgeInsets.only(top: 5)),
                pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: [
                    pw.Row(children: [
                      pw.Text('Remaining Price: ',
                          style: pw.TextStyle(
                              fontSize: 15, fontWeight: pw.FontWeight.bold)),
                      pw.Padding(padding: const pw.EdgeInsets.only(left: 4)),
                      pw.Container(
                        width: 90,
                        child: pw.Text(info[ModelCustomerInfo.remainingPriceKey]
                            .toString()),
                        decoration: const pw.BoxDecoration(
                            border: pw.Border(bottom: pw.BorderSide())),
                      ),
                    ]),
                    pw.Row(children: [
                      pw.Text('Monthly Installment : ',
                          style: pw.TextStyle(
                              fontSize: 15, fontWeight: pw.FontWeight.bold)),
                      pw.Container(
                        width: 100,
                        child: pw.Text(
                          info[ModelCustomerInfo.monthlyInstallmentKey]
                              .toString(),
                        ),
                        decoration: const pw.BoxDecoration(
                            border: pw.Border(bottom: pw.BorderSide())),
                      ),
                    ]),
                  ],
                ),
                pw.Padding(padding: const pw.EdgeInsets.only(top: 5)),
                pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: [
                    pw.Row(children: [
                      pw.Text('Engine No  : ',
                          style: pw.TextStyle(
                              fontSize: 15, fontWeight: pw.FontWeight.bold)),
                      pw.Padding(padding: const pw.EdgeInsets.only(left: 4)),
                      pw.Container(
                        width: 100,
                        child: pw.Text(
                            info[ModelCustomerInfo.engineNoKey].toString()),
                        decoration: const pw.BoxDecoration(
                            border: pw.Border(bottom: pw.BorderSide())),
                      ),
                    ]),
                    pw.Row(children: [
                      pw.Text('Frame No : ',
                          style: pw.TextStyle(
                              fontSize: 15, fontWeight: pw.FontWeight.bold)),
                      pw.Padding(padding: const pw.EdgeInsets.only(left: 4)),
                      pw.Container(
                        width: 100,
                        child: pw.Text(
                          info[ModelCustomerInfo.framNoKey].toString(),
                        ),
                        decoration: const pw.BoxDecoration(
                            border: pw.Border(bottom: pw.BorderSide())),
                      ),
                    ]),
                  ],
                ),
                pw.Padding(padding: const pw.EdgeInsets.only(top: 5)),
                pw.Row(children: [
                  pw.Text('Guarantor Name : ',
                      style: pw.TextStyle(
                          fontSize: 15, fontWeight: pw.FontWeight.bold)),
                  pw.Padding(padding: const pw.EdgeInsets.only(left: 4)),
                  pw.Container(
                    child: pw.Text(
                        info[ModelCustomerInfo.guranterNameKey].toString()),
                    decoration: const pw.BoxDecoration(
                        border: pw.Border(bottom: pw.BorderSide())),
                  ),
                ]),
                pw.Padding(padding: const pw.EdgeInsets.only(top: 5)),
                pw.Row(children: [
                  pw.Text('Guarantor Phone No : ',
                      style: pw.TextStyle(
                          fontSize: 15, fontWeight: pw.FontWeight.bold)),
                  pw.Padding(padding: const pw.EdgeInsets.only(left: 4)),
                  pw.Container(
                    child: pw.Text(
                      info[ModelCustomerInfo.guranterPhoneNoKey].toString(),
                    ),
                    decoration: const pw.BoxDecoration(
                        border: pw.Border(bottom: pw.BorderSide())),
                  ),
                ]),
                pw.Padding(padding: const pw.EdgeInsets.only(top: 15)),
                pw.SizedBox(
                  height: 190,
                  child: pw.Image(image2, fit: pw.BoxFit.cover),
                ),
              ],
            ),
          ),
        ];
      })); // Center

  await Printing.layoutPdf(
      onLayout: (PdfPageFormat format) async => pdf.save());
}
