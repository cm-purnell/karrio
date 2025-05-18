FROM python:3.11-slim

WORKDIR /app

# Install Poetry
RUN pip install poetry

# Copy dependency files and install
COPY pyproject.toml poetry.lock ./
RUN poetry config virtualenvs.create false && poetry install --no-root

# Copy the full application code
COPY . .

# Set environment and expose port
ENV PORT=8000
EXPOSE 8000

# Run the Karrio API (likely ASGI path based on structure)
CMD ["uvicorn", "karrio.server.asgi:application", "--host", "0.0.0.0", "--port", "8000"]
