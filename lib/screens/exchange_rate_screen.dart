import 'package:book_store/model/exchange_rate.dart';
import 'package:book_store/model/rate.dart';
import 'package:book_store/service/api_helper.dart';
import 'package:flutter/material.dart';

class ExchangeRateScreen extends StatefulWidget {
  const ExchangeRateScreen({super.key});

  @override
  State<ExchangeRateScreen> createState() => _ExchangeRateScreenState();
}

class _ExchangeRateScreenState extends State<ExchangeRateScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Exchange Rate'),
      ),
      body: const Body(),
    );
  }
}

class Body extends StatefulWidget {
  const Body({
    Key? key,
  }) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<ExchangeRate>(
      future: ApiHelper.getAllData(),
      builder: (context, snapshot) {
        return snapshot.connectionState == ConnectionState.waiting
            ? const Center(child: CircularProgressIndicator())
            : Center(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Text(snapshot.data!.info),
                      Text(snapshot.data!.description),
                      // RateList(),
                    ],
                  ),
                ),
              );
      },
    );
  }
}

// class RateList extends StatelessWidget {
//   const RateList({
//     Key? key,
//   }) : super(key: key);
//   @override
//   Widget build(BuildContext context) {
//     return FutureBuilder<List<Rates>>(
//       future: ApiHelper.getAllData(),
//       builder: (context, snapshot) {
//         return snapshot.connectionState == ConnectionState.waiting
//             ? const Center(child: CircularProgressIndicator())
//             : Center(
//                 child: Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: Column(
//                     children: [
//                       Text(snapshot.data!.info),
//                       Text(snapshot.data!.description),
//                       RateList(),
//                     ],
//                   ),
//                 ),
//               );
//       },
//     )
//   }
// }
