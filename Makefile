AUDIT_RULES = $(shell find ./src/audits -name "*.js")
#AUDIT_RULES = $(shell find ./src/audits -name "ControlsWithoutLabel.js")
JS_FILES = $(shell find ./src/js -name "*.js")

BIG_FAT_JS_FILE = ./extension/generated_accessibility.js
TEST_DEPENDENCIES_FILE = ./test/generated_dependencies.js

.PHONY: clean js

js: clean
	@echo "\nStand back! I'm rebuilding!\n---------------------------"
	@/bin/echo -n "* Rebuilding '$(BIG_FAT_JS_FILE)': "
	@cat $(JS_FILES) > $(BIG_FAT_JS_FILE) && \
	  cat $(AUDIT_RULES) >> $(BIG_FAT_JS_FILE) && \
    echo "SUCCESS"
	@/bin/echo -n "* Rebuilding test dependencies: "
	@echo "var _dependencies = [" > $(TEST_DEPENDENCIES_FILE) && \
	for f in $(JS_FILES); do \
	  echo "  '.$$f'," >> $(TEST_DEPENDENCIES_FILE); \
	done && \
	for f in $(AUDIT_RULES); do \
	  echo "  '.$$f'," >> $(TEST_DEPENDENCIES_FILE); \
	done && \
	echo "];" >> $(TEST_DEPENDENCIES_FILE) && \
  echo "SUCCESS"

	@echo;

clean:
	@rm -rf $(BIG_FAT_JS_FILE)

