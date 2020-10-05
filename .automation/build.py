# !/usr/bin/env python3
"""
Automatically generate source code
"""
import logging
import os
import re
import sys

import superlinter

DOCS_URL_ROOT = "https://github.com/nvuillam/super-linter/tree/POC_RefactorInPython/docs"
DOCS_URL_DESCRIPTORS_ROOT = DOCS_URL_ROOT + "/descriptors"
REPO_HOME = os.path.dirname(os.path.abspath(__file__)) + os.path.sep + '..'


# Automatically generate a test class for each linter class
# This could be done dynamically at runtime, but having a physical class is easier for developers in IDEs
def generate_linter_test_classes():
    descriptor_files = superlinter.utils.list_descriptor_files()
    for descriptor_file in descriptor_files:
        descriptor_linters = superlinter.utils.build_descriptor_linters(descriptor_file)
        for linter in descriptor_linters:
            lang_lower = linter.language.lower()
            linter_name_lower = linter.linter_name.lower().replace('-', '_')
            test_class_code = f"""# !/usr/bin/env python3
\"\"\"
Unit tests for {linter.language} linter {linter.linter_name}
This class has been automatically generated by .automation/build.py, please do not update it manually
\"\"\"
from superlinter.tests.test_superlinter.LinterTestRoot import LinterTestRoot


class {lang_lower}_{linter_name_lower}_test(LinterTestRoot):
    language = '{linter.language}'
    linter_name = '{linter.linter_name}'
"""
            file = open(
                f"{REPO_HOME}/superlinter/tests/test_superlinter/linters/{lang_lower}_{linter_name_lower}_test.py",
                'w')
            file.write(test_class_code)
            file.close()
            logging.info('Updated ' + file.name)


# Automatically generate README linters table and a MD file for each linter
def generate_linter_documentation():
    descriptor_files = superlinter.utils.list_descriptor_files()
    linters_by_type = {'language': [], 'format': [], 'tooling_format': []}
    for descriptor_file in descriptor_files:
        descriptor_linters = superlinter.utils.build_descriptor_linters(descriptor_file)
        linters_by_type[descriptor_linters[0].type].extend(descriptor_linters)
    linters_tables_md = []
    process_type(linters_by_type, 'language', 'Languages', linters_tables_md)
    process_type(linters_by_type, 'format', 'Formats', linters_tables_md)
    process_type(linters_by_type, 'tooling_format', 'Tooling formats', linters_tables_md)
    linters_tables_md_str = "\n".join(linters_tables_md) + "\n"
    logging.info("Generated Linters table for README:\n" + linters_tables_md_str)

    # Read in the file
    with open(f"{REPO_HOME}/README.md", 'r') as readme_file:
        readme = readme_file.read()
    # Replace the target string
    readme_replacement = f"<!-- linters-table-start -->\n{linters_tables_md_str}<!-- linters-table-end -->"
    readme = re.sub(r"<!-- linters-table-start -->([\s\S]*?)<!-- linters-table-end -->", readme_replacement, readme,
                    re.DOTALL)
    # Write the file out again
    with open(f"{REPO_HOME}/README.md", 'w') as readme_file:
        readme_file.write(readme)
    logging.info('Updated ' + readme_file.name)


