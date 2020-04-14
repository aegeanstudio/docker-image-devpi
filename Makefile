WITH_ENV = env `cat .env 2>/dev/null | xargs`

compile-deps:
	@[ -n "$(VIRTUAL_ENV)" ] || (echo 'out of virtualenv'; exit 1)
	@$(WITH_ENV) pip3 install -U pip setuptools wheel
	@$(WITH_ENV) pip3 install -U pip-tools
	@$(WITH_ENV) pip-compile -U requirements.in

rm-dev:
	@docker rmi aegeanstudio/devpi:dev

build-dev:
	@docker build -t aegeanstudio/devpi:dev .
