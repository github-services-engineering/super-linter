# !/usr/bin/env python3
"""
Unit tests for BASH linter shellcheck
This class has been automatically generated by .automation/build.py, please do not update it manually
"""

from unittest import TestCase

from superlinter.tests.test_superlinter.LinterTestRoot import LinterTestRoot


class bash_shellcheck_test(TestCase, LinterTestRoot):
    descriptor_id = 'BASH'
    linter_name = 'shellcheck'
