import 'package:flutter/material.dart';

class RoleModel {
  final String title;
  final String description;
  final IconData icon;
  final Color color;

  RoleModel({
    required this.title,
    required this.description,
    required this.icon,
    required this.color,
  });
}

/// Centralized role data (clean + reusable)
List<RoleModel> getRoles(ColorScheme colors) {
  return [
    RoleModel(
      title: "Warehouse Manager",
      description: "Control inventory, stock & logistics",
      icon: Icons.warehouse,
      color: colors.primary,
    ),
    RoleModel(
      title: "Business / SuperMarket Owner",
      description: "Track performance & analytics",
      icon: Icons.business,
      color: colors.secondary,
    ),
    RoleModel(
      title: "Worker",
      description: "Handle daily warehouse tasks",
      icon: Icons.engineering,
      color: colors.tertiary,
    ),
    RoleModel(
      title: "Owner / Renter",
      description: "Manage properties & listings",
      icon: Icons.home_work,
      color: colors.primary,
    ),
  ];
}