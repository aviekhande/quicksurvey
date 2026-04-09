// import 'dart:io';
// import 'package:flutter/foundation.dart';
// import 'package:flutter_contacts/flutter_contacts.dart';
// import 'package:path_provider/path_provider.dart';

// // Data class to pass parameters to isolate
// class ContactsProcessingParams {
//   final List<Contact> contacts;
//   final String tempDirectoryPath;
//   final String? filename;

//   ContactsProcessingParams({
//     required this.contacts,
//     required this.tempDirectoryPath,
//     this.filename,
//   });
// }

// // Data class for isolate result
// class ContactsProcessingResult {
//   final List<Contact> filteredContacts;
//   final File? vcardFile;
//   final String? error;

//   ContactsProcessingResult({
//     required this.filteredContacts,
//     this.vcardFile,
//     this.error,
//   });
// }

// class VCardUtils {
//   /// Converts a single contact to simplified vCard format string
//   static String contactToVCardString(Contact contact) {
//     StringBuffer vcard = StringBuffer();
//     vcard.writeln('BEGIN:VCARD');
//     vcard.writeln('VERSION:3.0');
//     vcard.writeln('PRODID:ez-vcard 0.12.1');

//     // Name - just use display name
//     vcard.writeln('FN:${contact.displayName}');

//     // Phone numbers - with deduplication
//     Set<String> uniquePhoneNumbers = {};
//     for (var phone in contact.phones) {
//       // Normalize the phone number by removing common formatting characters
//       String normalizedNumber = phone.number;
//       // Only add if this normalized number hasn't been seen before
//       if (uniquePhoneNumbers.add(normalizedNumber)) {
//         vcard.writeln('TEL:${phone.number}');
//       }
//     }

//     vcard.writeln('END:VCARD');
//     return vcard.toString();
//   }

//   /// Creates a VCF file from a list of contacts
//   static Future<File> createVCardFile(
//     List<Contact> contacts, {
//     String? filename,
//   }) async {
//     // Generate default filename if not provided
//     filename ??= 'contacts_${DateTime.now().millisecondsSinceEpoch}.vcf';

//     // Generate vCard content
//     StringBuffer vCardContent = StringBuffer();
//     for (var contact in contacts) {
//       vCardContent.write(contactToVCardString(contact));
//     }

//     // Save to temporary file
//     final directory = await getTemporaryDirectory();
//     final file = File('${directory.path}/$filename');
//     await file.writeAsString(vCardContent.toString());

//     debugPrint('Created .vcf file at: ${file.path}');
//     return file;
//   }

//   /// Creates a VCF file from contact IDs and all available contacts
//   static Future<File> createVCardFileFromIds(
//     Set<String> contactIds,
//     List<Contact> allContacts, {
//     String? filename,
//   }) async {
//     List<Contact> selectedContacts = allContacts
//         .where((contact) => contactIds.contains(contact.id))
//         .toList();
//     return createVCardFile(selectedContacts, filename: filename);
//   }

//   /// Process contacts in isolate - filters and creates vCard file
//   static Future<ContactsProcessingResult> processContactsInIsolate(
//     List<Contact> contacts, {
//     String? filename,
//   }) async {
//     try {
//       // Get temp directory path for isolate
//       final directory = await getTemporaryDirectory();

//       final params = ContactsProcessingParams(
//         contacts: contacts,
//         tempDirectoryPath: directory.path,
//         filename: filename,
//       );

//       // Run processing in isolate
//       final result = await compute(_processContactsIsolate, params);
//       return result;
//     } catch (e) {
//       debugPrint('Error processing contacts in isolate: $e');
//       return ContactsProcessingResult(
//         filteredContacts: [],
//         error: e.toString(),
//       );
//     }
//   }

//   /// Isolate function for processing contacts
//   static ContactsProcessingResult _processContactsIsolate(
//     ContactsProcessingParams params,
//   ) {
//     try {
//       // Filter contacts with phone numbers
//       final filteredContacts = params.contacts
//           .where(
//             (contact) =>
//                 contact.phones.isNotEmpty && contact.displayName.isNotEmpty,
//           )
//           .toList();

