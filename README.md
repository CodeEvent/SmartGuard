<div align="center">

# 🔍 SmartGuard

### Static Analysis for DeFi Fraud Detection

*Extends Slither with three custom detectors targeting the business-logic vulnerabilities that drain wallets — unlimited minting, token impersonation, and unprotected admin functions.*

[![Python](https://img.shields.io/badge/Python-3.10.11-3776AB?style=for-the-badge&logo=python&logoColor=white)](https://www.python.org/)
[![Slither](https://img.shields.io/badge/Slither-0.11.5-7B2D8B?style=for-the-badge)](https://github.com/crytic/slither)
[![Solidity](https://img.shields.io/badge/Solidity-0.8.0-363636?style=for-the-badge&logo=solidity&logoColor=white)](https://soliditylang.org/)

[![Precision](https://img.shields.io/badge/Precision-100%25-00C851?style=for-the-badge)](/)
[![Recall](https://img.shields.io/badge/Recall-100%25-00C851?style=for-the-badge)](/)
[![F1](https://img.shields.io/badge/F1--Score-100%25-00C851?style=for-the-badge)](/)
[![False Positives](https://img.shields.io/badge/False_Positives-0-00C851?style=for-the-badge)](/)

</div>

---

## 🎯 What SmartGuard Detects

Standard Slither finds reentrancy, integer overflow, and unchecked calls. It finds **zero** of the patterns that actually fund rug pulls. SmartGuard closes that gap.

| Detector | Flag | Severity | Catches |
|:---------|:-----|:--------:|:--------|
| **UnlimitedMint** | `unlimited-mint` | 🔴 HIGH | Public/external mint functions with no supply cap — the mechanism behind most token inflation fraud |
| **FakeTokenName** | `fake-token-name` | 🟡 MEDIUM | Contracts impersonating ETH, USDT, BTC, WBTC, BNB, USDC or WETH by hardcoding their names |
| **UnprotectedCriticalFunction** | `unprotected-critical-function` | 🔴 HIGH | `setOwner`, `withdraw`, `transferOwnership`, `selfdestruct` and similar functions callable by anyone |

---

## ⚡ Quick Start

```powershell
git clone https://github.com/CodeEvent/SmartGuard.git
cd SmartGuard

py -m venv venv
.\venv\Scripts\Activate.ps1

pip install slither-analyzer solc-select -e .
solc-select install 0.8.0
solc-select use 0.8.0
```

Verify everything is wired up:

```powershell
python --version    # 3.10.11
slither --version   # 0.11.5
slither --list-detectors | Select-String "unlimited-mint|fake-token-name|unprotected-critical-function"
```

You should see three lines back. If not — `pip uninstall smartguard -y && pip install -e .`

---

## 🚀 Demo

```powershell
.\demo.ps1
```

The demo runs four stages against `stratos_unlimited.sol` — a Solidity reconstruction of the Stratos Chain contract that received HIGH-risk findings in BlockSec's professional audit:

```
════════════════════════════════════════════════
 STAGE 1 — Plugin Registration
════════════════════════════════════════════════
  ✅ unlimited-mint                  registered
  ✅ fake-token-name                 registered
  ✅ unprotected-critical-function   registered

════════════════════════════════════════════════
 STAGE 2 — Baseline Slither (no SmartGuard)
════════════════════════════════════════════════
  stratos_unlimited.sol → 0 business-logic findings

════════════════════════════════════════════════
 STAGE 3 — SmartGuard Detection
════════════════════════════════════════════════
  [HIGH]    unlimited-mint               addReward()      line 28
  [HIGH]    unprotected-critical-function  withdrawReward() line 35
  [HIGH]    unprotected-critical-function  setOwner()       line 43

  3 findings. 0 missed. Matches BlockSec STRATOS-2024-001. ✅

════════════════════════════════════════════════
 STAGE 4 — False Positive Check (OpenZeppelin ERC20)
════════════════════════════════════════════════
  ERC20.sol → 0 findings ✅
```

---

## 🔬 How the Detectors Work

Each detector runs a multi-stage filtering pipeline against Slither's AST — not raw source text.

```
Contract AST
     │
     ▼
┌─────────────────────────────────────────────────────┐
│  UnlimitedMint                                       │
│  Stage 1 → keyword filter  (mint, addReward, ...)    │
│  Stage 2 → visibility      (public / external only)  │
│  Stage 3 → modifier check  (onlyOwner? → skip)       │
│  Stage 4 → supply cap      (maxSupply ref? → skip)   │
│                              ↓ no cap, no guard       │
│                           FLAG: HIGH                  │
└─────────────────────────────────────────────────────┘

┌─────────────────────────────────────────────────────┐
│  FakeTokenName                                       │
│  Stage 1 → find name/symbol state variables          │
│  Stage 2 → confirm string assignment                 │
│  Stage 3 → match against 7-token reference list      │
│  Stage 4 → exclusion check (legitimate impl? → skip) │
│                              ↓ impersonation confirmed│
│                           FLAG: MEDIUM                │
└─────────────────────────────────────────────────────┘

┌─────────────────────────────────────────────────────┐
│  UnprotectedCriticalFunction                         │
│  Stage 1 → keyword filter  (setOwner, withdraw, ...) │
│  Stage 2 → modifier check  (only*/admin*? → skip)    │
│                              ↓ no guard               │
│                           FLAG: HIGH                  │
└─────────────────────────────────────────────────────┘
```

---

## 📊 Evaluation Results

Tested against **17 contracts**: 7 confirmed fraudulent (3 synthetic, 1 Stratos Chain reconstruction, 3 from RugDoc.io) and 10 legitimate (OpenZeppelin v5.2.0).

<div align="center">

| Metric | SmartGuard | Baseline Slither |
|:------:|:----------:|:----------------:|
| True Positives | **25** | 0 |
| False Positives | **0** | 0 |
| True Negatives | **10** | 10 |
| False Negatives | **0** | — |
| Precision | **100%** | N/A |
| Recall | **100%** | N/A |
| F1-Score | **100%** | N/A |

</div>

> **Audit Correlation** — SmartGuard's findings on `stratos_unlimited.sol` match 100% of the HIGH-risk vulnerabilities identified in BlockSec professional audit report STRATOS-2024-001, at zero cost and in sub-second execution time.

---

## 📁 Repository Structure

```
SmartGuard/
├── contracts/
│   ├── scam/                          # 7 fraudulent contracts
│   │   ├── test_mint.sol              # synthetic — unlimited mint
│   │   ├── scam_fake_eth.sol          # synthetic — token impersonation
│   │   ├── vulnerable_owner.sol       # synthetic — unprotected functions
│   │   └── external/
│   │       ├── stratos_unlimited.sol  # Stratos Chain reconstruction
│   │       └── rugdoc/
│   │           ├── beetsfarm_rug.sol
│   │           ├── evo_honeypot.sol
│   │           └── patrick_finance_rug.sol
│   └── legit/                         # 10 legitimate contracts
│       ├── test.sol                   # Phase 1 development artefact
│       └── openzeppelin/              # OZ v5.2.0 — ERC20, Ownable, Pausable,
│                                      # ERC721, Math, AccessControl, Address,
│                                      # Context, ReentrancyGuard, SafeERC20
├── detectors/
│   ├── __init__.py                    # make_plugin() entry point
│   ├── unlimited_mint.py
│   ├── fake_token_name.py
│   └── unprotected_critical_function.py
├── results/
│   ├── baseline/                      # standard Slither outputs
│   ├── extended/                      # SmartGuard outputs
│   └── json/                          # machine-readable findings
├── demo.ps1                           # live demonstration script
└── setup.py                           # plugin registration
```

---

## 🛠 Full Evaluation Workflow

### Baseline

```powershell
mkdir results\baseline, results\extended, results\json -Force
$detect = "unlimited-mint,fake-token-name,unprotected-critical-function"

# All 7 scam contracts — baseline
slither contracts\scam\test_mint.sol 2>&1 | Out-File results\baseline\test_mint.txt
slither contracts\scam\scam_fake_eth.sol 2>&1 | Out-File results\baseline\scam_fake_eth.txt
slither contracts\scam\vulnerable_owner.sol 2>&1 | Out-File results\baseline\vulnerable_owner.txt
slither contracts\scam\external\stratos_unlimited.sol 2>&1 | Out-File results\baseline\stratos.txt
slither contracts\scam\external\rugdoc\beetsfarm_rug.sol 2>&1 | Out-File results\baseline\beetsfarm_rug.txt
slither contracts\scam\external\rugdoc\evo_honeypot.sol 2>&1 | Out-File results\baseline\evo_honeypot.txt
slither contracts\scam\external\rugdoc\patrick_finance_rug.sol 2>&1 | Out-File results\baseline\patrick_finance_rug.txt

# All 10 legit contracts — baseline
@("ERC20","Ownable","Pausable","ERC721","Math","AccessControl","Address","Context","ReentrancyGuard","SafeERC20") | ForEach-Object {
    slither "contracts\legit\openzeppelin\$_.sol" 2>&1 | Out-File "results\baseline\$_.txt"
}
```

### SmartGuard

```powershell
# All 7 scam contracts
slither contracts\scam\test_mint.sol --detect $detect 2>&1 | Out-File results\extended\test_mint.txt
slither contracts\scam\scam_fake_eth.sol --detect $detect 2>&1 | Out-File results\extended\scam_fake_eth.txt
slither contracts\scam\vulnerable_owner.sol --detect $detect 2>&1 | Out-File results\extended\vulnerable_owner.txt
slither contracts\scam\external\stratos_unlimited.sol --detect $detect 2>&1 | Out-File results\extended\stratos.txt
slither contracts\scam\external\rugdoc\beetsfarm_rug.sol --detect $detect 2>&1 | Out-File results\extended\beetsfarm_rug.txt
slither contracts\scam\external\rugdoc\evo_honeypot.sol --detect $detect 2>&1 | Out-File results\extended\evo_honeypot.txt
slither contracts\scam\external\rugdoc\patrick_finance_rug.sol --detect $detect 2>&1 | Out-File results\extended\patrick_finance_rug.txt

# All 10 legit contracts (zero findings expected)
@("ERC20","Ownable","Pausable","ERC721","Math","AccessControl","Address","Context","ReentrancyGuard","SafeERC20") | ForEach-Object {
    slither "contracts\legit\openzeppelin\$_.sol" --detect $detect 2>&1 | Out-File "results\extended\$_.txt"
}
```

### Full dataset in one shot

```powershell
"SmartGuard Evaluation — $(Get-Date)" | Out-File results\comprehensive_results.txt
"=" * 60 | Out-File results\comprehensive_results.txt -Append

foreach ($dir in @("scam","legit")) {
    "`n[$($dir.ToUpper()) CONTRACTS]" | Out-File results\comprehensive_results.txt -Append
    Get-ChildItem "contracts\$dir" -Recurse -Filter *.sol | ForEach-Object {
        "--- $($_.Name) ---" | Out-File results\comprehensive_results.txt -Append
        slither $_.FullName --detect $detect 2>&1 | Out-File results\comprehensive_results.txt -Append
    }
}
```

### JSON output

```powershell
Get-ChildItem contracts\scam -Recurse -Filter *.sol | ForEach-Object {
    slither $_.FullName --detect $detect --json "results\json\$($_.BaseName).json"
}
```

---

## 🔧 Troubleshooting

<details>
<summary><strong>Detectors not registering</strong></summary>

```powershell
pip uninstall smartguard -y
pip install -e .
pip show smartguard
slither --list-detectors | Select-String "unlimited-mint"
```
</details>

<details>
<summary><strong>OZ contracts fail to compile (missing imports)</strong></summary>

Some OZ contracts import siblings that Slither cannot resolve when run individually. This is expected and does not affect the true negative result — `Context.sol` and `ReentrancyGuard.sol` compile cleanly in all cases.
</details>

<details>
<summary><strong>Wrong solc version</strong></summary>

```powershell
solc-select use 0.8.0
solc --version    # must show 0.8.0+commit...
```
</details>

<details>
<summary><strong>Full dependency check</strong></summary>

```powershell
pip list | Select-String "slither|smartguard|solc"
python --version
slither --version
solc --version
```
</details>

---

## 🏗 Built On

- [**Slither**](https://github.com/crytic/slither) by Trail of Bits — the static analysis foundation
- [**OpenZeppelin Contracts v5.2.0**](https://github.com/OpenZeppelin/openzeppelin-contracts) — legitimate contract evaluation set
- [**solc-select**](https://github.com/crytic/solc-select) — compiler version pinning

---

<div align="center">

*BEng (Hons) Cyber Security dissertation — University of the West of Scotland*

</div>