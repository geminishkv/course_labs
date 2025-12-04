#!/usr/bin/env python3
"""
Hello AppSec World application
Demonstrates Python code with improved style
"""

def greet_user(username: str) -> None:
    """Print greeting message with username"""
    greeting_message = f"Hello AppSec World from {username}!"
    print(greeting_message)


if __name__ == "__main__":
    print("Hello AppSec World!")
    user_name = input("Enter name: ")
    greet_user(user_name)

