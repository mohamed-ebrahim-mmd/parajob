import 'package:flutter/material.dart';
import 'package:para_job/packages/themeing/app_colors.dart';
import 'package:para_job/packages/themeing/media_query_values.dart';

class CustomEditImage extends StatelessWidget {
  const CustomEditImage({super.key, required this.img,this.onEdit});
  final String img;
 final VoidCallback? onEdit;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(context.wPct(4)),
      child: Stack(
        children: [
          Image.network(
            img,
            width: double.infinity,
            height: context.hPct(30),
            fit: BoxFit.cover,
            // Show loading indicator while image loads
            loadingBuilder: (context, child, loadingProgress) {
              if (loadingProgress == null) return child;
              return Container(
                color: AppColors.lightGray,
                alignment: Alignment.center,
                child: const CircularProgressIndicator(strokeWidth: 2),
              );
            },
            // Handle error case (broken link, no internet, etc.)
            errorBuilder: (context, error, stackTrace) {
              return Container(
                width: double.infinity,
                height: context.hPct(30),
                color: Colors.grey.shade300,
                alignment: Alignment.center,
                child: const Icon(
                  Icons.broken_image_outlined,
                  size: 50,
                  color: AppColors.lightGrey,
                ),
              );
            },
          ),

          GestureDetector(
            onTap:onEdit ,
            child: Container(
              width: double.infinity,
              height: context.hPct(30),
              color: const Color.fromARGB(217, 0, 0, 0).withOpacity(0.6),
              alignment: Alignment.center,
              child: Center(
                child: CircleAvatar(
                  backgroundColor: const Color(0x80FFFFFF),
                  radius: context.wPct(7),
                  child: Icon(Icons.edit),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
































// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:para_job/packages/themeing/app_colors.dart';
// import 'package:para_job/packages/themeing/media_query_values.dart';

// class CustomEditImage extends StatelessWidget {
//   const CustomEditImage({
//     super.key,
//     required this.img,
//     this.onEdit,
//     this.localFile,
//   });

//   final String img; // initial network image
//   final VoidCallback? onEdit;
//   final File? localFile; // picked local file

//   @override
//   Widget build(BuildContext context) {
//     final imageWidget = localFile != null
//         ? Image.file(
//             localFile!,
//             width: double.infinity,
//             height: context.hPct(30),
//             fit: BoxFit.cover,
//           )
//         : Image.network(
//             img,
//             width: double.infinity,
//             height: context.hPct(30),
//             fit: BoxFit.cover,
//             loadingBuilder: (context, child, loadingProgress) {
//               if (loadingProgress == null) return child;
//               return Container(
//                 color: AppColors.lightGray,
//                 alignment: Alignment.center,
//                 child: const CircularProgressIndicator(strokeWidth: 2),
//               );
//             },
//             errorBuilder: (context, error, stackTrace) {
//               return Container(
//                 width: double.infinity,
//                 height: context.hPct(30),
//                 color: Colors.grey.shade300,
//                 alignment: Alignment.center,
//                 child: const Icon(
//                   Icons.broken_image_outlined,
//                   size: 50,
//                   color: AppColors.lightGrey,
//                 ),
//               );
//             },
//           );

//     return ClipRRect(
//       borderRadius: BorderRadius.circular(context.wPct(4)),
//       child: Stack(
//         children: [
//           imageWidget,
//           GestureDetector(
//             onTap: onEdit,
//             child: Container(
//               width: double.infinity,
//               height: context.hPct(30),
//               color: Colors.black.withOpacity(0.6),
//               alignment: Alignment.center,
//               child: CircleAvatar(
//                 backgroundColor: const Color(0x80FFFFFF),
//                 radius: context.wPct(7),
//                 child: const Icon(Icons.edit),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
