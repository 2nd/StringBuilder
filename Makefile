t:
	@mkdir -p bin
	@nim c --out:./bin/tests --nimcache:./bin/nimcache stringbuilder_test.nim
	@./bin/tests
