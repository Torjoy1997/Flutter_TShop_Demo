part of 'brand_headline_section.dart';

class BrandHeadlineWithIcon extends StatelessWidget {
  const BrandHeadlineWithIcon({
    super.key,
    required this.title,
    this.icon = Iconsax.verify5,
  });

  final String title;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.bodyLarge,
          overflow: TextOverflow.ellipsis,
        ),
        const SizedBox(
          width: 8,
        ),
        Icon(
          icon,
          color: AppDefineColors.primary,
          size: AppDefineSizes.iconSm,
        )
      ],
    );
  }
}
