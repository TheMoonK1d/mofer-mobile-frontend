// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:mofer/Views/transfer_plant%20.dart';

// class Accept extends StatelessWidget {
//   const Accept({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(),
//       body: ListView(
//         children: [
//           Padding(
//               padding: const EdgeInsets.all(20),
//               child: Column(
//                 children: [
//                   Row(
//                     children: [
//                       Text(
//                         textAlign: TextAlign.start,
//                         "Please read first",
//                         style: GoogleFonts.montserrat(
//                           fontSize: 25,
//                           fontWeight: FontWeight.w900,
//                           fontStyle: FontStyle.normal,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ],
//               )),
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 20),
//             child: Text(
//               textAlign: TextAlign.start,
//               "Dear user",
//               style: GoogleFonts.montserrat(
//                 fontSize: 20,
//                 fontWeight: FontWeight.w500,
//                 fontStyle: FontStyle.normal,
//               ),
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 20),
//             child: Text(
//               '\nWe appreciate your interest in our market place. We would like to inform you about the consequences of transferring a plant from the plant status tracking system to the marketplace.\nBy choosing to transfer your plant, please note that you will no longer have access to the plant data associated with it. This includes information such as\nGrowth updates,\nCare history,\nAnd any personalized notes or observations you may have recorded.\nFurthermore, once the transfer is complete, the plant will become available for sale in the marketplace. Other users will have the opportunity to purchase and take ownership of the plant.We understand that this decision may have implications for your ongoing plant monitoring and care. If you wish to retain access to the plant data and continue tracking its progress, we recommend keeping the plant within the plant status tracking system and refraining from transferring it to the marketplace.Please consider this information carefully before proceeding with the transfer. If you have any further questions or concerns, dont hesitate to reach out to our support team.\n\nThank you for your understanding.\n\nBest regards,\nMofer Team',
//               style: GoogleFonts.montserrat(
//                 fontSize: 15,
//                 fontWeight: FontWeight.w200,
//                 fontStyle: FontStyle.normal,
//               ),
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.all(20),
//             child: ElevatedButton(
//               onPressed: () {
//                 Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                         builder: (context) => const TransferPlant(

//                         )));
//               },
//               child: Text(
//                 textAlign: TextAlign.start,
//                 "Accept and Continue",
//                 style: GoogleFonts.montserrat(
//                   fontSize: 20,
//                   fontWeight: FontWeight.w500,
//                   fontStyle: FontStyle.normal,
//                 ),
//               ),
//             ),
//           )
//         ],
//       ),
//     );
//   }
// }
