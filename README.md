<div align="center">

# 🔍 SmartGuard

### Static Analysis for DeFi Fraud Detection

Extending the Slither static analysis framework with custom detectors to identify business-logic vulnerabilities commonly associated with fraudulent smart contracts.

**BEng (Hons) Cyber Security Dissertation**  
University of the West of Scotland  
2026

![Python](https://img.shields.io/badge/Python-3.10-blue)
![Slither](https://img.shields.io/badge/Slither-0.11.5-purple)
![Solidity](https://img.shields.io/badge/Solidity-0.8.0-black)
![Status](https://img.shields.io/badge/Status-Research%20Project-success)

</div>

---

## 📖 Overview

SmartGuard is a static analysis extension for the **Slither** security framework designed to detect **business-logic vulnerabilities** in Solidity smart contracts used in decentralised finance (DeFi) systems.

Traditional static analysis tools primarily detect low-level technical vulnerabilities such as:

- Reentrancy
- Integer overflow
- Unchecked external calls

However, many real-world cryptocurrency fraud incidents are caused by insecure **business logic**, not programming errors.  
SmartGuard addresses this gap by identifying patterns commonly observed in fraudulent smart contracts.

---

## 🎯 Problem Statement

Existing static analysis tools do not effectively detect behavioural vulnerabilities that enable financial exploitation in DeFi environments.

These vulnerabilities may allow attackers to:

- Mint unlimited tokens
- Impersonate legitimate cryptocurrencies
- Execute privileged functions without authorization
- Transfer ownership without validation
- Withdraw funds without access control

SmartGuard was developed to automatically detect these high-risk patterns using static analysis techniques.

---

## 🚀 Key Features

SmartGuard provides:

- Static analysis of Solidity smart contracts
- Custom vulnerability detectors
- Integration with the Slither analysis framework
- Automated evaluation workflow
- False positive validation against legitimate contracts
- Reproducible experimental dataset
- Demonstration script for validation
- Academic research implementation

---

## 🧠 SmartGuard Detectors

SmartGuard implements three custom vulnerability detectors.

| Detector | Identifier | Severity | Description |
|----------|-----------|----------|-------------|
| UnlimitedMint | `unlimited-mint` | HIGH | Detects mint functions without supply limits or authorization controls |
| FakeTokenName | `fake-token-name` | MEDIUM | Detects contracts impersonating well-known cryptocurrency tokens |
| UnprotectedCriticalFunction | `unprotected-critical-function` | HIGH | Detects sensitive administrative functions callable without access control |

---

## 🏗 System Architecture

SmartGuard integrates with the Slither static analysis engine.


Smart Contract
│
▼
Slither Parser
│
▼
Abstract Syntax Tree (AST)
│
▼
SmartGuard Detectors
│
▼
Vulnerability Findings


---

## 📊 Evaluation Results

SmartGuard was evaluated using a dataset containing both fraudulent and legitimate smart contracts.

### Dataset Composition

- 7 fraudulent contracts  
- 10 legitimate contracts  
- **Total: 17 contracts**

### Performance Metrics

| Metric | Result |
|-------|-------|
| True Positives | 25 |
| True Negatives | 10 |
| False Positives | 0 |
| False Negatives | 0 |
| Precision | 100% |
| Recall | 100% |
| F1-Score | 100% |

These results demonstrate reliable detection performance with zero false positives in the evaluation dataset.

---

## 📁 Repository Structure


SmartGuard/
│
├── contracts/
│ ├── scam/
│ │ ├── test_mint.sol
│ │ ├── scam_fake_eth.sol
│ │ ├── vulnerable_owner.sol
│ │ └── external/
│ │ ├── stratos_unlimited.sol
│ │ └── rugdoc/
│
│ └── legit/
│ └── openzeppelin/
│
├── detectors/
│ ├── unlimited_mint.py
│ ├── fake_token_name.py
│ └── unprotected_critical_function.py
│
├── results/
│ ├── baseline/
│ ├── extended/
│ └── json/
│
├── demo.ps1
├── setup.py
└── README.md


---

## ⚙ Requirements

The following software must be installed before running SmartGuard:

- Python 3.10  
- Slither 0.11.5  
- Solidity compiler 0.8.0  
- PowerShell or Linux terminal  

---

## 🛠 Installation

Clone the repository:

```powershell
git clone https://github.com/CodeEvent/SmartGuard.git
cd SmartGuard

Create a virtual environment:

py -m venv venv
.\venv\Scripts\Activate.ps1

Install dependencies:

pip install slither-analyzer solc-select -e .

Install Solidity compiler:

solc-select install 0.8.0
solc-select use 0.8.0
✅ Verification

Verify installation:

python --version
slither --version
slither --list-detectors

Expected output should include:

unlimited-mint
fake-token-name
unprotected-critical-function
▶ Usage

Run SmartGuard detection on a smart contract:

slither contracts/scam/test_mint.sol --detect unlimited-mint,fake-token-name,unprotected-critical-function
🎬 Demonstration

Run the automated demonstration script:

.\demo.ps1

The demonstration performs:

Detector registration verification
Baseline Slither analysis
SmartGuard detection execution
False positive validation
🔬 Reproducibility

All experimental results can be reproduced using:

The provided dataset
SmartGuard detectors
The demonstration script
The documented evaluation workflow

This ensures:

Transparency
Scientific validity
Academic integrity
⚠ Limitations

SmartGuard currently focuses on business-logic vulnerabilities and does not detect:

Reentrancy vulnerabilities
Integer overflow
Gas optimization issues
Runtime execution vulnerabilities
🔮 Future Work

Future development may include:

Dynamic analysis integration
Machine learning classification
Real-time blockchain monitoring
Expanded vulnerability detection coverage
🧰 Technologies Used
Python
Solidity
Slither
Static Analysis
Abstract Syntax Tree Analysis
OpenZeppelin Contracts
PowerShell
👨‍💻 Author

Ermand Mani
BEng (Hons) Cyber Security
University of the West of Scotland

🎓 Academic Context

This project was developed as part of an undergraduate honours dissertation in cybersecurity.

Research objective:

To design, implement, and evaluate a static analysis system capable of detecting fraudulent smart contract behaviour in decentralised finance environments.

📄 License

This project is provided for academic and research purposes.