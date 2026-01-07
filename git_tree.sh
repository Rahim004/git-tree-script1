#!/bin/bash
# Улучшенный скрипт для просмотра Git-дерева

# Проверка наличия git
if ! command -v git &> /dev/null; then
    echo "ОШИБКА: Git не установлен или не найден в PATH!"
    exit 1
fi

if [ $# -eq 0 ]; then
    echo "Укажите папку с проектом!"
    echo "Пример: ./git_tree.sh /home/user/myproject или ./git_tree.sh ./myproject"
    echo "Флаги:"
    echo "  --help    Показать эту справку"
    exit 1
fi

if [ "$1" = "--help" ]; then
    echo "Использование: ./git_tree.sh <путь_к_репозиторию>"
    exit 0
fi

PROJECT_DIR="$(realpath "$1" 2>/dev/null)"

if [ -z "$PROJECT_DIR" ]; then
    echo "ОШИБКА: Неверный путь '$1'"
    exit 1
fi

if [ ! -d "$PROJECT_DIR" ]; then
    echo "ОШИБКА: Папка '$PROJECT_DIR' не найдена!"
    exit 1
fi

if [ ! -d "$PROJECT_DIR/.git" ]; then
    echo "В этой папке нет Git-репозитория!"
    echo "Нужно сначала создать: git init"
    exit 1
fi

echo "✅ Найден Git-репозиторий в: $PROJECT_DIR"
echo ""

cd "$PROJECT_DIR" || exit 1

echo "🌳 ДЕРЕВО КОММИТОВ:"
echo "=================="
git log --oneline --graph --all --decorate --color=always | head -20

echo ""
echo "📌 ВЕТКИ:"
echo "========="
git branch -a

echo ""
echo "📍 ТЕКУЩАЯ ВЕТКА:"
git branch --show-current
