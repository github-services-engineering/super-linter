# !/usr/bin/env python3
"""
Unit tests for CLOUDFORMATION linter cfn-lint
This class has been automatically generated by .automation/build.py, please do not update it manually
"""

from unittest import TestCase

from superlinter.tests.test_superlinter.LinterTestRoot import LinterTestRoot


class cloudformation_cfn_lint_test(TestCase, LinterTestRoot):
    descriptor_id = 'CLOUDFORMATION'
    linter_name = 'cfn-lint'
