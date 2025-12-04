#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Hello AppSec World - приветственное приложение
Демонстрация работы с Python и typer для лабораторной работы
"""

import typer
from datetime import datetime
import sys

def main(
    name: str,
    lastname: str = typer.Option("", help="Фамилия пользователя."),
    formal: bool = typer.Option(
        False, "--formal", "-f", help="Использовать формальное приветствие."
    ),
):
    """
    Говорит "Привет" пользователю, опционально используя фамилию и формальный стиль.
    
    Args:
        name: Имя пользователя (обязательный параметр)
        lastname: Фамилия пользователя (опционально)
        formal: Флаг для формального приветствия (опционально)
    """
    # Проверяем, нужно ли использовать формальный стиль
    if formal:
        # Формальное приветствие с фамилией, если указана
        greeting = f"Добрый день, {name} {lastname}!" if lastname else f"Добрый день, {name}!"
        print(greeting)
    else:
        # Неформальное приветствие
        greeting = f"Привет, {name}!"
        print(greeting)
    
    # Дополнительная информация о системе
    print(f"\nТекущее время: {datetime.now().strftime('%Y-%m-%d %H:%M:%S')}")
    print(f"Версия Python: {sys.version.split()[0]}")

if __name__ == "__main__":
    typer.run(main)

