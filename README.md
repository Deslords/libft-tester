# libft-tester

Script simple pour compiler et lancer des tests C pour une libft.

Usage

1. Placer `libft.a` (ou le dossier du dépôt libft) à la racine du projet ou fournir son chemin :

   ./run_tests.sh /chemin/vers/libft

2. Le script va compiler chaque test dans `tests/` en le liant avec `libft.a` et afficher un résumé (PASS/FAIL).

Fichiers inclus

- run_tests.sh : script d'exécution des tests
- tests/ : exemples de tests pour ft_strlen et ft_strdup

Créé par @Deslords
