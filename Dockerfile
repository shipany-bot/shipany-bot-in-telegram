FROM cgr.dev/chainguard/python:latest-dev as builder

ENV LANG=C.UTF-8
ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1
ENV PATH="/shipanybot/venv/bin:$PATH"

WORKDIR /shipanybot

RUN python -m venv /shipanybot/venv
COPY requirements.txt .

RUN pip install --no-cache-dir -r requirements.txt

FROM cgr.dev/chainguard/python:latest

WORKDIR /shipanybot

ENV PYTHONUNBUFFERED=1
ENV PATH="/venv/bin:$PATH"

COPY --from=builder /shipanybot/venv /venv
COPY conversation.json conversation.json

ENTRYPOINT [ "python" ]
CMD [ "-m", "shipany.bot.cli.main", "run", "conversation.json"]