# Build a MD table for a type of linter (language, format, tooling_format )SSS
def process_type(linters_by_type, type1, type_label, linters_tables_md):
    linters_tables_md.extend([
        f"### {type_label}",
        "",
        "| Language / Format | Linter | Configuration key |",
        "| ----------------- | -------------- | ------------ |"])
    descriptor_linters = linters_by_type[type1]
    prev_lang = ''
    for linter in descriptor_linters:
        lang_lower = linter.language.lower()
        linter_name_lower = linter.linter_name.lower().replace('-', '_')
        # Append in general linter tables
        language_cell = f"**{linter.language}**" if prev_lang != linter.language else ''
        prev_lang = linter.language
        linter_doc_url = f"{DOCS_URL_DESCRIPTORS_ROOT}/{lang_lower}_{linter_name_lower}.md"
        linters_tables_md.append(
            f"| {language_cell} | [{linter.linter_name}]({linter_doc_url})"
            f"| [{linter.name}]({linter_doc_url}) |")
        # Build individual linter doc
        linter_doc_md = [
            "<!-- markdownlint-disable MD033 MD041 -->",
            "<!-- Generated by .automation/build.py, please do not update manually -->"
        ]
        # Header image as title
        if hasattr(linter, 'linter_header_image_url') and linter.linter_header_image_url is not None:
            linter_doc_md.extend([
                image_link(linter.linter_header_image_url, linter.linter_name,
                           linter.linter_url, "Visit linter Web Site", "center", 150)
            ])
        # Text + image as title
        elif hasattr(linter, 'linter_image_url') and linter.linter_image_url is not None:
            linter_doc_md.append(
                "# " + logo_link(linter.linter_image_url, linter.linter_name,
                                 linter.linter_url, "Visit linter Web Site", 100) + linter.linter_name
            )
        # Text as title
        else:
            linter_doc_md.append(f"# {linter.linter_name}")

        linter_doc_md.extend([
            "## Linted files",
            ""])
        if len(linter.file_extensions) > 0:
            linter_doc_md.append('- File extensions:')
        for file_extension in linter.file_extensions:
            linter_doc_md.append(f"  - `{file_extension}`")
        if len(linter.file_names) > 0:
            linter_doc_md.append('- File names:')
        for file_name in linter.file_names:
            linter_doc_md.append(f"  - `{file_name}`")
        if len(linter.file_contains) > 0:
            linter_doc_md.append('- Detected file content:')
        for file_contains_expr in linter.file_contains:
            linter_doc_md.append(f"  - `{file_contains_expr}`")

        linter_doc_md.extend([
            "## Configuration",
            "",
            "| Variable | Description | Default value |",
            "| ----------------- | -------------- | -------------- |",
            f"| VALIDATE_{linter.name} | Activate or deactivate {linter.linter_name} | `true` |",
            f"| {linter.name}_FILTER_REGEX_INCLUDE | Custom regex including filter |  |",
            f"| {linter.name}_FILTER_REGEX_EXCLUDE | Custom regex excluding filter |  |"
        ])
        if linter.config_file_name is not None:
            linter_doc_md.extend([
                f"| {linter.name}_FILE_NAME | Rules file name | `{linter.config_file_name}` |",
                f"| {linter.name}_RULES_PATH | Path where to find rules | "
                "Workspace folder, then super-linter default rules |"
            ])
        if linter.files_sub_directory is not None:
            linter_doc_md.append(
                f"| {linter.language}_DIRECTORY | Directory containing {linter.language} files "
                f"| `{linter.files_sub_directory}` |"
            )
        linter_doc_md.extend([
            "",
            "## Behind the scenes",
            "",
            "### Example calls",
            ""
        ])
        for example in linter.examples:
            linter_doc_md.extend([
                "```shell",
                example,
                "```",
                ""])

        linter_doc_md.extend([
            "### Linter web site",
            f"- [{linter.linter_url}]({linter.linter_url})",
            ""])

        file = open(f"{REPO_HOME}/docs/descriptors/{lang_lower}_{linter_name_lower}.md", 'w')
        file.write("\n".join(linter_doc_md) + "\n")
        file.close()
        logging.info('Updated ' + file.name)
    linters_tables_md.append("")
    return linters_tables_md


def image_link(src, alt, link, title, align, maxheight):
    return f"""
<div align=\"{align}\">
  <a href=\"{link}\" target=\"blank\" title=\"{title}\">
    <img src=\"{src}\" alt=\"{alt}\" height=\"{maxheight}px\">
  </a>
</div>
"""


def logo_link(src, alt, link, title, maxheight):
    return f"<a href=\"{link}\" target=\"blank\" title=\"{title}\">" \
           f"<img src=\"{src}\" alt=\"{alt}\" height=\"{maxheight}px\"></a>"


if __name__ == '__main__':
    logging.basicConfig(force=True,
                        level=logging.INFO,
                        format='%(asctime)s [%(levelname)s] %(message)s',
                        handlers=[
                            logging.StreamHandler(sys.stdout)
                        ])
    # noinspection PyTypeChecker
    generate_linter_test_classes()
    generate_linter_documentation()
