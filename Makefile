# Variables
ASCIIDOCTOR = asciidoctor
SRC_DIR = src
HTML_DIR = html
SPECIAL_HTML_DIR = special_html # Index file, otherwise website wont work
VLE_DIR = VLE_Bootstrap

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
all: html special_html VLE git

#html directory
html: $(HTML_OUTPUT_FILES)

#Index file, that can't be in a folder imo
special_html: $(SPECIAL_HTML_OUTPUT_FILES)

#Clean HTML files
clean:
	rm -rf $(HTML_DIR) $(SPECIAL_HTML_OUTPUT_FILES)

#Git everything
git: 
	git add .
	git commit -m "Doing asciidoc"
	git push -u origin main

VLE:
	(cd $(VLE_DIR) && git add . && git commit -m "Updating VLE " && git push -u origin main)