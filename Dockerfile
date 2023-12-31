FROM python
ENV PYTHONUNBUFFERED=1
RUN curl -sSL https://install.python-poetry.org | python3 -
RUN echo "export PATH="/root/.local/bin:$PATH""
RUN echo "export PATH="/root/.local/bin:$PATH"" >> /etc/bash.bashrc
ENV PATH="$PATH:/root/.local/bin:$PATH"
WORKDIR /usr/app
COPY . .
RUN chmod 777 ./forestreeApp/manage.py
ENV SECRET_DJANGO = ASecretForDjango
ENV DJANGO_SUPERUSER_USERNAME = zodix
ENV DJANGO_SUPERUSER_PASSWORD = copito21
ENV DJANGO_SUPERUSER_EMAIL = gonz445@hotmail.com
RUN poetry install 
RUN poetry run ./django-admin help
RUN poetry run ./forestreeApp/django-admin createsuperuser --no-input
RUN poetry run ./forestreeApp/manage.py makemigrations
RUN poetry run ./forestreeApp/manage.py migrate
EXPOSE 8000
CMD ["poetry","run", "./forestreeApp/manage.py", "runserver", "0.0.0.0:8000"]