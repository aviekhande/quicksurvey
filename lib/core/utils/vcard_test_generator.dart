// import 'dart:io';
// import 'dart:math';
// import 'package:path_provider/path_provider.dart';
// import 'package:flutter/foundation.dart';
// import 'package:share_plus/share_plus.dart';

// class VCardTestGenerator {
//   static final Random _random = Random();

//   // Diverse name components with special characters
//   static final List<String> firstNames = [
//     'José',
//     'María',
//     'François',
//     'Björn',
//     'Åse',
//     'Müller',
//     'François-Xavier',
//     'Jean-Luc',
//     'Anne-Marie',
//     'O\'Connor',
//     'D\'Angelo',
//     'McPherson',
//     'Van Der Berg',
//     '李',
//     '王',
//     '张',
//     '刘',
//     'محمد',
//     'أحمد',
//     'علي',
//     'فاطمة',
//     'Владимир',
//     'Александр',
//     'Наталья',
//     'Елена',
//     'Hiroshi',
//     'Takeshi',
//     'Yuki',
//     'Sakura',
//     'Priya',
//     'Raj',
//     'Sanjay',
//     'Deepika',
//     'João',
//     'Ana',
//     'Carlos',
//     'Isabella',
//     'Giovanni',
//     'Francesca',
//     'Hans',
//     'Greta',
//     'Klaus',
//     'Ingrid',
//     'Pierre',
//     'Sophie',
//     'Thomas',
//     'Emma',
//     'Olaf',
//     'Astrid',
//     'Nils',
//     'Sigrid',
//     'Dimitri',
//     'Katarina',
//     'Mikael',
//     'Linnea',
//     'Abdul',
//     'Fatima',
//     'Hassan',
//     'Zara',
//     'Chen',
//     'Lin',
//     'Wu',
//     'Zhou',
//     'Roberto',
//     'Carmen',
//     'Diego',
//     'Esperanza',
//     'Kwame',
//     'Ama',
//     'Kofi',
//     'Akosua',
//   ];

//   static final List<String> lastNames = [
//     'García',
//     'Rodríguez',
//     'González',
//     'Fernández',
//     'López',
//     'Martínez',
//     'Sánchez',
//     'Pérez',
//     'Gómez',
//     'Martín',
//     'Jiménez',
//     'Ruiz',
//     'Hernández',
//     'Díaz',
//     'Moreno',
//     'Muñoz',
//     'Álvarez',
//     'Romero',
//     'Alonso',
//     'Gutiérrez',
//     'Navarro',
//     'Torres',
//     'Domínguez',
//     'Vázquez',
//     'Ramos',
//     'Gil',
//     'Ramírez',
//     'Serrano',
//     'Blanco',
//     'Suárez',
//     'Molina',
//     'Morales',
//     'Ortega',
//     'Delgado',
//     'Castro',
//     'Ortiz',
//     'Rubio',
//     'Marín',
//     'Sanz',
//     'Iglesias',
//     'Medina',
//     'Garrido',
//     'Cortés',
//     'Castillo',
//     'Santos',
//     'Lozano',
//     'Guerrero',
//     'Cano',
//     'Prieto',
//     'Méndez',
//     'Cruz',
//     'Flores',
//     'Herrera',
//     'Peña',
//     'León',
//     'Marquez',
//     'Cabrera',
//     'Gallego',
//     'Calvo',
//     'Vidal',
//     'Campos',
//     'Reyes',
//     'Vega',
//     'Fuentes',
//     'Carrasco',
//     'Díez',
//     'Caballero',
//     'Nieto',
//     'Aguilar',
//     'Pascual',
//     'Herrero',
//     'Montero',
//     'Lorenzo',
//     'Hidalgo',
//     'Giménez',
//     'Ibáñez',
//     'Ferrer',
//     'Duran',
//     'Santiago',
//     'Benítez',
//     'Mora',
//     'Vicente',
//     'Arias',
//     'Vargas',
//     'Carmona',
//     'Crespo',
//     'Roman',
//     'Pastor',
//     'Soto',
//     'Sáez',
//     'Velasco',
//     'Moya',
//     'Soler',
//     'Parra',
//     'Esteban',
//     'Bravo',
//     'Gallardo',
//     'Rojas',
//     'Estévez',
//     'Segura',
//     'Valls',
//     'Montoya',
//     'O\'Sullivan',
//     'O\'Brien',
//     'O\'Connor',
//     'McDonald',
//     'MacLeod',
//     'MacKenzie',
//     'Van Der Berg',
//     'Van Der Meer',
//     'De Jong',
//     'De Wit',
//     'De Vries',
//     'De Boer',
//   ];

