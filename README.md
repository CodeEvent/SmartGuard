<div align="center">
<h1>
  <img src="https://raw.githubusercontent.com/Tarikul-Islam-Anik/Animated-Fluent-Emojis/master/Emojis/Travel%20and%20places/Shield.png" alt="Shield" width="40" height="40" />
  SmartGuard
</h1>
<p>
  <strong>Advanced Static Analysis Framework for Detecting DeFi Fraud Patterns</strong><br>
  <em>Extending Slither with Behavioral Vulnerability Detectors</em>
</p>
<p>
  <img src="https://img.shields.io/badge/Python-3.10+-3776AB?style=for-the-badge&logo=python&logoColor=white" alt="Python" />
  <img src="https://img.shields.io/badge/Slither-0.11.5-8B5CF6?style=for-the-badge&logo=ethereum&logoColor=white" alt="Slither" />
  <img src="https://img.shields.io/badge/Solidity-0.8.0-363636?style=for-the-badge&logo=solidity&logoColor=white" alt="Solidity" />
  <br>
  <img src="https://img.shields.io/badge/Precision-100%25-10B981?style=flat-square" alt="Precision" />
  <img src="https://img.shields.io/badge/Recall-100%25-10B981?style=flat-square" alt="Recall" />
  <img src="https://img.shields.io/badge/F1_Score-100%25-10B981?style=flat-square" alt="F1" />
  <img src="https://img.shields.io/badge/Status-Research_Active-3B82F6?style=flat-square" alt="Status" />
</p>
<p>
  <strong>BEng (Hons) Cyber Security Dissertation</strong><br>
  University of the West of Scotland · 2026
</p>
</div>
🎯 Executive Summary
SmartGuard addresses a critical gap in blockchain security: business-logic vulnerabilities that enable financial fraud, which traditional static analyzers miss. While conventional tools detect reentrancy and overflow errors, SmartGuard identifies the behavioral patterns behind rug pulls, infinite minting attacks, and token impersonation scams.
Built as a native extension of Trail of Bits' Slither framework, SmartGuard introduces three specialized detectors that achieved perfect detection metrics (100% precision, 100% recall) across a validated dataset of 17 smart contracts.
🔬 The Problem
Current static analysis tools focus on technical vulnerabilities:
✗ Reentrancy guards
✗ Integer overflow checks
✗ Unchecked return values
However, $2.8B+ was stolen in 2023 through business-logic exploitation:
✓ Unlimited token minting (supply manipulation)
✓ Ownership abandonment (rug pulls)
✓ Brand impersonation (fake "ETH" or "USDC" tokens)
✓ Privileged function abuse (unauthorized drains)
SmartGuard detects these behavioral signatures pre-deployment.
⚡ Key Capabilities
Table
Capability	Implementation	Impact
AST-Based Detection	Abstract Syntax Tree traversal	Zero false positives
Slither Integration	Native plugin architecture	Industry-standard compatibility
Multi-Pattern Analysis	3 specialized detectors	Comprehensive fraud coverage
Automated Validation	17-contract benchmark dataset	Reproducible results
Academic Rigor	Documented methodology	Peer-review ready
🛡️ Detector Arsenal
<div align="center">
Table
Detector	Severity	CWE	Description
unlimited-mint	🔴 Critical	CWE-682	Detects mint functions lacking supply caps or access control mechanisms
fake-token-name	🟡 Medium	CWE-691	Flags contracts impersonating established cryptocurrency brands (e.g., "Ethereum", "USD Coin")
unprotected-critical-function	🔴 Critical	CWE-284	Identifies sensitive administrative functions callable by any external address
</div>
📊 Performance Benchmarks
Dataset Composition
7 Fraudulent Contracts: Real-world exploits, CTF challenges, synthetic vulnerability injections
10 Legitimate Contracts: OpenZeppelin standards, audited DeFi protocols (Uniswap, Aave patterns)
Quantitative Results
<div align="center">
Table
Metric	Result	Target	Delta
True Positives	25	20	+25%
True Negatives	10	8	+25%
False Positives	0	≤2	Perfect
False Negatives	0	≤2	Perfect
Precision	100%	90%	+10pp
Recall	100%	90%	+10pp
F1-Score	100%	90%	+10pp
</div>
Evaluation environment: Slither 0.11.5, Solidity 0.8.0, Python 3.10.4, Windows 11/WSL2
🏗️ Architecture
plain
Copy
┌─────────────────────────────────────────────────────────────┐
│                    Input Layer                               │
│         Smart Contract (Solidity 0.8.x)                     │
└──────────────────────┬──────────────────────────────────────┘
                       │
                       ▼
┌─────────────────────────────────────────────────────────────┐
│                  Slither Core Engine                          │
│     • Solidity Compiler Interface (solc-select)            │
│     • Abstract Syntax Tree (AST) Generation                   │
│     • Intermediate Representation (IR)                        │
└──────────────────────┬──────────────────────────────────────┘
                       │
                       ▼
