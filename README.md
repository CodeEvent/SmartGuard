# SmartGuard

### Static Analysis for DeFi Fraud Detection

Extending Slither with custom detectors to identify business-logic
vulnerabilities commonly associated with fraudulent smart contracts.

BEng (Hons) Cyber Security Dissertation\
University of the West of Scotland\
2026

------------------------------------------------------------------------

## Overview

SmartGuard is a static analysis extension for the Slither framework
designed to detect business-logic vulnerabilities in smart contracts
that enable financial exploitation in decentralised finance (DeFi)
ecosystems.

The system introduces three custom detection mechanisms:

-   Unlimited token minting
-   Token impersonation
-   Unprotected administrative functions

------------------------------------------------------------------------

## Key Features

-   Static analysis of Solidity smart contracts
-   Detection of business-logic vulnerabilities
-   Integration with the Slither framework
-   Reproducible evaluation workflow
-   False positive validation against legitimate contracts

------------------------------------------------------------------------

## Detectors

  ---------------------------------------------------------------------------------------------------
  Detector                      Identifier                      Severity         Description
  ----------------------------- ------------------------------- ---------------- --------------------
  UnlimitedMint                 unlimited-mint                  HIGH             Detects mint
                                                                                 functions without
                                                                                 supply limits or
                                                                                 authorization
                                                                                 controls

  FakeTokenName                 fake-token-name                 MEDIUM           Detects contracts
                                                                                 impersonating
                                                                                 well-known
                                                                                 cryptocurrency
                                                                                 tokens

  UnprotectedCriticalFunction   unprotected-critical-function   HIGH             Detects
                                                                                 administrative
                                                                                 functions callable
                                                                                 without access
                                                                                 control
  ---------------------------------------------------------------------------------------------------

------------------------------------------------------------------------

## Installation

Clone the repository:

git clone https://github.com/CodeEvent/SmartGuard.git\
cd SmartGuard

Create a virtual environment:

py -m venv venv\
.`\venv`{=tex}`\Scripts`{=tex}`\Activate`{=tex}.ps1

Install dependencies:

pip install slither-analyzer solc-select -e .

Install Solidity compiler:

solc-select install 0.8.0\
solc-select use 0.8.0

------------------------------------------------------------------------

## Usage

Run SmartGuard detection:

slither contracts/scam/test_mint.sol --detect
unlimited-mint,fake-token-name,unprotected-critical-function

------------------------------------------------------------------------

## Repository Structure

SmartGuard/

contracts/\
detectors/\
results/\
demo.ps1\
setup.py\
README.md

------------------------------------------------------------------------

## Author

Ermand Mani\
BEng (Hons) Cyber Security\
University of the West of Scotland

------------------------------------------------------------------------

## License

This project is provided for academic and research purposes.