//       // Generate filename if not provided
//       final filename =
//           params.filename ??
//           'contacts_${DateTime.now().millisecondsSinceEpoch}.vcf';

//       // Generate vCard content
//       StringBuffer vCardContent = StringBuffer();
//       for (var contact in filteredContacts) {
//         vCardContent.write(contactToVCardString(contact));
//       }

//       // Create file
//       final file = File('${params.tempDirectoryPath}/$filename');
//       file.writeAsStringSync(vCardContent.toString());

//       return ContactsProcessingResult(
//         filteredContacts: filteredContacts,
//         vcardFile: file,
//       );
//     } catch (e) {
//       return ContactsProcessingResult(
//         filteredContacts: [],
//         error: e.toString(),
//       );
//     }
//   }
// }

// // Enhanced contacts service class
// class ContactsService {
//   static Future<ContactsProcessingResult> fetchAndProcessContacts({
//     String? filename,
//   }) async {
//     try {
//       // Fetch contacts from device
//       final contacts = await FlutterContacts.getContacts(
//         withProperties: true,
//         withPhoto: false,
//         withThumbnail: false,
//       );

//       // Process in isolate
//       return await VCardUtils.processContactsInIsolate(
//         contacts,
//         filename: filename,
//       );
//     } catch (e) {
//       debugPrint('Error fetching contacts: $e');
//       return ContactsProcessingResult(
//         filteredContacts: [],
//         error: e.toString(),
//       );
//     }
//   }
// }

// // import 'dart:io';
// // import 'package:flutter/foundation.dart';
// // import 'package:flutter_contacts/flutter_contacts.dart';
// // import 'package:path_provider/path_provider.dart';

// // class VCardUtils {
// //   /// Converts a single contact to simplified vCard format string
// //   static String contactToVCardString(Contact contact) {
// //     StringBuffer vcard = StringBuffer();

// //     vcard.writeln('BEGIN:VCARD');
// //     vcard.writeln('VERSION:3.0');
// //     vcard.writeln('PRODID:ez-vcard 0.12.1');

// //     // Name - just use display name
// //     vcard.writeln('FN:${contact.displayName}');

// //     // Phone numbers - with deduplication
// //     Set<String> uniquePhoneNumbers = {};

// //     for (var phone in contact.phones) {
// //       // Normalize the phone number by removing common formatting characters
// //       String normalizedNumber = phone.number;

// //       // Only add if this normalized number hasn't been seen before
// //       if (uniquePhoneNumbers.add(normalizedNumber)) {
// //         vcard.writeln('TEL:${phone.number}');
// //       }
// //     }

// //     vcard.writeln('END:VCARD');
// //     return vcard.toString();
// //   }

// //   /// Creates a VCF file from a list of contacts
// //   static Future<File> createVCardFile(
// //     List<Contact> contacts, {
// //     String? filename,
// //   }) async {
// //     // Generate default filename if not provided
// //     filename ??= 'contacts_${DateTime.now().millisecondsSinceEpoch}.vcf';

// //     // Generate vCard content
// //     StringBuffer vCardContent = StringBuffer();
// //     for (var contact in contacts) {
// //       vCardContent.write(contactToVCardString(contact));
// //     }

// //     // Save to temporary file
// //     final directory = await getTemporaryDirectory();
// //     final file = File('${directory.path}/$filename');
// //     await file.writeAsString(vCardContent.toString());

// //     debugPrint('Created .vcf file at: ${file.path}');
// //     return file;
// //   }

// //   /// Creates a VCF file from contact IDs and all available contacts
// //   static Future<File> createVCardFileFromIds(
// //     Set<String> contactIds,
// //     List<Contact> allContacts, {
// //     String? filename,
// //   }) async {
// //     List<Contact> selectedContacts = allContacts
// //         .where((contact) => contactIds.contains(contact.id))
// //         .toList();

// //     return createVCardFile(selectedContacts, filename: filename);
// //   }
// // }