//   static final List<String> countryPrefixes = [
//     '+1',
//     '+44',
//     '+33',
//     '+49',
//     '+39',
//     '+34',
//     '+91',
//     '+86',
//     '+81',
//     '+55',
//     '+52',
//     '+61',
//     '+7',
//     '+47',
//     '+46',
//     '+45',
//     '+31',
//     '+32',
//     '+41',
//     '+43',
//   ];

//   static final List<String> phoneFormats = [
//     '(###) ###-####',
//     '###-###-####',
//     '### ### ####',
//     '###.###.####',
//     '### ### ## ##',
//     '####-###-###',
//     '## ## ## ## ##',
//     '###-##-##-##',
//     '(###)###-####',
//     '### ### ###',
//   ];

//   /// Generates a random phone number with various formats
//   static String generatePhoneNumber() {
//     String prefix = countryPrefixes[_random.nextInt(countryPrefixes.length)];
//     String format = phoneFormats[_random.nextInt(phoneFormats.length)];

//     String number = format.replaceAllMapped(RegExp(r'#'), (match) {
//       return _random.nextInt(10).toString();
//     });

//     // Sometimes add spaces, sometimes don't
//     if (_random.nextBool()) {
//       return '$prefix $number';
//     } else {
//       return '$prefix$number';
//     }
//   }

//   /// Generates a unique name with special characters
//   static String generateName(int index) {
//     String firstName = firstNames[_random.nextInt(firstNames.length)];
//     String lastName = lastNames[_random.nextInt(lastNames.length)];

//     // Add some variations
//     List<String> variations = [
//       '$firstName $lastName',
//       '$firstName-$lastName',
//       '$lastName, $firstName',
//       'Dr. $firstName $lastName',
//       '$firstName $lastName Jr.',
//       '$firstName $lastName Sr.',
//       '$firstName de $lastName',
//       '$firstName van $lastName',
//       '$firstName O\'$lastName',
//       '$firstName Mc$lastName',
//       '$firstName-Pierre $lastName',
//       '$firstName $lastName III',
//       'Prof. $firstName $lastName',
//       '$firstName $lastName-Smith',
//       '$firstName & $lastName',
//     ];

//     String name = variations[_random.nextInt(variations.length)];

//     // Ensure uniqueness by adding index if needed
//     return '$name #$index';
//   }

//   /// Converts a contact to vCard format (preserving all special characters)
//   static String contactToVCardString(
//     String name,
//     String phoneNumber, // Changed from List<String> to String
//     int index,
//   ) {
//     StringBuffer vcard = StringBuffer();

//     vcard.writeln('BEGIN:VCARD');
//     vcard.writeln('VERSION:3.0');
//     vcard.writeln('PRODID:ez-vcard 0.12.1');

//     // Name - preserve all special characters
//     vcard.writeln('FN:$name');

//     // Add single phone number
//     vcard.writeln('TEL:$phoneNumber');

//     // Add some additional fields with special characters occasionally
//     if (_random.nextInt(5) == 0) {
//       vcard.writeln(
//         'EMAIL:${name.toLowerCase().replaceAll(' ', '.').replaceAll('#', '')}@example.com',
//       );
//     }

//     if (_random.nextInt(10) == 0) {
//       List<String> organizations = [
//         'Müller & Söhne GmbH',
//         'José María & Co.',
//         'O\'Connor Industries',
//         'François-Xavier Ltd.',
//         'Björn & Associates',
//       ];
//       vcard.writeln(
//         'ORG:${organizations[_random.nextInt(organizations.length)]}',
//       );
//     }

