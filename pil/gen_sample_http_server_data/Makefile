.PHONY: clean all run
file_names := a.txt b.txt c.txt
all:
	@for f in $(file_names); do \
	    bash gen.sh $$f 1000000; \
	done
clean:
	@rm -f $(file_names)
run:
	@python3 -m http.server --directory . 9999