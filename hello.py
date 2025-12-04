#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Hello AppSec World - приветственное приложение
Демонстрация работы с Python для лабораторной работы
"""

import sys
import os
from datetime import datetime

def hello_world():
    """Простое приветствие"""
    print("Hello AppSec World!")
    return "Hello AppSec World!"

def hello_user(name):
    """Приветствие с именем пользователя"""
    message = f"Hello AppSec World from {name}!"
    print(message)
    return message

def get_user_info():
    """Получение информации о пользователе"""
    username = os.getenv('USER', 'Unknown')
    hostname = os.getenv('HOSTNAME', 'Unknown')
    return username, hostname

def show_system_info():
    """Показать информацию о системе"""
    print(f"Python version: {sys.version}")
    print(f"Platform: {sys.platform}")
    print(f"Current time: {datetime.now().strftime('%Y-%m-%d %H:%M:%S')}")

def interactive_greeting():
    """Интерактивное приветствие с запросом имени"""
    name = input("Введите ваше имя: ")
    if name:
        hello_user(name)
        username, hostname = get_user_info()
        print(f"Вы работаете как: {username}@{hostname}")
    else:
        hello_world()

def main():
    """Главная функция"""
    if len(sys.argv) > 1:
        # Если передан аргумент - используем его как имя
        hello_user(sys.argv[1])
    else:
        # Иначе интерактивный режим
        interactive_greeting()
    
    show_system_info()

if __name__ == "__main__":
    main()