//     vcard.writeln('END:VCARD');
//     return vcard.toString();
//   }

//   /// Creates a VCF file with 1000 test contacts and returns the file
//   static Future<File> createTestVCardFile({
//     String filename = 'test_contacts_1000.vcf',
//   }) async {
//     StringBuffer vCardContent = StringBuffer();

//     debugPrint('Generating 1000 test contacts...');

//     for (int i = 1; i <= 1000; i++) {
//       String name = generateName(i);

//       // Generate only one phone number per contact
//       String phoneNumber = generatePhoneNumber();

//       vCardContent.write(contactToVCardString(name, phoneNumber, i));

//       // Progress indicator
//       if (i % 100 == 0) {
//         debugPrint('Generated $i contacts...');
//       }
//     }

//     // Get writable directory
//     final directory = await getApplicationDocumentsDirectory();
//     final file = File('${directory.path}/$filename');
//     await file.writeAsString(vCardContent.toString());

//     debugPrint('Created VCF file: ${file.absolute.path}');
//     debugPrint('File size: ${await file.length()} bytes');
//     debugPrint('Total contacts: 1000');

//     return file;
//   }

//   /// Creates and immediately shares a VCF file with 1000 test contacts
//   static Future<void> createAndShareTestVCardFile({
//     String filename = 'test_contacts_1000.vcf',
//   }) async {
//     try {
//       // Create the VCF file
//       File vcfFile = await createTestVCardFile(filename: filename);

//       // Share the file
//       await shareVCardFile(vcfFile);
//     } catch (e) {
//       debugPrint('Error creating and sharing VCF file: $e');
//       rethrow;
//     }
//   }

//   /// Shares an existing VCF file
//   static Future<void> shareVCardFile(File vcfFile) async {
//     try {
//       // Check if file exists
//       if (!await vcfFile.exists()) {
//         throw Exception('VCF file does not exist at path: ${vcfFile.path}');
//       }

//       // Share the file with a descriptive message
//       await Share.shareXFiles(
//         [XFile(vcfFile.path)],
//         text: 'Test VCF file with 1000 contacts for testing purposes',
//         subject: 'Test Contacts VCF File',
//       );

//       debugPrint('VCF file shared successfully');
//     } catch (e) {
//       debugPrint('Error sharing VCF file: $e');
//       rethrow;
//     }
//   }

//   /// Quick method to generate and share VCF with custom contact count
//   static Future<void> generateAndShareCustomVCF({
//     int contactCount = 1000,
//     String filename = 'custom_test_contacts.vcf',
//   }) async {
//     try {
//       StringBuffer vCardContent = StringBuffer();

//       debugPrint('Generating $contactCount test contacts...');

//       for (int i = 1; i <= contactCount; i++) {
//         String name = generateName(i);

//         // Generate only one phone number per contact
//         String phoneNumber = generatePhoneNumber();

//         vCardContent.write(contactToVCardString(name, phoneNumber, i));

//         // Progress indicator
//         if (i % 100 == 0 || i == contactCount) {
//           debugPrint('Generated $i contacts...');
//         }
//       }

//       // Get writable directory and create file
//       final directory = await getApplicationDocumentsDirectory();
//       final file = File('${directory.path}/$filename');
//       await file.writeAsString(vCardContent.toString());

//       debugPrint('Created VCF file: ${file.absolute.path}');
//       debugPrint('File size: ${await file.length()} bytes');
//       debugPrint('Total contacts: $contactCount');

//       // Share immediately
//       await shareVCardFile(file);
//     } catch (e) {
//       debugPrint('Error generating and sharing custom VCF: $e');
//       rethrow;
//     }
//   }
// }

// // Alternative function if you want to generate with custom filename
// Future<File> generateCustomTestFile(String filename) async {
//   return await VCardTestGenerator.createTestVCardFile(filename: filename);
// }
