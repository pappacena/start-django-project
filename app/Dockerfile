FROM python:3.6

# wait-for-it script
ADD ./wait-for-it.sh /usr/bin/wait-for-it.sh
RUN chmod +x /usr/bin/wait-for-it.sh

# Log dir
RUN mkdir -p /var/log/src/

# Add application
ADD . /usr/src/app/
WORKDIR /usr/src/app

# Install dependencies
RUN pip install -r dev-requirements.txt

WORKDIR /usr/src/app/src

CMD ["python", "manage.py", "runserver"]
