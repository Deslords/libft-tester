#!/usr/bin/env bash
set -euo pipefail

# Usage: ./run_tests.sh [path_to_libft_or_libft.a]
# If a directory is given, the script will look for libft.a inside it and try to run `make` if missing.

LIBFT_ARG=${1:-}
SCRIPT_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)
TEST_DIR="$SCRIPT_DIR/tests"

find_libft() {
  local arg="$1"
  if [ -z "$arg" ]; then
    if [ -f "./libft.a" ]; then
      echo "$(pwd)/libft.a"
      return 0
    fi
    return 1
  fi

  if [ -f "$arg" ]; then
    echo "$(realpath "$arg")"
    return 0
  fi

  if [ -d "$arg" ]; then
    if [ -f "$arg/libft.a" ]; then
      echo "$(realpath "$arg/libft.a")"
      return 0
    fi
    if [ -f "$arg/Makefile" ] || [ -f "$arg/makefile" ]; then
      echo "Building libft with make in $arg..."
      (cd "$arg" && make) >/dev/null
      if [ -f "$arg/libft.a" ]; then
        echo "$(realpath "$arg/libft.a")"
        return 0
      fi
    fi
  fi
  return 1
}

LIBFT_PATH=$(find_libft "$LIBFT_ARG" || true)
if [ -z "$LIBFT_PATH" ]; then
  echo "ERREUR: libft.a introuvable. Passez le chemin vers libft (dossier ou libft.a)." >&2
  exit 2
fi

TMPDIR=$(mktemp -d)
trap 'rm -rf "$TMPDIR"' EXIT

PASS=0
FAIL=0

for test in "$TEST_DIR"/*.c; do
  testname=$(basename "$test" .c)
  exe="$TMPDIR/$testname"
  echo "--- Compilation: $testname"
  gcc -Wall -Wextra -Werror -std=c11 "$test" "$LIBFT_PATH" -o "$exe" || {
    echo "Compilation échouée pour $testname" >&2
    FAIL=$((FAIL+1))
    continue
  }
  echo "Exécution: $testname"
  if "$exe"; then
    echo "RESULTAT: PASS\n"
    PASS=$((PASS+1))
  else
    echo "RESULTAT: FAIL\n"
    FAIL=$((FAIL+1))
  fi
done

echo "========== Résumé =========="
echo "Passés: $PASS"
echo "Échoués: $FAIL"
if [ "$FAIL" -eq 0 ]; then
  exit 0
else
  exit 1
fi
