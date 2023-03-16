import 'package:flutter/material.dart';
import 'package:instagram_clone/src/components/avatar_widget.dart';
import 'package:instagram_clone/src/function/random_image.dart';

class UserCard extends StatelessWidget {

  final String UserId;
  final String description;
  const UserCard({
    Key? key,
    required this.UserId,
    required this.description
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 3),
      width: 150,
      height: 220,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        border: Border.all(color: Colors.black12),
      ),
      child: Stack(
        children: [
          Positioned(
            left: 15,
            bottom: 0,
            top: 0,
            right: 15,
            child: Column(
              children: [
                const SizedBox(height: 10,),
                AvatarWidget(
                  thumbPath: randomUserImage('men'),
                  type: AvatarType.TYPE2,
                  size: 80,
                ),
                const SizedBox(height: 10,),
                Text(
                  UserId,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 13
                  ),
                ),
                Text(
                  description,
                  style: const TextStyle(
                    fontSize: 13,
                  ),
                  textAlign: TextAlign.center,
                ),
                ElevatedButton(
                  onPressed: (){

                  },
                  child: const Text(
                    '팔로우'
                  ),
                )
              ],
            ),
          ),
          Positioned(
              right: 5,
              top: 5,
              child: GestureDetector(
                onTap: () {},
                child: const Icon(
                  Icons.close,
                  size: 17,
                  color: Colors.grey,
                ),
              )),
        ],
      ),
    );
  }
}
