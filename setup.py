from setuptools import setup, find_packages

setup(
    name="smartguard",
    version="0.1",
    packages=find_packages(),
    entry_points={
        "slither_analyzer.plugin": [
            "smartguard = detectors:make_plugin"
        ],
    },
)