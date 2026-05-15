import 'package:flutter/material.dart';

enum AccountType { client, warehouseOwner }

class RoleModel {
  final String title;
  final String description;
  final IconData icon;
  final Color color;
  final AccountType type;

  const RoleModel({
    required this.title,
    required this.description,
    required this.icon,
    required this.color,
    required this.type,
  });
}

/// Centralized role data
List<RoleModel> getRoles(ColorScheme colors) {
  return [
    RoleModel(
      title: "Client",
      description: "Order products from warehouses",
      icon: Icons.shopping_bag_outlined,
      color: colors.primary,
      type: AccountType.client,
    ),

    RoleModel(
      title: "Warehouse Owner",
      description:
          "Manage warehouses, storage, and incoming orders ",
      icon: Icons.warehouse_outlined,
      color: colors.tertiary,
      type: AccountType.warehouseOwner,
    ),
  ];
}
