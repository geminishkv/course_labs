from flask import Flask, Response

app = Flask(__name__)


def colorful_text(text):
    colors = ["red", "green", "yellow", "blue", "purple"]
    spans = []
    for i, char in enumerate(text):
        color = colors[i % len(colors)]
        spans.append(f'<span style="color:{color}">{char}</span>')
    return "".join(spans)


@app.route("/")
def index():
    colored_message = colorful_text("hello appsec world")
    html = f"""
    <html>
    <head><title>Colorful Output</title></head>
    <body style="font-family: monospace; font-size: 24px;">
    {colored_message}
    </body>
    </html>
    """
    return Response(html, mimetype="text/html")


if __name__ == "__main__":
    app.run(host="0.0.0.0", port=8000)  # nosec B104
