#!/usr/bin/make -f

.PHONY: all clean clean-all check test analyse insights coverage

# ---------------------------------------------------------------------

all: test analyse insights

clean:
	rm -rf ./build

clean-all: clean
	rm -rf ./vendor
	rm -rf ./composer.lock

check:
	php vendor/bin/phpcs

test: clean check
	phpdbg -qrr vendor/bin/phpunit

analyse:
	php vendor/bin/phpstan analyse src tests --level=max

insights:
	php vendor/bin/phpinsights analyse -v --ansi --min-quality=80 --min-complexity=80 --min-architecture=80 --min-style=80

coverage: test
	@if [ "`uname`" = "Darwin" ]; then open build/coverage/index.html; fi
