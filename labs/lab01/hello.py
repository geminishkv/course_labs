import base64
import typer

def main(
    name: str = typer.Argument(...),
    lastname: str = typer.Option("", "--lastname", "-l"),
) -> None:
    greeting = base64.b64decode(b"SGVsbG8gYXBwc2Vjd29ybGQ=").decode()
    tail = f"@{name}" + (f" {lastname}" if lastname else "")
    typer.echo(f"{greeting} from {tail}")

if __name__ == "__main__":
    typer.run(main)
# test comment
