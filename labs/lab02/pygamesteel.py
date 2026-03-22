import sys

import pygame

# Подключаем файл из первой лабораторной
sys.path.insert(0, "/root/course_labs/labs/lab01")
import typer

pygame.init()

# Используем typer для получения имени пользователя из первой лабораторной
app = typer.Typer()


@app.command()
def main(
    name: str = typer.Argument("User", help="Имя пользователя"),
    lastname: str = typer.Option("", help="Фамилия пользователя."),
    formal: bool = typer.Option(
        False, "--formal", "-f", help="Использовать формальное приветствие."
    ),
):
    """Приветствие с использованием pygame и typer из первой лабораторной"""
    # Используем логику из первой лабораторной для формирования приветствия
    if formal:  # noqa: SIM108
        greeting = f"Добрый день, {name} {lastname}!"
    else:
        greeting = f"Привет, {name}!"

    run_pygame_app(greeting)


def run_pygame_app(greeting_text: str):
    # Устанавливаем размеры окна
    screen_width = 800
    screen_height = 600
    window_size = (screen_width, screen_height)
    screen = pygame.display.set_mode(
        window_size
    )  # Создаем окно и присваиваем переменной

    # Задаем цвет фона
    bg_color = (255, 255, 255)
    screen.fill(bg_color)  # Заливаем фон белым цветом

    # Выводим текст на экран
    font = pygame.font.SysFont(None, 75)
    text_content = "Hello appsec world*"
    text = font.render(text_content, True, (0, 255, 0))
    text_rect = text.get_rect()
    text_rect.center = (400, 250)
    screen.blit(text, text_rect)

    # Выводим приветствие из первой лабораторной
    greeting_font = pygame.font.SysFont(None, 50)
    greeting = greeting_font.render(greeting_text, True, (0, 0, 255))
    greeting_rect = greeting.get_rect()
    greeting_rect.center = (400, 350)
    screen.blit(greeting, greeting_rect)

    # Основной цикл
    running = True
    while running:
        for event in pygame.event.get():
            if event.type == pygame.QUIT:
                running = False
        pygame.display.flip()  # Обновляем экран внутри цикла

    pygame.quit()
    sys.exit()


if __name__ == "__main__":
    app()
