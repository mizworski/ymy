default: build

install-deps:
	cabal update; \
	cabal install mtl

build:
	mkdir -p bnfc; \
	bnfc src/YmyLang.cf -o bnfc; \
	happy bnfc/ParYmyLang.y; \
	alex bnfc/LexYmyLang.x; \
	rm -f bnfc/*.x; \
	rm -f bnfc/*.y; \
	rm -f bnfc/TestYmyLang.hs; \
	mkdir -p tmp; \
	cp app/* tmp; \
	cp src/* tmp; \
	cp bnfc/* tmp; \
	cd tmp; \
	ghc -o ../interpreter Main.hs; \
	cd ..; \

clean:
	rm -rf bnfc
