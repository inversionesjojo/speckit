FROM python:3.15.0b2-trixie

ARG SPECIFY_VERSION=v0.9.5

# RUN apt-get update && apt-get upgrade -y
# RUN apt-install build-essential git curl -y
RUN pip install uv
# RUN curl -LsSf https://astral.sh/uv/install.sh | sh
RUN uv tool install specify-cli --from git+https://github.com/github/spec-kit.git@${SPECIFY_VERSION}
ENV PATH="/root/.local/bin:${PATH}"
# RUN specify init my-project --integration copilot
