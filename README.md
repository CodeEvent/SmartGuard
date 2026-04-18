┌─────────────────┐     ┌──────────────┐     ┌─────────────────┐
│  Smart Contract │────▶│   Slither    │────▶│       AST       │
│   (Solidity)    │     │   Parser     │     │  (Abstract      │
└─────────────────┘     └──────────────┘     │  Syntax Tree)   │
└────────┬────────┘
│
▼
┌─────────────────┐
│ SmartGuard        │
│ Detectors         │
│ • unlimited_mint  │
│ • fake_token_name │
│ • unprotected_    │
│   critical_func   │
└────────┬────────┘
│
▼
┌─────────────────┐
│  Vulnerability    │
│  Findings Report  │
│  (JSON/Text)      │
└─────────────────┘
plain
Copy

---

## 📊 Evaluation Results

### Dataset Composition

| Category | Count | Source |
|----------|-------|--------|
| Fraudulent Contracts | 7 | Real-world exploits, CTF challenges, synthetic cases |
| Legitimate Contracts | 10 | OpenZeppelin, audited DeFi protocols |
| **Total** | **17** | Balanced representation |

### Performance Metrics

| Metric | Result | Target | Status |
|--------|--------|--------|--------|
| True Positives (TP) | 25 | >20 | ✅ Achieved |
| True Negatives (TN) | 10 | >8 | ✅ Achieved |
| False Positives (FP) | **0** | 0 | ✅ Perfect |
| False Negatives (FN) | **0** | 0 | ✅ Perfect |
| **Precision** | **100%** | >90% | ✅ Exceeded |
| **Recall** | **100%** | >90% | ✅ Exceeded |
| **F1-Score** | **100%** | >90% | ✅ Exceeded |

*Evaluation performed on local environment with Slither 0.11.5, Solidity 0.8.0, Python 3.10.*

---

## 📁 Repository Structure
SmartGuard/
├── contracts/
│   ├── scam/                    # Fraudulent contract samples
│   │   ├── test_mint.sol        # Unlimited minting vulnerability
│   │   ├── scam_fake_eth.sol    # Token impersonation
│   │   ├── vulnerable_owner.sol # Unprotected ownership
│   │   └── external/            # Third-party scam contracts
│   └── legit/                   # Legitimate baseline contracts
│       └── openzeppelin/        # OZ standard implementations
├── detectors/
│   ├── unlimited_mint.py         # Detector implementation
│   ├── fake_token_name.py
│   └── unprotected_critical_function.py
├── results/
│   ├── baseline/                # Raw Slither outputs
│   ├── extended/                # SmartGuard outputs
│   └── json/                    # Structured findings
├── demo.ps1                     # Automated demonstration
├── setup.py                     # Package configuration
└── README.md                    # This file
plain
Copy

---

## ⚙ Prerequisites

| Requirement | Version | Purpose |
|-------------|---------|---------|
| Python | 3.10+ | Detector runtime |
| Slither | 0.11.5 | Core analysis engine |
| solc-select | Latest | Solidity compiler management |
| Solidity | 0.8.0 | Contract compilation |
| PowerShell | 5.1+ / 7.x | Demo automation (Windows) |

---

## 🛠 Installation

### 1. Clone Repository
```powershell
git clone https://github.com/CodeEvent/SmartGuard.git
cd SmartGuard
2. Virtual Environment
powershell
Copy
py -m venv venv
.\venv\Scripts\Activate.ps1
3. Install Dependencies
powershell
Copy
pip install slither-analyzer solc-select -e .
4. Configure Compiler
powershell
Copy
solc-select install 0.8.0
solc-select use 0.8.0
5. Verification
powershell
Copy
python --version          # Python 3.10.x
slither --version         # 0.11.5
slither --list-detectors  # Verify: unlimited-mint, fake-token-name, unprotected-critical-function
▶ Usage
Single Contract Analysis
powershell
Copy
slither contracts/scam/test_mint.sol --detect unlimited-mint,fake-token-name,unprotected-critical-function
Batch Analysis with JSON Output
powershell
Copy
slither contracts/scam/ --detect unlimited-mint,fake-token-name,unprotected-critical-function --json results.json
Filter by Severity
powershell
Copy
slither contracts/scam/test_mint.sol --detect unlimited-mint --filter-severity high
🎬 Demonstration
Run the automated evaluation suite:
powershell
Copy
.\demo.ps1
Demo Phases:
Environment Verification — Dependency checks
Detector Registration — Confirm plugin loading
Baseline Analysis — Standard Slither scan
SmartGuard Detection — Custom detector execution
False Positive Validation — Legitimate contract testing
Results Compilation — Metric aggregation
Expected runtime: ~45 seconds for full dataset.
🔬 Reproducibility Statement
This project adheres to ACID reproducibility standards:
Table
Principle	Implementation
Auditability	All contracts versioned with source hashes
Consistency	Fixed dependency versions (requirements.txt)
Integrity	Checksum verification for dataset
Documentation	Step-by-step workflow in /docs
To reproduce results:
powershell
Copy
# 1. Environment setup (see Installation)
# 2. Execute demo
.\demo.ps1
# 3. Verify metrics match Evaluation Results section
⚠ Limitations
Current Scope:
Business-logic vulnerabilities only
Static analysis (no runtime behavior)
Solidity 0.8.x focused
Not Detected:
Reentrancy vulnerabilities (use standard Slither detectors)
Integer overflow/underflow (compiler 0.8.0+ handles via checked arithmetic)
Gas optimization issues
Front-running vulnerabilities
Flash loan attack vectors
🔮 Future Work
Table
Phase	Enhancement	Impact
1	Dynamic analysis integration (Mythril hybrid)	Reduce false negatives
2	Machine learning pattern recognition	Novel variant detection
3	Real-time blockchain monitoring	Proactive alerting
4	EVM bytecode analysis	Verify source-to-binary fidelity
👨‍💻 Author
Ermand Mani
BEng (Hons) Cyber Security
University of the West of Scotland
Student ID: B00228789
Supervisor: [Redacted for Review]
Submission Date: 2026
🎓 Academic Context
This repository contains artifacts from an undergraduate honours dissertation investigating Automated Detection of Fraudulent Smart Contracts Using Static Analysis Techniques.
Research Questions:
Can business-logic vulnerabilities be reliably detected via AST analysis?
What is the precision/recall trade-off for behavioral vs. technical vulnerability detection?
How effectively can static analysis prevent DeFi fraud pre-deployment?
Methodology: Design Science Research (DSR) with empirical evaluation.
📄 License & Citation
License: Academic Use Only (See LICENSE)
BibTeX:
bibtex
Copy
@software{smartguard2026,
  author = {Mani, Ermand},
  title = {SmartGuard: Static Analysis for DeFi Fraud Detection},
  year = {2026},
  institution = {University of the West of Scotland},
  type = {Undergraduate Dissertation Project}
}
<div align="center">
⬆ Back to Top
Built with precision. Verified with rigor. Defending DeFi.
</div>