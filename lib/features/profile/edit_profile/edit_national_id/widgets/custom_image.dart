import 'package:flutter/material.dart';
import 'package:para_job/packages/themeing/app_colors.dart';
import 'package:para_job/packages/themeing/media_query_values.dart';

class CustomEditImage extends StatelessWidget {
  const CustomEditImage({super.key, required this.img});
  final String img;

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
          
      
          Container(
            width: double.infinity,
            height: context.hPct(30),
            color: const Color.fromARGB(217, 0, 0, 0).withOpacity(0.6), 
            alignment: Alignment.center,
            child:  Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircleAvatar(backgroundColor: const Color(0x80FFFFFF),radius: context.wPct(7),
                  child:Icon(Icons.edit)),
                  context.wBox(5),
                   CircleAvatar(backgroundColor: const Color(0x80FFFFFF),radius: context.wPct(7),
                  child:Icon(Icons.file_upload_outlined)),
              ],
            ),
          ),
          ),
      
         
        ],
      ),
    );
  }
}