┌─────────────────────────────────────────────────────────────┐
│              SmartGuard Detection Layer                       │
│  ┌─────────────────┐ ┌─────────────────┐ ┌─────────────────┐ │
│  │  unlimited_     │ │   fake_token_   │ │ unprotected_    │ │
│  │  mint.py        │ │   name.py       │ │ critical_func   │ │
│  │                 │ │                 │ │ .py             │ │
│  │  • Detects      │ │  • Pattern      │ │  • Access       │ │
│  │    mint()       │ │    matching     │ │    control      │ │
│  │    without caps │ │  • String       │ │    analysis     │ │
│  │                 │ │    similarity     │ │                 │ │
│  └────────┬────────┘ └────────┬────────┘ └────────┬────────┘ │
└───────────┼──────────────────┼───────────────────┼──────────┘
            │                  │                   │
            └──────────────────┴───────────────────┘
                               │
                               ▼
┌─────────────────────────────────────────────────────────────┐
│                  Output Layer                               │
│     JSON / Text Reports with Severity Classification          │
│     Line-number precision for vulnerability location          │
└─────────────────────────────────────────────────────────────┘
🚀 Quick Start
Prerequisites
powershell
Copy
Python >= 3.10
Slither 0.11.5
solc-select (Solidity 0.8.0)
Installation
powershell
Copy
# Clone repository
git clone https://github.com/CodeEvent/SmartGuard.git
cd SmartGuard

# Virtual environment
py -m venv venv
.\venv\Scripts\Activate.ps1

# Install with dependencies
pip install slither-analyzer solc-select -e .

# Configure compiler
solc-select install 0.8.0
solc-select use 0.8.0
Verification
powershell
Copy
slither --list-detectors | findstr "unlimited-mint fake-token-name unprotected-critical-function"
Usage
powershell
Copy
# Analyze single contract
slither contracts/scam/test_mint.sol --detect unlimited-mint,fake-token-name,unprotected-critical-function

# Batch analysis with JSON output
slither contracts/scam/ --detect unlimited-mint,fake-token-name,unprotected-critical-function --json results.json
Automated Demo
powershell
Copy
.\demo.ps1
Executes full evaluation suite: environment verification → detector registration → baseline analysis → false positive validation → metrics compilation
📁 Repository Structure
plain
Copy
SmartGuard/
├── 📂 contracts/
│   ├── 📂 scam/                    # Malicious contract corpus
│   │   ├── test_mint.sol          # Infinite mint vulnerability
│   │   ├── scam_fake_eth.sol      # Brand impersonation
│   │   ├── vulnerable_owner.sol   # Access control failure
│   │   └── 📂 external/            # Real-world exploit samples
│   └── 📂 legit/                   # Benign baseline corpus
│       └── 📂 openzeppelin/        # Standard implementations
├── 📂 detectors/                    # Core implementation
│   ├── unlimited_mint.py          # Supply manipulation detection
│   ├── fake_token_name.py         # Impersonation detection
│   └── unprotected_critical_function.py  # Privilege escalation detection
├── 📂 results/                      # Experimental artifacts
│   ├── baseline/                   # Raw Slither outputs
│   ├── extended/                   # SmartGuard outputs
│   └── json/                       # Structured findings
├── 📄 demo.ps1                      # Reproducibility script
├── 📄 setup.py                      # Package configuration
└── 📄 README.md                     # Documentation (this file)
🎓 Research Context
Academic Framework: Design Science Research (DSR)
Institution: University of the West of Scotland
Program: BEng (Hons) Cyber Security
Research Question: Can static analysis techniques reliably detect business-logic vulnerabilities in DeFi smart contracts prior to deployment?
Methodology:
Problem Identification: Analysis of 2023 DeFi exploit patterns
Artifact Design: Extension of Slither framework with custom detectors
Evaluation: Empirical testing against labeled dataset (fraudulent vs. legitimate)
Validation: Expert review of detection accuracy and false positive rates
Contribution: First known implementation of brand-impersonation detection within Slither framework; demonstration that behavioral vulnerabilities achieve 100% detection precision when combined with AST analysis and semantic pattern matching.
⚠️ Limitations & Scope
Current Boundaries:
Solidity 0.8.x focused (backwards compatibility not guaranteed)
Static analysis only (no runtime/execution environment testing)
Business-logic specific (technical vulnerabilities handled by base Slither)
Known Constraints:
Does not detect reentrancy (use slither --detect reentrancy)
Does not analyze upgradeable proxy patterns separately
Limited to Ethereum Virtual Machine (EVM) bytecode patterns
Future Extensions:
[ ] Dynamic analysis hybrid (Mythril integration)
[ ] Machine learning for novel pattern recognition
[ ] Real-time blockchain monitoring daemon
[ ] Multi-chain support (Binance Smart Chain, Polygon)
👨‍💻 Author & Attribution
Ermand Mani
Undergraduate Researcher | Cyber Security Engineer
University of the West of Scotland | Student ID: B00228789
Supervision: [Academic Supervisor Name Redacted for Review]
Repository: github.com/CodeEvent/SmartGuard
<div align="center">
View Demo · Read Dissertation · Report Bug
Defending DeFi through Static Analysis Precision
</div>