import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: QRView(),
      ),
    );
  }
}

class QRView extends StatefulWidget {
  const QRView({Key? key});

  @override
  _QRViewState createState() => _QRViewState();
}

class _QRViewState extends State<QRView> {
  String searchText = "";
  String qrCodeImageURL = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.black),
      body: Container(
        color: Colors.black,
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.all(15.0),
              child: Row(
                children: [
                  Text(
                    "QR \nGenerator :)",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w100,
                      fontSize: 50,
                    ),
                  ),
                  Spacer(),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10.0, right: 10.0),
              child: Row(
                children: [
                  Expanded(
                    child: SizedBox(
                      height: 60,
                      width: MediaQuery.of(context).size.width - 85,
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: "Enter text",
                          filled: true,
                          fillColor: Colors.white.withOpacity(0.1),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide.none,
                          ),
                        ),
                        style: const TextStyle(color: Colors.white),
                        onChanged: (value) {
                          setState(() {
                            searchText = value;
                          });
                        },
                      ),
                    ),
                  ),
                  const SizedBox(width: 5,),
                  generateQRCodeButton(),
                ],
              ),
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: generateQRCodeImage()
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }

  Widget generateQRCodeButton() {
    return GestureDetector(
      onTap: () {
        if (searchText.isNotEmpty) {
          String encodedText = Uri.encodeQueryComponent(searchText);
          setState(() {
            qrCodeImageURL =
            "https://chart.googleapis.com/chart?cht=qr&chs=500x500&chl=$encodedText";
          });
        }
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.blue,
          borderRadius: BorderRadius.circular(8),
        ),
        child: const Icon(
          Icons.qr_code,
          color: Colors.white,
          size: 25,
        ),
      ),
    );
  }

  Widget generateQRCodeImage() {
    return Container(
      width: 300,
      height: 300,

      decoration:  BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        image: DecorationImage(
          image: NetworkImage(qrCodeImageURL), // Replace with your image path
          fit: BoxFit.cover, // You can change the BoxFit as per your requirement
        ),
      ),


      child:  Column(children: [
        qrCodeImageURL.isEmpty ? const Text(
        "QR Code Will Appear Here",
        style: TextStyle(color: Colors.white),
      ): const SizedBox(height: 0,)

      ],),
    );
  }

  String generateQRCodeString() {
    return qrCodeImageURL.toString();
  }
}