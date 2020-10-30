import setuptools

from parsetf.__version__ import __version__


with open("README.md", "r") as f:
    long_description = f.read()

setuptools.setup(
    name="parsetf",
    version=__version__,
    author="web",
    author_email="willweb@126.com",
    description="Parse terraform template",
    long_description=long_description,
    long_description_content_type="text/markdown",
    packages=setuptools.find_packages(),
    package_data={
        "parsetf": [
            "*.py",
            "*.so",
        ]
    },
    classifiers=[
        "Intended Audience :: Developers",
        "License :: OSI Approved :: Apache Software License",
        "Programming Language :: Python",
        "Programming Language :: Python :: 3.6",
        "Programming Language :: Python :: 3.7",
        "Programming Language :: Python :: 3.8",
        "Topic :: Software Development",
        "Operating System :: MacOS :: MacOS X",
        "Operating System :: POSIX",
        "Operating System :: POSIX :: BSD",
        "Operating System :: POSIX :: Linux",
        "Operating System :: Microsoft :: Windows",
    ],
    install_requires=[],
    python_requires='>=3.6',
)

