start:
	docker-compose up

shell:
	docker-compose run --rm app python manage.py shell

bash:
	docker-compose run --rm app bash

test:
	docker-compose -f docker-compose-standalone.yml run --rm app \
		wait-for-it.sh db:3306 -- python manage.py test -n

unittest:
	docker-compose run --rm app pytest

collect-coverage:
	docker-compose -f docker-compose-standalone.yml run --rm app \
		wait-for-it.sh db:3306 -- \
			coverage run --source='.' \
			--omit="conftest.py,*/admin.py,*/tests/*,*/tests.py,manage.py,*wsgi.py*,*/apps.py" \
			manage.py test -n

coverage-check: collect-coverage
	# Check the coverage and return stauts code 2 if it's under 90%
	docker-compose -f docker-compose-standalone.yml run --rm app \
		wait-for-it.sh db:3306 -- coverage report --skip-covered --fail-under=90

coverage-shell: collect-coverage
	docker-compose -f docker-compose-standalone.yml run --rm app \
		wait-for-it.sh db:3306 -- coverage report --skip-covered

coverage-html: collect-coverage
	docker-compose -f docker-compose-standalone.yml run --rm app \
		wait-for-it.sh db:3306 -- coverage html --skip-covered
	xdg-open app/src/htmlcov/index.html || open app/src/htmlcov/index.html
