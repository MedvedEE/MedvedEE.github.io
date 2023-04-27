# Variables
ASCIIDOCTOR = asciidoctor
SRC_DIR = src
HTML_DIR = html
SPECIAL_HTML_DIR = special_html #Index file, otherwise website wont work

# Find all AsciiDoc source files in the source directory
SRC_FILES := $(wildcard $(SRC_DIR)/*.asciidoc)

# Generate HTML output
HTML_OUTPUT_FILES := $(patsubst $(SRC_DIR)/%.asciidoc,$(HTML_DIR)/%.html,$(filter-out $(SRC_DIR)/index.asciidoc,$(SRC_FILES)))
SPECIAL_HTML_OUTPUT_FILES := $(patsubst $(SRC_DIR)/%.asciidoc,%.html,$(filter $(SRC_DIR)/index.asciidoc,$(SRC_FILES)))

$(HTML_DIR)/%.html: $(SRC_DIR)/%.asciidoc
	$(ASCIIDOCTOR) -o $@ $<

%.html: $(SRC_DIR)/%.asciidoc
	$(ASCIIDOCTOR) -o $@ $<

# Targets
all: html special_html

html: $(HTML_OUTPUT_FILES)

special_html: $(SPECIAL_HTML_OUTPUT_FILES)

clean:
	rm -rf $(HTML_DIR) $(SPECIAL_HTML_OUTPUT_FILES)
