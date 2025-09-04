"""
Comprehensive Test Configuration and Fixtures
Merged configuration with reporting capabilities and test utilities
"""

import pytest
import json
import tempfile
import os
import shutil

@pytest.fixture(scope="session")
def config():
    """Provides a merged configuration for the test suite."""
    config = {
        "database": {
            "host": "localhost",
            "port": 5432,
            "user": "test_user",
            "password": "test_password"
        },
        "logging": {
            "level": "DEBUG",
            "file": "/tmp/test.log"
        },
        "reporting": {
            "enabled": True,
            "output_file": "/tmp/report.json"
        }
    }
    return config