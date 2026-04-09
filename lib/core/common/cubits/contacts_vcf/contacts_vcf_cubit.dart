// import 'dart:developer';
// import 'dart:io';
// import 'package:bloc/bloc.dart';
// import 'package:caesar_cipher/core/utils/vcard_utils.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_contacts/flutter_contacts.dart';
// import 'package:flutter_libphonenumber/flutter_libphonenumber.dart';
// part 'contacts_vcf_state.dart';

// class ContactsVcfCubit extends Cubit<ContactsVcfState> {
//   ContactsVcfCubit() : super(ContactsVcfInitial());

//   Future<void> fetchAndProcessContactsVcf() async {
//     await init();
//     try {
//       emit(ContactsVcfLoading());

//       final result = await ContactsService.fetchAndProcessContacts();

//       if (result.error != null) {
//         emit(ContactsVcfError('Error processing contactsvcf: ${result.error}'));
//         return;
//       }

//       CountryWithPhoneCode? indianCountry;
//       try {
//         indianCountry = CountryManager().countries.firstWhere(
//           (country) => country.countryCode == 'IN',
//         );
//       } catch (e) {
//         // Fallback: create manually
//         indianCountry = CountryWithPhoneCode.getCountryDataByPhone('91');
//       }
//       // Create number -> name map
//       final numberNameMap = <String, String>{};

//       for (final contact in result.filteredContacts) {
//         for (final phone in contact.phones) {
//           final rawNumber = phone.number.trim();
//           if (rawNumber.isNotEmpty) {
//             try {
//               // Step 1: Add +91 if missing and number seems Indian
//               final isWithCountryCode =
//                   rawNumber.startsWith('+91') || rawNumber.startsWith('91');
//               String normalizedNumber = rawNumber;
//               if (!isWithCountryCode &&
//                   RegExp(r'^[789]\d{9}$').hasMatch(rawNumber)) {
//                 normalizedNumber = '+91$rawNumber';
//               }

//               // Step 2: Format to E.164 and parse
//               final formattedNumber = formatNumberSync(
//                 normalizedNumber,
//                 country: indianCountry,
//                 phoneNumberType: PhoneNumberType.mobile,
//                 phoneNumberFormat: PhoneNumberFormat.international,
//                 inputContainsCountryCode: true,
//               );

//               final parsed = await parse(formattedNumber);

//               // Step 3: Ensure valid Indian mobile
//               if (parsed['e164'] != null &&
//                   parsed['region_code'] == 'IN' &&
//                   RegExp(r'^\+91[789]\d{9}$').hasMatch(parsed['e164'])) {
//                 final finalDisplay = '+91${parsed['e164'].substring(3)}';
//                 numberNameMap[finalDisplay] = contact.displayName;
//               }
//             } catch (e) {
//               debugPrint('Failed to format/parse number $rawNumber: $e');
//             }
//           }
//         }
//       }
//       log("NUMBER NAME MA2: $numberNameMap ${numberNameMap.length}");
//       emit(
//         ContactsVcfLoaded(
//           filteredContactsVcf: result.filteredContacts,
//           vcardFile: result.vcardFile,
//           numberNameMap: numberNameMap,
//         ),
//       );

//       debugPrint("FILTERED CONTACTSVCF: ${result.filteredContacts.length}");
//       if (result.vcardFile != null) {
//         debugPrint("VCF FILE PATH: ${result.vcardFile!.path}");
//       }
//     } catch (e) {
//       emit(ContactsVcfError('Error in contactsvcf processing: $e'));
//     }
//   }

//   void resetContactsVcf() {
//     emit(ContactsVcfInitial());
//   }

//   // Getters for easy access
//   List<Contact> get filteredContacts {
//     final currentState = state;
//     if (currentState is ContactsVcfLoaded) {
//       return currentState.filteredContactsVcf;
//     }
//     return [];
//   }

//   File? get vcardFile {
//     final currentState = state;
//     if (currentState is ContactsVcfLoaded) {
//       return currentState.vcardFile;
//     }
//     return null;
//   }

//   bool get isLoading => state is ContactsVcfLoading;
//   bool get hasContacts =>
//       state is ContactsVcfLoaded && filteredContacts.isNotEmpty;
// }
