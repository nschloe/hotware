VERSION=$(shell python3 -c "from configparser import ConfigParser; p = ConfigParser(); p.read('setup.cfg'); print(p['metadata']['version'])")

default:
	@echo "\"make publish\"?"

tag:
	# Make sure we're on the main branch
	@if [ "$(shell git rev-parse --abbrev-ref HEAD)" != "main" ]; then exit 1; fi
	# @echo "Tagging v$(VERSION)..."
	# git tag v$(VERSION)
	# git push --tags
	curl -H "Authorization: token `cat $(HOME)/.github-access-token`" -d '{"tag_name": "v$(VERSION)"}' https://api.github.com/repos/nschloe/stacktags/releases

upload:
	@if [ "$(shell git rev-parse --abbrev-ref HEAD)" != "main" ]; then exit 1; fi
	rm -f dist/*
	# python3 setup.py sdist bdist_wheel
	# https://stackoverflow.com/a/58756491/353337
	python3 -m pep517.build --source --binary .
	twine upload dist/*

publish: upload tag

nschloe:
	stacktags-gh-star-history nschloe/tikzplotlib nschloe/meshio nschloe/perfplot nschloe/quadpy nschloe/pygmsh nschloe/betterbib nschloe/tuna nschloe/awesome-scientific-computing -m 14 -t `cat ~/.github-access-token` -o nschloe.svg

clean:
	@find . | grep -E "(__pycache__|\.pyc|\.pyo$\)" | xargs rm -rf
	@rm -rf *.egg-info/ build/ dist/ MANIFEST .pytest_cache/

format:
	isort -rc .
	black .

black:
	black .

lint:
	black --check .
	flake8 .
