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
	cat bnfc/AbsYmyLang.hs | tr '\n' '\f' | sed -e 's/[[:space:]]*|[[:space:]]Tfunarg[[:space:]]Type[[:space:]]Type\f[[:space:]]*deriving[[:space:]](Eq,[[:space:]]Ord,[[:space:]]Show,[[:space:]]Read)/\f    | Tfunarg Type Type\f  deriving (Ord, Show, Read)/g' | tr '\f' '\n' > bnfc/tmp.hs; \
	mv bnfc/tmp.hs bnfc/AbsYmyLang.hs; \
	cat src/TypesEqOverride.hs >> bnfc/AbsYmyLang.hs; \
	mkdir -p tmp; \
	cp app/* tmp; \
	cp src/* tmp; \
	cp bnfc/* tmp; \
	cd tmp; \
	ghc -o ../interpreter Main.hs; \
	cd ..; \

clean:
	rm -rf bnfc
